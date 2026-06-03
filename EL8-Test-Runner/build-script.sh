#!/usr/bin/env bash
#
# Bootstrap AlmaLinux/RHEL/CentOS 8 with PHP 8.5, Composer, Gherkin (Behat),
# Google Chrome, ChromeDriver, and Selenium Grid (systemd).
#
# Usage (as root):
#   curl -O .../install-el8-selenium-php-stack.sh   # or copy to the host
#   chmod +x install-el8-selenium-php-stack.sh
#   ./install-el8-selenium-php-stack.sh
#
set -euo pipefail

if [[ "${EUID:-0}" -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

SELENIUM_VERSION="${SELENIUM_VERSION:-4.32.0}"
INSTALL_GLOBAL_BEHAT="${INSTALL_GLOBAL_BEHAT:-1}"

log() { printf '\n==> %s\n' "$*"; }
run() { log "$*"; "$@"; }

# ---------------------------------------------------------------------------
# Base OS packages and repositories
# ---------------------------------------------------------------------------
log "Installing EPEL, Remi, and base tools"
run dnf -y install epel-release
run dnf -y install "https://rpms.remirepo.net/enterprise/remi-release-8.rpm"
run dnf -y install wget curl unzip tar

# ---------------------------------------------------------------------------
# PHP 8.5 (Remi) and Composer
# ---------------------------------------------------------------------------
log "Installing PHP 8.5 and extensions"
run dnf -y install \
  php85 php85-php-cli php85-php-common php85-php-fpm php85-php-gd \
  php85-php-intl php85-php-mbstring php85-php-xml php85-php-pear \
  php85-php-process php85-php-soap php85-php-opcache \
  php85-php-bcmath php85-php-pdo php85-php-mysqlnd \
  php85-php-pecl-zip

log "Installing Composer"
run dnf -y install composer

# Prefer PHP 8.5 when both AppStream PHP and php85 are present
if command -v alternatives >/dev/null 2>&1; then
  PHP85_BIN="/opt/remi/php85/root/usr/bin/php"
  if [[ -x "$PHP85_BIN" ]]; then
    alternatives --set php "$PHP85_BIN" 2>/dev/null || true
  fi
fi

# ---------------------------------------------------------------------------
# Java (Selenium) and Google Chrome
# ---------------------------------------------------------------------------
log "Installing Java 21 (OpenJDK)"
run dnf -y install java-21-openjdk java-21-openjdk-headless

log "Adding Google Chrome repository"
install -d -m 0755 /etc/yum.repos.d
cat >/etc/yum.repos.d/google-chrome.repo <<'EOF'
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

log "Installing Google Chrome"
run dnf -y install google-chrome-stable

# ---------------------------------------------------------------------------
# ChromeDriver (matched to installed Chrome major version)
# ---------------------------------------------------------------------------
log "Installing ChromeDriver (Chrome for Testing)"
CHROME_VERSION="$(google-chrome --version | awk '{print $3}')"
CHROME_MAJOR="${CHROME_VERSION%%.*}"
DRIVER_VERSION="$(curl -fsSL "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${CHROME_MAJOR}")"
DRIVER_ZIP="/tmp/chromedriver-linux64.zip"

curl -fsSL -o "$DRIVER_ZIP" \
  "https://storage.googleapis.com/chrome-for-testing-public/${DRIVER_VERSION}/linux64/chromedriver-linux64.zip"
unzip -o "$DRIVER_ZIP" -d /opt/
ln -sf /opt/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
ln -sf /opt/chromedriver-linux64/chromedriver /usr/bin/chromedriver
chmod +x /opt/chromedriver-linux64/chromedriver

# ---------------------------------------------------------------------------
# Selenium standalone server + systemd service
# ---------------------------------------------------------------------------
log "Installing Selenium ${SELENIUM_VERSION}"
install -d -m 0755 /opt/selenium

cat >/usr/bin/download-selenium <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <selenium-version>" >&2
  echo "Example: $0 4.32.0" >&2
  exit 1
fi
VERSION="$1"
OUTPUT_PATH="/opt/selenium/selenium-server.jar"
URL="https://github.com/SeleniumHQ/selenium/releases/download/selenium-${VERSION}/selenium-server-${VERSION}.jar"
echo "Downloading Selenium Server ${VERSION}"
echo "  ${URL}"
mkdir -p /opt/selenium
wget -q -O "${OUTPUT_PATH}" "${URL}"
echo "Saved to ${OUTPUT_PATH}"
EOF
chmod +x /usr/local/bin/download-selenium

download-selenium "${SELENIUM_VERSION}"

id -u selenium &>/dev/null || useradd --system --create-home --shell /sbin/nologin selenium
chown -R selenium:selenium /opt/selenium

cat >/etc/systemd/system/selenium.service <<'EOF'
[Unit]
Description=Selenium Server
After=network.target

[Service]
Type=simple
User=selenium
Group=selenium
WorkingDirectory=/opt/selenium
ExecStart=/usr/bin/java -jar /opt/selenium/selenium-server.jar standalone --port 4444
Restart=always
RestartSec=5
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

run systemctl daemon-reload
run systemctl enable --now selenium

# ---------------------------------------------------------------------------
# Gherkin / Behat / php-webdriver (Composer global, optional)
# ---------------------------------------------------------------------------
if [[ "$INSTALL_GLOBAL_BEHAT" == "1" ]]; then
  log "Installing Behat + Gherkin + php-webdriver globally via Composer"
  export COMPOSER_ALLOW_SUPERUSER=1
  export COMPOSER_HOME="${COMPOSER_HOME:-/root/.composer}"
  run composer global require --no-interaction \
    behat/behat:^3.14 \
    'behat/gherkin:^4.9,<4.12' \
    php-webdriver/webdriver:^1.15

  PROFILE_SNIPPET='export PATH="$PATH:$HOME/.composer/vendor/bin:/root/.composer/vendor/bin"'
  for rc in /root/.bashrc /etc/profile.d/composer-behat.sh; do
    if [[ "$rc" == /etc/profile.d/composer-behat.sh ]]; then
      echo "$PROFILE_SNIPPET" >"$rc"
      chmod 0644 "$rc"
    elif ! grep -qF '.composer/vendor/bin' "$rc" 2>/dev/null; then
      echo "$PROFILE_SNIPPET" >>"$rc"
    fi
  done
fi

# ---------------------------------------------------------------------------
# Verification
# ---------------------------------------------------------------------------
log "Verification"
php -v
composer -V
java -version
google-chrome --version
chromedriver --version

if systemctl is-active --quiet selenium; then
  curl -fsSL http://localhost:4444/status | head -c 200
  echo ""
  echo "Selenium: active on http://localhost:4444"
else
  echo "WARNING: selenium service is not active" >&2
  systemctl status selenium --no-pager || true
fi

if [[ "$INSTALL_GLOBAL_BEHAT" == "1" ]]; then
  export PATH="$PATH:/root/.composer/vendor/bin"
  behat --version
fi

cat <<EOF

Done.

Installed:
  - PHP 8.5 (Remi) + Composer
  - Java 21 + Selenium ${SELENIUM_VERSION} (systemd: selenium)
  - Google Chrome + matching ChromeDriver
  - Behat/Gherkin/php-webdriver (global Composer tools, if enabled)

Per-project setup (example):
  composer require behat/behat behat/gherkin php-webdriver/webdriver

Headless Chrome flags for WebDriver scripts:
  --headless=new --no-sandbox --disable-dev-shm-usage

EOF
