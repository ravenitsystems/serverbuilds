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

cat >/etc/ssh/sshd_config <<EOL
Port 2227
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
SyslogFacility AUTHPRIV
LoginGraceTime 1m
PermitRootLogin yes
StrictModes yes
MaxAuthTries 2
MaxSessions 5
AuthorizedKeysFile .ssh/authorized_keys
PasswordAuthentication no
ChallengeResponseAuthentication no
GSSAPIAuthentication yes
GSSAPICleanupCredentials no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
Subsystem       sftp    /usr/libexec/openssh/sftp-server
HostbasedAcceptedKeyTypes ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-ed25519
EOL

systemctl restart sshd

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

mkdir /etc/httpd/vhosts

cat >/etc/httpd/conf/httpd.conf <<EOL
ServerRoot "/etc/httpd"
ServerTokens Prod
ServerSignature Off
TraceEnable Off
Listen 80
Listen 443 https
SSLPassPhraseDialog exec:/usr/libexec/httpd-ssl-pass-dialog
SSLSessionCache shmcb:/run/httpd/sslcache(512000)
SSLSessionCacheTimeout 300
SSLCryptoDevice builtin
SSLHonorCipherOrder on
SSLCipherSuite PROFILE=SYSTEM
SSLProxyCipherSuite PROFILE=SYSTEM
LoadModule access_compat_module modules/mod_access_compat.so
LoadModule actions_module modules/mod_actions.so
LoadModule alias_module modules/mod_alias.so
LoadModule allowmethods_module modules/mod_allowmethods.so
LoadModule auth_basic_module modules/mod_auth_basic.so
LoadModule auth_digest_module modules/mod_auth_digest.so
LoadModule authn_anon_module modules/mod_authn_anon.so
LoadModule authn_core_module modules/mod_authn_core.so
LoadModule authn_dbd_module modules/mod_authn_dbd.so
LoadModule authn_dbm_module modules/mod_authn_dbm.so
LoadModule authn_file_module modules/mod_authn_file.so
LoadModule authn_socache_module modules/mod_authn_socache.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule authz_dbd_module modules/mod_authz_dbd.so
LoadModule authz_dbm_module modules/mod_authz_dbm.so
LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
LoadModule authz_host_module modules/mod_authz_host.so
LoadModule authz_owner_module modules/mod_authz_owner.so
LoadModule authz_user_module modules/mod_authz_user.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule brotli_module modules/mod_brotli.so
LoadModule cache_module modules/mod_cache.so
LoadModule cache_disk_module modules/mod_cache_disk.so
LoadModule cache_socache_module modules/mod_cache_socache.so
LoadModule data_module modules/mod_data.so
LoadModule dbd_module modules/mod_dbd.so
LoadModule deflate_module modules/mod_deflate.so
LoadModule dir_module modules/mod_dir.so
LoadModule dumpio_module modules/mod_dumpio.so
LoadModule echo_module modules/mod_echo.so
LoadModule env_module modules/mod_env.so
LoadModule expires_module modules/mod_expires.so
LoadModule ext_filter_module modules/mod_ext_filter.so
LoadModule filter_module modules/mod_filter.so
LoadModule headers_module modules/mod_headers.so
LoadModule include_module modules/mod_include.so
LoadModule info_module modules/mod_info.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule logio_module modules/mod_logio.so
LoadModule macro_module modules/mod_macro.so
LoadModule mime_magic_module modules/mod_mime_magic.so
LoadModule mime_module modules/mod_mime.so
LoadModule negotiation_module modules/mod_negotiation.so
LoadModule remoteip_module modules/mod_remoteip.so
LoadModule reqtimeout_module modules/mod_reqtimeout.so
LoadModule request_module modules/mod_request.so
LoadModule rewrite_module modules/mod_rewrite.so
LoadModule setenvif_module modules/mod_setenvif.so
LoadModule slotmem_plain_module modules/mod_slotmem_plain.so
LoadModule slotmem_shm_module modules/mod_slotmem_shm.so
LoadModule socache_dbm_module modules/mod_socache_dbm.so
LoadModule socache_memcache_module modules/mod_socache_memcache.so
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
LoadModule status_module modules/mod_status.so
LoadModule substitute_module modules/mod_substitute.so
LoadModule suexec_module modules/mod_suexec.so
LoadModule unique_id_module modules/mod_unique_id.so
LoadModule unixd_module modules/mod_unixd.so
LoadModule userdir_module modules/mod_userdir.so
LoadModule version_module modules/mod_version.so
LoadModule vhost_alias_module modules/mod_vhost_alias.so
LoadModule watchdog_module modules/mod_watchdog.so
LoadModule dav_module modules/mod_dav.so
LoadModule dav_fs_module modules/mod_dav_fs.so
LoadModule dav_lock_module modules/mod_dav_lock.so
LoadModule lua_module modules/mod_lua.so
LoadModule mpm_event_module modules/mod_mpm_event.so
LoadModule proxy_module modules/mod_proxy.so
LoadModule lbmethod_bybusyness_module modules/mod_lbmethod_bybusyness.so
LoadModule lbmethod_byrequests_module modules/mod_lbmethod_byrequests.so
LoadModule lbmethod_bytraffic_module modules/mod_lbmethod_bytraffic.so
LoadModule lbmethod_heartbeat_module modules/mod_lbmethod_heartbeat.so
LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
LoadModule proxy_balancer_module modules/mod_proxy_balancer.so
LoadModule proxy_connect_module modules/mod_proxy_connect.so
LoadModule proxy_express_module modules/mod_proxy_express.so
LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so
LoadModule proxy_fdpass_module modules/mod_proxy_fdpass.so
LoadModule proxy_ftp_module modules/mod_proxy_ftp.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule proxy_hcheck_module modules/mod_proxy_hcheck.so
LoadModule proxy_scgi_module modules/mod_proxy_scgi.so
LoadModule proxy_uwsgi_module modules/mod_proxy_uwsgi.so
LoadModule proxy_wstunnel_module modules/mod_proxy_wstunnel.so
LoadModule ssl_module modules/mod_ssl.so
LoadModule systemd_module modules/mod_systemd.so
LoadModule cgid_module modules/mod_cgid.so
LoadModule http2_module modules/mod_http2.so
LoadModule proxy_http2_module modules/mod_proxy_http2.so
User apache
Group apache
ServerAdmin root@localhost
<Directory />
AllowOverride none
Require all denied
</Directory>
<Files ".ht*">
Require all denied
</Files>
<Files ".user.ini">
Require all denied
</Files>
<Files ".env">
Require all denied
</Files>
TypesConfig /etc/mime.types
AddType application/x-compress .Z
AddType application/x-gzip .gz .tgz
AddType text/html .shtml
AddOutputFilter INCLUDES .shtml
AddDefaultCharset UTF-8
MIMEMagicFile conf/magic
EnableSendfile on
DirectoryIndex index.php index.html
<Directory "/var/www/html">
Options Indexes FollowSymLinks
AllowOverride None
Require all granted
AddType text/html .php
SetEnvIfNoCase ^Authorization$ "(.+)" HTTP_AUTHORIZATION=$1
<FilesMatch \.(php|phar)$>
<If "-f %{REQUEST_FILENAME}">
SetHandler "proxy:unix:/var/opt/remi/php84/run/php-fpm/www.sock|fcgi://localhost"
</If>
</FilesMatch>
</Directory>
<VirtualHost _default_:80>
ServerName default
DocumentRoot "/var/www/html"
ErrorLog logs/ssl_error_log
TransferLog logs/ssl_access_log
LogLevel warn
</VirtualHost>
<VirtualHost _default_:443>
ServerName default
DocumentRoot "/var/www/html"
ErrorLog logs/ssl_error_log
TransferLog logs/ssl_access_log
LogLevel warn
SSLEngine on
SSLCertificateFile /etc/pki/tls/certs/localhost.crt
SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
#SSLCertificateChainFile /etc/pki/tls/certs/server-chain.crt
#SSLCACertificateFile /etc/pki/tls/certs/ca-bundle.crt
<FilesMatch "\.(cgi|shtml|phtml|php)$">
SSLOptions +StdEnvVars
</FilesMatch>
BrowserMatch "MSIE [2-5]" nokeepalive ssl-unclean-shutdown downgrade-1.0 force-response-1.0
</VirtualHost>
IncludeOptional vhosts/*.conf
EOL

systemctl enable httpd

systemctl start httpd

dnf install -y mariadb-server mariadb

cat >/etc/my.cnf.d/mariadb-server.cnf <<EOL
[server]
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
log-error=/var/log/mariadb/mariadb.log
pid-file=/run/mariadb/mariadb.pid
max_connections=2000
wait_timeout=120
slow_query_log = 1
slow-query_log_file = /var/log/mysql-slow.log
long_query_time = 2
# Enable for older websites
#sql_mode=NO_ENGINE_SUBSTITUTION
[galera]
[embedded]
[mariadb]
[mariadb-10.3]
EOL

systemctl enable mariadb

systemctl start mariadb

adduser nashley

usermod -aG wheel nashley

mkdir /home/nashley/.ssh

cat >/home/nashley/.ssh/authorized_keys <<EOL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZYBdHXE8G2YvjTpDCJT674vasNTXMYu0v4r93KrtZFAzPimDcZ6aD2sVtWyxPrg9NVjKA+WQKgXVcpsU/Piz2UcP3p7bycp5pkOmmuAD5iVnvhd9ngu9TXHLFFKeO7Bz0vEfS9N61+lvj/k+oDNxg8uaeD0dF9pRiktqrm/j1ZSJ5XkERvQnYVETAZrA2UkgWiid3Gj4AdO0Uf9a5e1U7/fGIomn0boh+GC7tcgGu8C6U/k40Th1gmMIOiNdaCCnNjL7oAiF15jL2QjHqz3vpD2EU/Su3qtSl9/8oECydDPHjse7tKFqqK8ndhOwaQcqnL5Zjvomrq6KWterYEW5tbAI+6KF69DOorHZ0mbWQsKqxFUsv1fGQCWvEz1L0V8KFBq0nOTzjl6i175zHykvUANdfFbQBchcoV7aIj3mN1Cbws+A3nNre1t5AMhrGYNH4l0JEPgMy7y5pyEGWg9n6GQCAsNL2vDt3HgPBT3xTFs6N+4ni8MjCQKUVXxhktEV3BuuqnTeY99Z+yImnKtUXo2YLYjdYZgoSX4PR7gZHswJ3eTTDyMgRaqU+BRmzREckRAgoKo2aKQvOaJjpvzXCX5K8MTPsgwBEWJjPNXQVw/dztoj+zV7sFIJq7s6Tb4HGCD0MWUSbqRF7hvDTsBRHxpVB+3s/1Utslq+hr6DCzw== ft-nashley-06-25
EOL

chown -R nashley:nashley /home/nashley

chmod 700 /home/nashley/.ssh

chmod 600 /home/nashley/.ssh/authorized_keys

adduser mlarcombe

usermod -aG wheel mlarcombe

mkdir /home/mlarcombe/.ssh

cat >/home/mlarcombe/.ssh/authorized_keys <<EOL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC61t+WwAcTNhzzqWi4KclHUsYT5OkfzzoPowLWHL4DxUitaJNvEerI9+pH/RYlQttjd9mEcSO2tweow1MSMkeg+cjJ1Kcz/Ewp2VrOSlvdq6Yut7F2dy8nd0Ku0/DuCs8yi5ce7LoTLbyBiuHQzHKBie4CtyzIMKg40YH3nVEMRryt3UbnSfWGXZaoVWb6PHqJ1HiUE5m04e74aTRpUhjoqcIqbe/2SxVTc+UIIacpOHEmFegLIXSBUvmyXZ3sP4FRA/zT00hMhwoV3uAOqlCY589/CqMvV/TnQT/7COBJKBdQJ2dWKhKZPaUjplev1G7I75vJdIopJ9u1YtkEH7PEEJRnP7N+W8mn0KfWBzkHqufpmpPOjKvWHeL9UEgUH1BtwD/PdqJg0ySpZ84L/piM/YbqJRNpzMIxKjdMr1cqcVbyWF6bCTTakRos1uieQcnfYpq5naoDaz8g6ncucijJnGv+9yndsB9oAvOcFjHFhIFPfJDVVr6SUzbDfIUC2c= support@uhura
EOL

chown -R mlarcombe:mlarcombe /home/mlarcombe

chmod 700 /home/mlarcombe/.ssh

chmod 600 /home/mlarcombe/.ssh/authorized_keys

adduser chinton

usermod -aG wheel chinton

mkdir /home/chinton/.ssh

cat >/home/chinton/.ssh/authorized_keys <<EOL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCUAQB/ZVv0MFqSrP0Y170i+nFKnvfp3YNFOMBAl3hfW6AeSE+1lWoAk/08sX8c3PnHz1d8LBkuC6W/808s5D8vRZdj7ab+p9at9gvzWdarEYM+cZSmN2uTE77DdeEDYLtMNOYbK1Ixdd+77TBnOxP2SbN2WIcd0uguvJb/3IKwRq1Ze49U1HJ1yHGT2uKQI4v9CXCr+dZhRBBnCdBuhY8xeiRvQxGC65N1HH+X5Npvx015Qyg3H194SZWUOtVmyRb95cXOCEEurFuq2IvmLQzOBM9Z1L0uMxSptjpuwhmRg8MiakUegcr3WP4YpfJ8imvl61LLJkNSaPzoYiSExo6T chinton@Quasar
EOL

chown -R chinton:chinton /home/chinton

chmod 700 /home/chinton/.ssh

chmod 600 /home/chinton/.ssh/authorized_keys

adduser pkaczmarek

usermod -aG wheel pkaczmarek

mkdir /home/pkaczmarek/.ssh

cat >/home/pkaczmarek/.ssh/authorized_keys <<EOL
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDgTqAc6eNEbFp5C44i39fWqnokRH69BLjAqnYHTjsKz3YehNgHYAhobKp+KCyx+Yap0jh7WXKbpy0eIMtlkYtiP9+HICLMTSWm1d847TfEkmlKlrINa1qZyorYI/bWbQjzRh5GVlhIW1zKaG6Jqu214hPF1tHgv3PavK8/hixMSD1g4dWZPhr8m4BgB89hhwlZd998BWzLgXS+lHHAxuQ19FBr7QX1jIKZFSrZH2P7r4XjUo7C9LAgz2/6D2OcUI9oXgcWuut5Fpou9A38R6VRF2rVY/TMEtbbbEWDF4wH3lY1GV51qhh6WFa4kVVYDud2zPb/pGiXTwTr5vOviHXlssRkqoN+Hv+J0FZZDrGxrQkj1UEzZE/rm4/0j8MTzwFdSM1ak2LZamVdaGfcO+W8y672EskxwK0goY5iOhx/BDFWVzZk67vS0braV8mnv7lJxnn9q6LZPdzilhZk9SGJ2lXhBG7xKdvpv4mbjYVJpDgLYGhui2MWGo8HEH/bgd+XAqNasQPjCzKlsphVwQRySkZvASNmpm917ss0wooU13r6p1YPc5j1k4pfJlyMDUHXGjbH8HBcyN9A1Wn8OLqssWXa044Mz75F5ySXDsLFKHWdKKYy8/sHCQlVnQaIz//7XimqoFCeBAR69wJpda6AdZujkrONUmi0Q85/qeTSAw== patkaczmarek@APOLLO
EOL

chown -R pkaczmarek:pkaczmarek /home/pkaczmarek

chmod 700 /home/pkaczmarek/.ssh

chmod 600 /home/pkaczmarek/.ssh/authorized_keys

dnf install -y clamav clamd clamav-freshclam

freshclam










