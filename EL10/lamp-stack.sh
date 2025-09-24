##################################################################################################
# EL10 (Alma 10) LAMP Stack install
##################################################################################################

# Install tools neded to run a web server and ensure the relevent repo is loaded

dnf install -y composer

dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# Install PHP 8.4
dnf install -y php84 php84-php-cli php84-php-common php84-php-fpm php84-php-gd php84-php-intl php84-php-libvirt php84-php-mbstring php84-php-lz4 php84-php-pear

dnf install -y php84-php-ast php84-php-bcmath php84-php-ffi php84-php-pecl-imap php84-php-ldap php84-php-mysqlnd php84-php-opcache php84-php-pdo php84-php-pecl-csv

dnf install -y php84-php-pecl-env php84-php-pecl-lzf php84-php-pecl-mailparse php84-php-pecl-zip php84-php-process php84-php-soap php84-php-sodium php84-php-xml

systemctl enable php84-php-fpm

systemctl start php84-php-fpm

# Set default version of the command line PHP
rm -f /usr/bin/php

ln -s /usr/bin/php84 /usr/bin/php

# Install Apache with base configuration
dnf install -y httpd mod_ssl mod_http2

mkdir /etc/httpd/vhosts

cat >/etc/httpd/conf/httpd.conf <<EOL
ServerRoot "/etc/httpd"
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

# Install MariaDB
dnf install -y mariadb-server mariadb

systemctl enable mariadb

systemctl start mariadb

# Install certbot
dnf install -y certbot python3-certbot-apache 
