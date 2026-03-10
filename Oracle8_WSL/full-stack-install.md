# Oracle 8 WSL Full Stack Development Server

This manual will set up a full stack development server within WSL which includes the LAMP stack, redis server and the node development tools.

## Image Pereperation
This step will install the image and configure the image to use systemd which is vital to the rest of the process, we will also ensure the image is up to date and install the repositories and basic tools.

This is to be done in windows command line, you will then be prompted to enter a username and then a password twice to confirm, you will then be inside the WSL container.

```
wsl --install OracleLinux_8_10
```

Now we are inside the WSL container we need to enter super user mode, you will be asked to confirm your password:
```
sudo -i
```

You should the the prompt has chaged to root, this means we can access the internal system configuration without being prompted for the password each time we do something. The next step is to enable systemd which is vital to the rest of the process.
```
cat >/etc/wsl.conf <<EOL
[boot]
systemd=true
EOL
```

Now we need to jump back from super user mode, we do this by simply exiting the current session
```
exit
```

You should now see that the prompt has changed back to your username, now we exit WSL using the same command:
```
exit
```

Now you should see that the prompt has switched back to the windows prompt meaning we are outside of the WSL container. We now want to shut down WSL so the next time we go into the container it will have restarted.
```
wsl --shutdown
```

Now we go back into the newly restarted WSL subsystem 
```
wsl
```

You should now see the linux style prompt with your username, again we want to jump into super user mode so we can execture the next collection of commanmds, again you will be prompted for the password:
```
sudo -i
```

You should now see the linux style command prompt with root as the username, this means we are ready to do the rest of the setup. This next step will update the instance as well as install basic tools and repositories:
```
setenforce 0

cat >/etc/selinux/config <<EOL
SELINUX=disabled
SELINUXTYPE=targeted
EOL

dnf install -y epel-release

/usr/bin/crb enable

dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

dnf install -y nano wget bind-utils net-tools git zip unzip tar rsync 

dnf update -y
```

After that process is completed, it will take some time, we need to exit out of super user mode just like we did before:
```
exit
```

You should now see the linux prompt with your chosen username, we need to exit out of WSL entirely so we can exectute container commands:
```
exit
```

You should now see the windows based command line, we want to restart the linux subsystem so any changes to the linux care are loaded
```
wsl --shutdown
```

To restart WSL service we simply need to enter the linux subsystem, this is the last step which will leave you logged in your user for the next steps
```
wsl
```

## Create an SSL certificate 
Put in pre-baked SSL certificates that will need to be set as trusted on the host computer

```
cat >/etc/pki/tls/certs/localhost.crt <<EOL
-----BEGIN CERTIFICATE-----
MIIHMzCCBRugAwIBAgIUbwN2FxtRmmoqyZE1TbKiE9R/crcwDQYJKoZIhvcNAQEL
BQAwgZ4xCzAJBgNVBAYTAkdCMRAwDgYDVQQIDAdFbmdsYW5kMRIwEAYDVQQHDAlM
ZWljZXN0ZXIxFzAVBgNVBAoMDlJhdmVuSXRTeXN0ZW1zMQ8wDQYDVQQLDAZXZWJE
ZXYxFDASBgNVBAMMCyoubG9jYWwuY29tMSkwJwYJKoZIhvcNAQkBFhpyYXZlbml0
c3lzdGVtc0BvdXRsb29rLmNvbTAeFw0yNjAzMTAxNTMwMzVaFw0zNjAzMDcxNTMw
MzVaMIGeMQswCQYDVQQGEwJHQjEQMA4GA1UECAwHRW5nbGFuZDESMBAGA1UEBwwJ
TGVpY2VzdGVyMRcwFQYDVQQKDA5SYXZlbkl0U3lzdGVtczEPMA0GA1UECwwGV2Vi
RGV2MRQwEgYDVQQDDAsqLmxvY2FsLmNvbTEpMCcGCSqGSIb3DQEJARYacmF2ZW5p
dHN5c3RlbXNAb3V0bG9vay5jb20wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQC/ruNNdS5wIMJ3HhhZhn2Xrdr3Qlau2IwvO5i2C3oX0Qm+ZSE/f1LW5BJo
yIunqNnn97TUciAwKBKRX+OGicx3y8iR7ECMMB+e/lK8QS9bvtbUn3tR5erfxXHb
j0WwR3X05gE+2Rx5HuQ7uqDdJh8DJgnoHLQzlmhJF1d/Van6btmve33S0Yl5GFk+
trEF4lC3xgCOpPNKk1OMiy12+gmkf4esYTEN0GdUeiUm7OECG2c3JsLv3sYPekri
a39z48FCUzGhWHr48jMypa83+qhtQOFCCs42xwybIwEIVGEzBZXOPmzqo4n5wVTh
xcC0+lF4dh/YEucs5v1FPGphBxbDB4EZ78ptiHjZWqZn7s5etiRwkoiQPKNomJ6L
G/Zf1EqaWLN97UngoA77nuV84S0R3D1yGciLKQshm1SGCN4lInco3qwCl+SHbZ17
W4STC8YGc8yxqhPZFANVB7Ea6PIfjZFVZYHBnVDZz9rT0XJIgT0B9wGw4tx1CW76
uo/d+RXYjMZGvqgnKCg+biEjhTe2eeCwWlKk/3kpi3BVxv9Y6jgep1gkPHFHgMEy
GDoRQHFRlUn1ASaKf/RiJFZkhPJADkTaDMTSrWagvguTAYEJ2JKh1qi3QUPSmAaA
17bmKAof8QKL2GIP28LyktvPcQiDwYd4lo3dr14VSckIn2pvQQIDAQABo4IBZTCC
AWEwHQYDVR0OBBYEFADOPmgrzFdsVSSiDj9MWGMGu2WYMIHeBgNVHSMEgdYwgdOA
FADOPmgrzFdsVSSiDj9MWGMGu2WYoYGkpIGhMIGeMQswCQYDVQQGEwJHQjEQMA4G
A1UECAwHRW5nbGFuZDESMBAGA1UEBwwJTGVpY2VzdGVyMRcwFQYDVQQKDA5SYXZl
bkl0U3lzdGVtczEPMA0GA1UECwwGV2ViRGV2MRQwEgYDVQQDDAsqLmxvY2FsLmNv
bTEpMCcGCSqGSIb3DQEJARYacmF2ZW5pdHN5c3RlbXNAb3V0bG9vay5jb22CFG8D
dhcbUZpqKsmRNU2yohPUf3K3MAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgL8MCEG
A1UdEQQaMBiCCWxvY2FsLmNvbYILKi5sb2NhbC5jb20wIQYDVR0SBBowGIIJbG9j
YWwuY29tggsqLmxvY2FsLmNvbTANBgkqhkiG9w0BAQsFAAOCAgEAiYAaNLBiMX/R
TEpUbwqbJCOM3uC/2JqkMcSxpfbZ47CD+rB4MZhcEvpMzsg2E9im5FmuY3Cis6UT
IwdmASCGNwsa2ViOWSret9ZWjQTjD9IBAkU27aDKZ1DA70YWo1YSirOxLekbCGZP
y92t6e308hASI6Q4CceL21JYrG8+Nf7J8VaWduGpfvz0tzfUGwWdpG7lDlwxo4+9
2MwGNJZETV2vrOXp9BWb+91Jjz5wGV6III4/VlSEGikGvWw14QOeeRmt82r9/RYm
N2CF5K/+7qPxw5zSGjwQoAYmfhS7MeCuQ6Hp9xVpNpI8m0zT23gNTYhINkCVGMb8
0DaHzsYGlCFymgWmxi0h0H5BHXReE8nF+dhum+pDfWutvn4RjNLtKaFJrYcgFJvk
Hx1zUyVvzGQfJO30i0ozWTVchuYzgYI7IiWw75jL4ru0qSHZiBljADc+qEkJX92b
6hmf6vrECqaZTCTfkk680VpxREAPrQEpZu+kVuBRblLWO2u0xzLt5znujX6dMZeE
EnctgHI589CUTyMlIWquzdzBQ+82GN6LQ/MDPFG31rJArpx9GzEO+Z/KRLswNFd1
9K2SdZpiquku1+ix8JRlrrgShVrvExNXQIUj+sguh5hX+e+XG0hpyM4cKNmoQx9e
yjGQNNmOYafO9ruBrCQ2Q2s01yIs4Rs=
-----END CERTIFICATE-----
EOL

cat >/etc/pki/tls/private/localhost.key <<EOL
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
EOL

trust anchor /etc/pki/tls/certs/localhost.crt
```

## Install the LAMP stack 

### Install PHP versions

Install all the versions of PHP that you will need, you can miss out the ones you are not going to utilise, you needc to be in super user mode to run these commands

PHP Version 8.5
```
dnf install -y php85 php85-php-cli php85-php-common php85-php-fpm php85-php-gd php85-php-intl php85-php-libvirt php85-php-mbstring php85-php-lz4 php85-php-pear

dnf install -y php85-php-ast php85-php-bcmath php85-php-ffi php85-php-pecl-imap php85-php-ldap php85-php-mysqlnd php85-php-opcache php85-php-pdo php85-php-pecl-csv

dnf install -y php85-php-pecl-env php85-php-pecl-lzf php85-php-pecl-mailparse php85-php-pecl-zip php85-php-process php85-php-soap php85-php-sodium php85-php-xml

dnf install -y php85-php-pecl-redis6

systemctl enable php85-php-fpm

systemctl start php85-php-fpm
```

PHP Version 8.4
```
dnf install -y php84 php84-php-cli php84-php-common php84-php-fpm php84-php-gd php84-php-intl php84-php-libvirt php84-php-mbstring php84-php-lz4 php84-php-pear

dnf install -y php84-php-ast php84-php-bcmath php84-php-ffi php84-php-pecl-imap php84-php-ldap php84-php-mysqlnd php84-php-opcache php84-php-pdo php84-php-pecl-csv

dnf install -y php84-php-pecl-env php84-php-pecl-lzf php84-php-pecl-mailparse php84-php-pecl-zip php84-php-process php84-php-soap php84-php-sodium php84-php-xml

dnf install -y php84-php-pecl-redis6

systemctl enable php84-php-fpm

systemctl start php84-php-fpm
```

PHP Version 8.3
```
dnf install -y php83 php83-php-cli php83-php-common php83-php-fpm php83-php-gd php83-php-intl php83-php-libvirt php83-php-mbstring php83-php-lz4 php83-php-pear

dnf install -y php83-php-ast php83-php-bcmath php83-php-ffi php83-php-imap php83-php-ldap php83-php-mysqlnd php83-php-opcache php83-php-pdo php83-php-pecl-csv

dnf install -y php83-php-pecl-env php83-php-pecl-lzf php83-php-pecl-mailparse php83-php-pecl-zip php83-php-process php83-php-soap php83-php-sodium php83-php-xml

dnf install -y php83-php-pecl-redis6

systemctl enable php83-php-fpm

systemctl start php83-php-fpm
```

PHP Version 8.2
```
dnf install -y php82 php82-php-cli php82-php-common php82-php-fpm php82-php-gd php82-php-intl php82-php-libvirt php82-php-mbstring php82-php-lz4 php82-php-pear

dnf install -y php82-php-ast php82-php-bcmath php82-php-ffi php82-php-imap php82-php-ldap php82-php-mysqlnd php82-php-opcache php82-php-pdo php82-php-pecl-csv

dnf install -y php82-php-pecl-env php82-php-pecl-lzf php82-php-pecl-mailparse php82-php-pecl-zip php82-php-process php82-php-soap php82-php-sodium php82-php-xml

dnf install -y php82-php-pecl-redis6

systemctl enable php82-php-fpm

systemctl start php82-php-fpm
```

PHP Version 8.1
```
dnf install -y php81 php81-php-cli php81-php-common php81-php-fpm php81-php-gd php81-php-intl php81-php-libvirt php81-php-mbstring php81-php-lz4 php81-php-pear

dnf install -y php81-php-ast php81-php-bcmath php81-php-ffi php81-php-imap php81-php-ldap php81-php-mysqlnd php81-php-opcache php81-php-pdo php81-php-pecl-csv

dnf install -y php81-php-pecl-env php81-php-pecl-lzf php81-php-pecl-mailparse php81-php-pecl-zip php81-php-process php81-php-soap php81-php-sodium php81-php-xml

dnf install -y php81-php-pecl-redis6

systemctl enable php81-php-fpm

systemctl start php81-php-fpm
```

PHP Version 8.0
```
dnf install -y php80 php80-php-cli php80-php-common php80-php-fpm php80-php-gd php80-php-intl php80-php-libvirt php80-php-mbstring php80-php-lz4 php80-php-pear

dnf install -y php80-php-ast php80-php-bcmath php80-php-ffi php80-php-imap php80-php-ldap php80-php-mysqlnd php80-php-opcache php80-php-pdo php80-php-pecl-csv

dnf install -y php80-php-pecl-env php80-php-pecl-lzf php80-php-pecl-mailparse php80-php-pecl-zip php80-php-process php80-php-soap php80-php-sodium php80-php-xml

dnf install -y php80-php-pecl-redis6

systemctl enable php80-php-fpm

systemctl start php80-php-fpm
```

PHP Version 7.4
```
dnf install -y php74 php74-php-cli php74-php-common php74-php-fpm php74-php-gd php74-php-intl php74-php-libvirt php74-php-mbstring php74-php-lz4 php74-php-pear

dnf install -y php74-php-ast php74-php-bcmath php74-php-ffi php74-php-imap php74-php-ldap php74-php-mysqlnd php74-php-opcache php74-php-pdo php74-php-pecl-csv

dnf install -y php74-php-pecl-env php74-php-pecl-lzf php74-php-pecl-mailparse php74-php-pecl-zip php74-php-process php74-php-soap php74-php-sodium php74-php-xml

dnf install -y php74-php-pecl-redis6

systemctl enable php74-php-fpm

systemctl start php74-php-fpm
```

PHP Version 7.3
```
dnf install -y php73 php73-php-cli php73-php-common php73-php-fpm php73-php-gd php73-php-intl php73-php-libvirt php73-php-mbstring php73-php-lz4 php73-php-pear

dnf install -y php73-php-ast php73-php-bcmath php73-php-imap php73-php-ldap php73-php-mysqlnd php73-php-opcache php73-php-pdo php73-php-pecl-csv

dnf install -y php73-php-pecl-env php73-php-pecl-lzf php73-php-pecl-mailparse php73-php-pecl-zip php73-php-process php73-php-soap php73-php-sodium php73-php-xml

dnf install -y php73-php-pecl-redis6

systemctl enable php73-php-fpm

systemctl start php73-php-fpm
```

PHP Version 7.2
```
dnf install -y php72 php72-php-cli php72-php-common php72-php-fpm php72-php-gd php72-php-intl php72-php-libvirt php72-php-mbstring php72-php-lz4 php72-php-pear

dnf install -y php72-php-ast php72-php-bcmath php72-php-imap php72-php-ldap php72-php-mysqlnd php72-php-opcache php72-php-pdo 

dnf install -y php72-php-pecl-env php72-php-pecl-lzf php72-php-pecl-mailparse php72-php-pecl-zip php72-php-process php72-php-soap php72-php-sodium php72-php-xml

dnf install -y php72-php-pecl-redis6

systemctl enable php72-php-fpm

systemctl start php72-php-fpm
```

PHP Version 5.6
```
dnf install -y php56-php php56-php-bcmath php56-php-cli php56-php-common php56-php-fpm php56-php-gd php56-php-geos php56-php-imap php56-php-intl php56-php-ldap php56-php-lz4 php56-php-mbstring php56-php-mcrypt php56-php-mysqlnd php56-php-opcache php56-php-pdo php56-php-pear php56-php-pecl-env php56-php-pecl-imagick-im7 php56-php-pecl-jsond php56-php-pecl-mailparse php56-php-pecl-memcached php56-php-pecl-oauth php56-php-pecl-redis4 php56-php-pecl-uploadprogress php56-php-pecl-xattr php56-php-pecl-xdiff php56-php-pecl-xmldiff php56-php-pecl-yaml php56-php-pecl-zip php56-php-phpiredis php56-php-process php56-php-soap php56-php-xml

dnf install -y php56-php-pecl-redis4

systemctl enable php56-php-fpm

systemctl start php56-php-fpm
```

### Install & configure PHP tools

Install composer 
```
dnf install -y composer
```

Now we set the default version of PHP on the command line by making the php executable into a symbolic link to a version of PHP. The default its 8.5 but it can be changhed to whatever suits
```
rm -f /usr/bin/php

ln -s /usr/bin/php85 /usr/bin/php
```

### Install Apache with configuration 

```
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
```

### Install mysql server and command line client

This must be ran as the root user inside the linux sub system, this installs the mysql software and configures the service to start on boot
```
dnf install -y mariadb-server mariadb

systemctl enable mariadb

systemctl start mariadb
```

## Install Redis and start the service
```
yum module enable redis:6

dnf install -y redis

systemctl start redis

systemctl enable redis

```

## Install Mongodb and start the service
```
cat >/etc/yum.repos.d/mongodb.repo <<EOL
[mongodb-org-5.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc
EOL

yum install -y mongodb-org

systemctl start mongod

systemctl enable mongod
```

## Install the create vhost script
```
cat >/root/create-vhost.php <<EOL
<?php
const APACHE_VHOST_DIRECTORY = '/etc/httpd/vhosts';
const WEB_APPLICATIONS_DIRECTORY = '/var/www';

try {

    print PHP_EOL;
    print str_repeat('#', 80) . PHP_EOL;
    print "# APACHE VHOST CREATION SCRIPT v1.0" . PHP_EOL;
    print str_repeat('#', 80) . PHP_EOL;
    print PHP_EOL;

    // Check if the current user is root as nothing will work otherwise
    if (posix_getuid() !== 0) {
        throw new Exception("Script must be ran as the root user");
    }

    // Check the configured directories exist
    if (!file_exists(APACHE_VHOST_DIRECTORY) || !is_dir(APACHE_VHOST_DIRECTORY)) {
        throw new Exception("The Apache vhost directory could not be found");
    }
    if (!file_exists(WEB_APPLICATIONS_DIRECTORY) || !is_dir(WEB_APPLICATIONS_DIRECTORY)) {
        throw new Exception("The web applications directory could not be found");
    }

    // Check that we have a primary domain as a parameter
    if ((\$domain = \$argv[1] ?? '') == '') {
        throw new Exception("The primary domain is a required parameter");
    }

    \$domain = \$domain . '.local.com';

    // Collect any domain alias to be added to the vhost
    \$alias_list = [];
//    for(\$index = 2; \$index < sizeof(\$argv); \$index++) {
//        \$alias_list[] = \$argv[\$index] ?? '';
//    }

    // Convert the primary domain into a username we can use for all referencing files
    \$username = str_replace('-', '_', str_replace('.', '_', \$domain));
    while(\$username != str_replace('__', '_', \$username)) {
        \$username = str_replace('__', '_', \$username);
    }

    // Put together the file locations we need to create
    \$conf_path = APACHE_VHOST_DIRECTORY . '/' . \$username . '.conf';
    \$root_path = WEB_APPLICATIONS_DIRECTORY . '/' . \$username;
    \$docs_path = WEB_APPLICATIONS_DIRECTORY . '/' . \$username . '/webroot/public';
    \$logs_path = WEB_APPLICATIONS_DIRECTORY . '/' . \$username . '/logs';

    // Output the details gathered so far
    print "Primary Domain: {\$domain}" . PHP_EOL;
    print "Alias Domains: " . implode(', ', \$alias_list) . PHP_EOL;
    print "Generated Username: {\$username}" . PHP_EOL;
    print "Vhost config file: {\$conf_path}" . PHP_EOL;
    print "Application root: {\$root_path}" . PHP_EOL;
    print "Logs directory: {\$docs_path}" . PHP_EOL;
    print "Logs directory: {\$logs_path}" . PHP_EOL;

    print PHP_EOL;

    // Check that the vhost we are trying to create does not exist already
    if (file_exists(\$conf_path)) {
      //  throw new Exception("The file {\$conf_path} already exists");
    }

    // Create the directory structure for the application
    verifyDirectory(\$root_path);
    verifyDirectory(\$logs_path);
    verifyDirectory(\$root_path . '/webroot');
    verifyDirectory(\$docs_path);
    shell_exec("chown -R apache:apache {\$root_path}");

    // Generate a component to put in the alias domains
    \$alias = '';
    foreach (\$alias_list as \$alias_item) {
        \$alias .= "ServerAlias \$alias_item" . PHP_EOL;
    }
    \$alias = (\$alias != '') ? PHP_EOL . trim(\$alias): '';

    // Write the config file to the vhosts config folder
    \$conf = <<<EOT
    <Directory "{\$docs_path}">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    AddType text/html .php
    SetEnvIfNoCase ^Authorization\$ "(.+)" HTTP_AUTHORIZATION=
    <FilesMatch \.(php|phar)\$>
    <If "-f %{REQUEST_FILENAME}">
    SetHandler "proxy:unix:/var/opt/remi/php83/run/php-fpm/www.sock|fcgi://localhost"
    </If>
    </FilesMatch>
    </Directory>

    <VirtualHost _default_:80>
    ServerName {\$domain}{\$alias}
    DocumentRoot "{\$docs_path}"
    ErrorLog "{\$logs_path}/error_log"
    TransferLog "{\$logs_path}/access_log"
    LogLevel warn
    </VirtualHost>

    <VirtualHost _default_:443>
    ServerName {\$domain}{\$alias}
    DocumentRoot "{\$docs_path}"
    ErrorLog "{\$logs_path}/error_log"
    TransferLog "{\$logs_path}/access_log"
    LogLevel warn
    SSLEngine on
    SSLCertificateFile /etc/pki/tls/certs/localhost.crt
    SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
    <FilesMatch "\.(cgi|shtml|phtml|php)\$">
    SSLOptions +StdEnvVars
    </FilesMatch>
    BrowserMatch "MSIE [2-5]" nokeepalive ssl-unclean-shutdown downgrade-1.0 force-response-1.0
    </VirtualHost>
    EOT;

    file_put_contents(\$conf_path, \$conf);

    // Restart Apache
    shell_exec("apachectl restart");

    \$certbot = "certbot certonly --non-interactive --agree-tos --email support@avantiy.com --webroot -w {\$docs_path} -d {\$domain}";
    foreach(\$alias_list as \$alias_item) {
        \$certbot .= " -d {\$alias_item}";
    }

    \$certbot_response = shell_exec(\$certbot);
    if (str_contains(\$certbot_response, 'Successfully received certificate.') || str_contains(\$certbot_response, 'Certificate not yet due for renewal')) {

        \$cert_pub_path = "/etc/letsencrypt/live/{\$domain}/fullchain.pem";
        if (!file_exists(\$cert_pub_path)) {
            throw new Exception("Could not find certificate public key: {\$cert_pub_path}");
        }
        \$cert_key_path = "/etc/letsencrypt/live/{\$domain}/privkey.pem";
        if (!file_exists(\$cert_key_path)) {
            throw new Exception("Could not find certificate private key: {\$cert_key_path}");
        }

        \$conf = file_get_contents(\$conf_path);
        \$conf = str_replace('/etc/pki/tls/certs/localhost.crt', \$cert_pub_path, \$conf);
        \$conf = str_replace('/etc/pki/tls/private/localhost.key', \$cert_key_path, \$conf);
        file_put_contents(\$conf_path, \$conf);

        // Restart Apache
        shell_exec("apachectl restart");
    } else {
        print \$certbot_response;
        throw new Exception("Could not receive certificate");
    }

} catch (Throwable \$exception) {
    print PHP_EOL . PHP_EOL;
    print "SCRIPT ERROR - HALTING EXECUTION" . PHP_EOL . PHP_EOL;
    /** @var Throwable \$exception_loop */
    \$exception_loop = \$exception;
    while (\$exception_loop instanceof Throwable) {
        print "#{\$exception_loop->getCode()} @ {\$exception_loop->getFile()}:{\$exception_loop->getLine()} {\$exception_loop->getMessage()}" . PHP_EOL;
        \$exception_loop = \$exception_loop->getPrevious();
    }
    print PHP_EOL;
    print \$exception->getTraceAsString() . PHP_EOL;
    print PHP_EOL;
    print "Exiting Script" . PHP_EOL . PHP_EOL;
    exit(\$exception->getCode());
}

function verifyDirectory(string \$path): void
{
    if (!file_exists(\$path)) {
        @mkdir(\$path);
    }
    if (!file_exists(\$path) || !is_dir(\$path)) {
        throw new Exception("The directory '{\$path}' does not exist and could not be created");
    }
}
EOL
```



