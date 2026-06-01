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

