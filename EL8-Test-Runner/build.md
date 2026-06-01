# Build for the test Runner (Selinium)

## Do initial setup tasks

It is a good idea to reboot right after this stage to load in any updated kernel modules.

```
setenforce 0

cat >/etc/selinux/config <<EOL
SELINUX=disabled
SELINUXTYPE=targeted
EOL

dnf install -y epel-release

/usr/bin/crb enable

dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

dnf install -y nano wget bind-utils net-tools git zip unzip tar 

dnf update -y
```

## Install the PHP Stuff

```
dnf install -y composer

dnf install -y php85 php85-php-cli php85-php-common php85-php-fpm php85-php-gd php85-php-intl php85-php-libvirt php85-php-mbstring php85-php-lz4 php85-php-pear

dnf install -y php85-php-ast php85-php-bcmath php85-php-ffi php85-php-pecl-imap php85-php-ldap php85-php-mysqlnd php85-php-opcache php85-php-pdo php85-php-pecl-csv

dnf install -y php85-php-pecl-env php85-php-pecl-lzf php85-php-pecl-mailparse php85-php-pecl-zip php85-php-process php85-php-soap php85-php-sodium php85-php-xml

dnf install -y php85-php-pecl-redis6

rm -f /usr/bin/php

ln -s /usr/bin/php85 /usr/bin/php
```

## Install the JAVA Runtimes 

This will be ok for a while but the JAVA version will change in the future, its just important to match it with other components

```
dnf repolist

dnf -y install dnf-plugins-core

dnf config-manager --set-enabled appstream

dnf config-manager --set-enabled crb

dnf makecache

dnf -y install java-21-openjdk java-21-openjdk-headless
```

## Now we install the Chrome runtimes

```
tee /etc/yum.repos.d/google-chrome.repo > /dev/null <<'EOF'
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

dnf -y install google-chrome-stable

CHROME_VERSION=$(google-chrome --version | awk '{print $3}')

CHROME_MAJOR=$(echo "$CHROME_VERSION" | cut -d. -f1)

DRIVER_VERSION=$(curl -s "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${CHROME_MAJOR}")

wget -O /tmp/chromedriver-linux64.zip "https://storage.googleapis.com/chrome-for-testing-public/${DRIVER_VERSION}/linux64/chromedriver-linux64.zip"

unzip -o /tmp/chromedriver-linux64.zip -d /opt/

ln -sf /opt/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver

ln -sf /opt/chromedriver-linux64/chromedriver /usr/bin/chromedriver

chmod +x /usr/local/bin/chromedriver
```

## Now we install the Selinium server

```
mkdir -p /opt/selenium

cat >/usr/bin/download-selenium <<EOL
#!/usr/bin/env bash
set -euo pipefail
# Usage:
#   ./download-selenium.sh 4.32.0
if [[ \$# -ne 1 ]]; then
  echo "Usage: \$0 <selenium-version>"
  echo "Example: \$0 4.32.0"
  exit 1
fi
VERSION="\$1"
OUTPUT_PATH="/opt/selenium/selenium-server.jar"
URL="https://github.com/SeleniumHQ/selenium/releases/download/selenium-\${VERSION}/selenium-server-\${VERSION}.jar"
echo "Downloading Selenium Server version: \${VERSION}"
echo "From: \${URL}"
echo "To:   \${OUTPUT_PATH}"
# Ensure output directory exists
mkdir -p /opt/selenium
# Download
wget -O "\${OUTPUT_PATH}" "\${URL}"
echo "Download complete."
EOL

chmod +x /usr/bin/download-selenium

download-selenium 4.32.0

useradd --system --create-home --shell /sbin/nologin selenium || true

chown -R selenium:selenium /opt/selenium

cat >/etc/systemd/system/selenium.service <<EOL
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
EOL

systemctl daemon-reload

systemctl enable --now selenium
```

