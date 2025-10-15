setenforce 0

cat >/etc/selinux/config <<EOL
SELINUX=disabled
SELINUXTYPE=targeted
EOL

fallocate -l 8G /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

cat >>/etc/fstab <<EOL
/swapfile swap swap defaults 0 0
EOL

sysctl vm.swappiness=2

echo "vm.swappiness = 2" >> /etc/sysctl.conf

dnf install -y epel-release

/usr/bin/crb enable

dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

dnf install -y nano wget bind-utils net-tools git zip unzip tar mc

dnf update -y

dnf install -y composer

dnf install -y php85 php85-php-ast php85-php-bcmath php85-php-cli php85-php-common php85-php-ffi php85-php-fpm php85-php-gd php85-php-geos php85-php-girgias-csv php85-php-intl php85-php-ldap php85-php-libvirt php85-php-lz4 php85-php-mbstring php85-php-mysqlnd php85-php-opcache php85-php-pdo php85-php-pear php85-php-pecl-env php85-php-pecl-geoip php85-php-pecl-geospatial php85-php-pecl-imagick-im7 php85-php-pecl-imap php85-php-pecl-jsonpath php85-php-pecl-mailparse php85-php-pecl-memcached php85-php-pecl-mongodb2 php85-php-pecl-oauth php85-php-pecl-redis6 php85-php-pecl-rrd php85-php-pecl-ssdeep php85-php-pecl-ssh2 php85-php-pecl-uploadprogress php85-php-pecl-uuid php85-php-pecl-xattr php85-php-pecl-xdebug3 php85-php-pecl-xdiff php85-php-pecl-xlswriter php85-php-pecl-xmldiff php85-php-pecl-yaml php85-php-pecl-zip php85-php-pecl-zmq php85-php-process php85-php-soap php85-php-sodium php85-php-xml

systemctl mask php85-php-fpm

dnf install -y php84 php84-php-ast php84-php-bcmath php84-php-cli php84-php-common php84-php-ffi php84-php-fpm php84-php-gd php84-php-geos php84-php-girgias-csv php84-php-intl php84-php-ldap php84-php-libvirt php84-php-lz4 php84-php-mbstring php84-php-mysqlnd php84-php-opcache php84-php-pdo php84-php-pear php84-php-pecl-env php84-php-pecl-geoip php84-php-pecl-geospatial php84-php-pecl-imagick-im7 php84-php-pecl-imap php84-php-pecl-jsonpath php84-php-pecl-mailparse php84-php-pecl-memcached php84-php-pecl-mongodb2 php84-php-pecl-oauth php84-php-pecl-redis6 php84-php-pecl-rrd php84-php-pecl-ssdeep php84-php-pecl-ssh2 php84-php-pecl-uploadprogress php84-php-pecl-uuid php84-php-pecl-xattr php84-php-pecl-xdebug3 php84-php-pecl-xdiff php84-php-pecl-xlswriter php84-php-pecl-xmldiff php84-php-pecl-yaml php84-php-pecl-zip php84-php-pecl-zmq php84-php-process php84-php-soap php84-php-sodium php84-php-xml

systemctl mask php84-php-fpm

dnf install -y php83 php83-php-ast php83-php-bcmath php83-php-cli php83-php-common php83-php-ffi php83-php-fpm php83-php-gd php83-php-geos php83-php-girgias-csv php83-php-intl php83-php-ldap php83-php-libvirt php83-php-lz4 php83-php-mbstring php83-php-mysqlnd php83-php-opcache php83-php-pdo php83-php-pear php83-php-pecl-env php83-php-pecl-geoip php83-php-pecl-geospatial php83-php-pecl-imagick-im7 php83-php-imap php83-php-pecl-jsonpath php83-php-pecl-mailparse php83-php-pecl-memcached php83-php-pecl-mongodb2 php83-php-pecl-oauth php83-php-pecl-redis6 php83-php-pecl-rrd php83-php-pecl-ssdeep php83-php-pecl-ssh2 php83-php-pecl-uploadprogress php83-php-pecl-uuid php83-php-pecl-xattr php83-php-pecl-xdebug3 php83-php-pecl-xdiff php83-php-pecl-xlswriter php83-php-pecl-xmldiff php83-php-pecl-yaml php83-php-pecl-zip php83-php-pecl-zmq php83-php-process php83-php-soap php83-php-sodium php83-php-xml

systemctl mask php83-php-fpm

dnf install -y php82 php82-php-ast php82-php-bcmath php82-php-cli php82-php-common php82-php-ffi php82-php-fpm php82-php-gd php82-php-geos php82-php-girgias-csv php82-php-intl php82-php-ldap php82-php-libvirt php82-php-lz4 php82-php-mbstring php82-php-mysqlnd php82-php-opcache php82-php-pdo php82-php-pear php82-php-pecl-env php82-php-pecl-geoip php82-php-pecl-geospatial php82-php-pecl-imagick-im7 php82-php-imap php82-php-pecl-jsonpath php82-php-pecl-mailparse php82-php-pecl-memcached php82-php-pecl-mongodb2 php82-php-pecl-oauth php82-php-pecl-redis6 php82-php-pecl-rrd php82-php-pecl-ssdeep php82-php-pecl-ssh2 php82-php-pecl-uploadprogress php82-php-pecl-uuid php82-php-pecl-xattr php82-php-pecl-xdebug3 php82-php-pecl-xdiff php82-php-pecl-xlswriter php82-php-pecl-xmldiff php82-php-pecl-yaml php82-php-pecl-zip php82-php-pecl-zmq php82-php-process php82-php-soap php82-php-sodium php82-php-xml

systemctl mask php82-php-fpm

dnf install -y php81 php81-php-ast php81-php-bcmath php81-php-cli php81-php-common php81-php-ffi php81-php-fpm php81-php-gd php81-php-geos php81-php-girgias-csv php81-php-intl php81-php-ldap php81-php-libvirt php81-php-lz4 php81-php-mbstring php81-php-mysqlnd php81-php-opcache php81-php-pdo php81-php-pear php81-php-pecl-env php81-php-pecl-geoip php81-php-pecl-geospatial php81-php-pecl-imagick-im7 php81-php-imap php81-php-pecl-jsonpath php81-php-pecl-mailparse php81-php-pecl-memcached php81-php-pecl-mongodb2 php81-php-pecl-oauth php81-php-pecl-redis6 php81-php-pecl-rrd php81-php-pecl-ssdeep php81-php-pecl-ssh2 php81-php-pecl-uploadprogress php81-php-pecl-uuid php81-php-pecl-xattr php81-php-pecl-xdebug3 php81-php-pecl-xdiff php81-php-pecl-xlswriter php81-php-pecl-xmldiff php81-php-pecl-yaml php81-php-pecl-zip php81-php-pecl-zmq php81-php-process php81-php-soap php81-php-sodium php81-php-xml

systemctl mask php81-php-fpm

dnf install -y php80 php80-php-ast php80-php-bcmath php80-php-cli php80-php-common php80-php-ffi php80-php-fpm php80-php-gd php80-php-geos php80-php-girgias-csv php80-php-intl php80-php-ldap php80-php-libvirt php80-php-lz4 php80-php-mbstring php80-php-mysqlnd php80-php-opcache php80-php-pdo php80-php-pear php80-php-pecl-env php80-php-pecl-geoip php80-php-pecl-geospatial php80-php-pecl-imagick-im7 php80-php-imap php80-php-pecl-jsonpath php80-php-pecl-mailparse php80-php-pecl-memcached php80-php-pecl-mongodb php80-php-pecl-oauth php80-php-pecl-redis6 php80-php-pecl-rrd php80-php-pecl-ssdeep php80-php-pecl-ssh2 php80-php-pecl-uploadprogress php80-php-pecl-uuid php80-php-pecl-xattr php80-php-pecl-xdebug3 php80-php-pecl-xdiff php80-php-pecl-xlswriter php80-php-pecl-xmldiff php80-php-pecl-yaml php80-php-pecl-zip php80-php-pecl-zmq php80-php-process php80-php-soap php80-php-sodium php80-php-xml

systemctl mask php80-php-fpm

dnf install -y php74 php74-php-ast php74-php-bcmath php74-php-cli php74-php-common php74-php-ffi php74-php-fpm php74-php-gd php74-php-geos php74-php-pecl-csv php74-php-intl php74-php-ldap php74-php-libvirt php74-php-lz4 php74-php-mbstring php74-php-mysqlnd php74-php-opcache php74-php-pdo php74-php-pear php74-php-pecl-env php74-php-pecl-geoip php74-php-pecl-geospatial php74-php-pecl-imagick-im7 php74-php-imap php74-php-pecl-jsonpath php74-php-pecl-mailparse php74-php-pecl-memcached php74-php-pecl-mongodb php74-php-pecl-oauth php74-php-pecl-redis6 php74-php-pecl-rrd php74-php-pecl-ssdeep php74-php-pecl-ssh2 php74-php-pecl-uploadprogress php74-php-pecl-uuid php74-php-pecl-xattr php74-php-pecl-xdebug3 php74-php-pecl-xdiff php74-php-pecl-xlswriter php74-php-pecl-xmldiff php74-php-pecl-yaml php74-php-pecl-zip php74-php-pecl-zmq php74-php-process php74-php-soap php74-php-sodium php74-php-xml

systemctl mask php74-php-fpm

dnf install -y php73 php73-php-ast php73-php-bcmath php73-php-cli php73-php-common php73-php-fpm php73-php-gd php73-php-geos php73-php-pecl-csv php73-php-intl php73-php-ldap php73-php-libvirt php73-php-lz4 php73-php-mbstring php73-php-mysqlnd php73-php-opcache php73-php-pdo php73-php-pear php73-php-pecl-env php73-php-pecl-geoip php73-php-pecl-geospatial php73-php-pecl-imagick-im7 php73-php-imap php73-php-pecl-mailparse php73-php-pecl-memcached php73-php-pecl-mongodb php73-php-pecl-oauth php73-php-pecl-redis6 php73-php-pecl-rrd php73-php-pecl-ssdeep php73-php-pecl-ssh2 php73-php-pecl-uploadprogress php73-php-pecl-uuid php73-php-pecl-xattr php73-php-pecl-xdebug3 php73-php-pecl-xdiff php73-php-pecl-xlswriter php73-php-pecl-xmldiff php73-php-pecl-yaml php73-php-pecl-zip php73-php-pecl-zmq php73-php-process php73-php-soap php73-php-sodium php73-php-xml

systemctl mask php73-php-fpm

dnf install -y php72 php72-php-ast php72-php-bcmath php72-php-cli php72-php-common php72-php-fpm php72-php-gd php72-php-geos php72-php-intl php72-php-ldap php72-php-libvirt php72-php-lz4 php72-php-mbstring php72-php-mysqlnd php72-php-opcache php72-php-pdo php72-php-pear php72-php-pecl-env php72-php-pecl-geoip php72-php-pecl-geospatial php72-php-pecl-imagick-im7 php72-php-imap php72-php-pecl-mailparse php72-php-pecl-memcached php72-php-pecl-mongodb php72-php-pecl-oauth php72-php-pecl-redis6 php72-php-pecl-rrd php72-php-pecl-ssdeep php72-php-pecl-ssh2 php72-php-pecl-uploadprogress php72-php-pecl-uuid php72-php-pecl-xattr php72-php-pecl-xdebug3 php72-php-pecl-xdiff php72-php-pecl-xlswriter php72-php-pecl-xmldiff php72-php-pecl-yaml php72-php-pecl-zip php72-php-pecl-zmq php72-php-process php72-php-soap php72-php-sodium php72-php-xml

systemctl mask php72-php-fpm

dnf install -y php71 php71-php-ast php71-php-bcmath php71-php-cli php71-php-common php71-php-fpm php71-php-gd php71-php-geos php71-php-intl php71-php-ldap php71-php-libvirt php71-php-lz4 php71-php-mbstring php71-php-mysqlnd php71-php-opcache php71-php-pdo php71-php-pear php71-php-pecl-env php71-php-pecl-geoip php71-php-pecl-geospatial php71-php-pecl-imagick-im7 php71-php-imap php71-php-pecl-mailparse php71-php-pecl-memcached php71-php-pecl-mongodb php71-php-pecl-oauth php71-php-pecl-redis5 php71-php-pecl-rrd php71-php-pecl-ssdeep php71-php-pecl-ssh2 php71-php-pecl-uploadprogress php71-php-pecl-uuid php71-php-pecl-xattr php71-php-pecl-xdebug php71-php-pecl-xdiff php71-php-pecl-xlswriter php71-php-pecl-xmldiff php71-php-pecl-yaml php71-php-pecl-zip php71-php-pecl-zmq php71-php-process php71-php-soap php71-php-sodium php71-php-xml

systemctl mask php71-php-fpm

dnf install -y php70 php70-php-ast php70-php-bcmath php70-php-cli php70-php-common php70-php-fpm php70-php-gd php70-php-geos php70-php-intl php70-php-ldap php70-php-libvirt php70-php-lz4 php70-php-mbstring php70-php-mysqlnd php70-php-opcache php70-php-pdo php70-php-pear php70-php-pecl-env php70-php-pecl-geoip php70-php-pecl-geospatial php70-php-pecl-imagick-im7 php70-php-imap php70-php-pecl-mailparse php70-php-pecl-memcached php70-php-pecl-mongodb php70-php-pecl-oauth php70-php-pecl-redis5 php70-php-pecl-rrd php70-php-pecl-ssdeep php70-php-pecl-ssh2 php70-php-pecl-uploadprogress php70-php-pecl-uuid php70-php-pecl-xattr php70-php-pecl-xdebug php70-php-pecl-xdiff php70-php-pecl-xlswriter php70-php-pecl-xmldiff php70-php-pecl-yaml php70-php-pecl-zip php70-php-pecl-zmq php70-php-process php70-php-soap php70-php-sodium php70-php-xml

systemctl mask php70-php-fpm

dnf install -y php56 php56-php-bcmath php56-php-cli php56-php-common php56-php-fpm php56-php-gd php56-php-geos php56-php-intl php56-php-ldap php56-php-libvirt php56-php-lz4 php56-php-mbstring php56-php-mysqlnd php56-php-opcache php56-php-pdo php56-php-pear php56-php-pecl-env php56-php-pecl-geoip php56-php-pecl-geospatial php56-php-pecl-imagick-im7 php56-php-imap php56-php-pecl-mailparse php56-php-pecl-memcached php56-php-pecl-mongodb php56-php-pecl-oauth php56-php-pecl-redis4 php56-php-pecl-rrd php56-php-pecl-ssdeep php56-php-pecl-ssh2 php56-php-pecl-uploadprogress php56-php-pecl-uuid php56-php-pecl-xattr php56-php-pecl-xdebug php56-php-pecl-xdiff php56-php-pecl-xmldiff php56-php-pecl-yaml php56-php-pecl-zip php56-php-pecl-zmq php56-php-process php56-php-soap php56-php-mcrypt php56-php-xml

systemctl mask php56-php-fpm

rm -f /usr/bin/php

ln -s /usr/bin/php85 /usr/bin/php

dnf install -y httpd mod_ssl mod_http2







