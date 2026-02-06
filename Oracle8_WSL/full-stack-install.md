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

dnf install -y nano wget bind-utils net-tools git zip unzip tar

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

## Install PHP versions

Install all the versions of PHP that you will need, you can miss out the ones you are not going to utilise, you needc to be in super user mode to run these commands

PHP Version 8.5
```
dnf install -y php85 php85-php-cli php85-php-common php85-php-fpm php85-php-gd php85-php-intl php85-php-libvirt php85-php-mbstring php85-php-lz4 php85-php-pear

dnf install -y php85-php-ast php85-php-bcmath php85-php-ffi php85-php-pecl-imap php85-php-ldap php85-php-mysqlnd php85-php-opcache php85-php-pdo php85-php-pecl-csv

dnf install -y php85-php-pecl-env php85-php-pecl-lzf php85-php-pecl-mailparse php85-php-pecl-zip php85-php-process php85-php-soap php85-php-sodium php85-php-xml

systemctl enable php85-php-fpm

systemctl start php85-php-fpm
```

PHP Version 8.4
```
dnf install -y php84 php84-php-cli php84-php-common php84-php-fpm php84-php-gd php84-php-intl php84-php-libvirt php84-php-mbstring php84-php-lz4 php84-php-pear

dnf install -y php84-php-ast php84-php-bcmath php84-php-ffi php84-php-pecl-imap php84-php-ldap php84-php-mysqlnd php84-php-opcache php84-php-pdo php84-php-pecl-csv

dnf install -y php84-php-pecl-env php84-php-pecl-lzf php84-php-pecl-mailparse php84-php-pecl-zip php84-php-process php84-php-soap php84-php-sodium php84-php-xml

systemctl enable php84-php-fpm

systemctl start php84-php-fpm
```

PHP Version 8.3
```
dnf install -y php83 php83-php-cli php83-php-common php83-php-fpm php83-php-gd php83-php-intl php83-php-libvirt php83-php-mbstring php83-php-lz4 php83-php-pear

dnf install -y php83-php-ast php83-php-bcmath php83-php-ffi php83-php-imap php83-php-ldap php83-php-mysqlnd php83-php-opcache php83-php-pdo php83-php-pecl-csv

dnf install -y php83-php-pecl-env php83-php-pecl-lzf php83-php-pecl-mailparse php83-php-pecl-zip php83-php-process php83-php-soap php83-php-sodium php83-php-xml

systemctl enable php83-php-fpm

systemctl start php83-php-fpm
```

PHP Version 8.2
```
dnf install -y php82 php82-php-cli php82-php-common php82-php-fpm php82-php-gd php82-php-intl php82-php-libvirt php82-php-mbstring php82-php-lz4 php82-php-pear

dnf install -y php82-php-ast php82-php-bcmath php82-php-ffi php82-php-imap php82-php-ldap php82-php-mysqlnd php82-php-opcache php82-php-pdo php82-php-pecl-csv

dnf install -y php82-php-pecl-env php82-php-pecl-lzf php82-php-pecl-mailparse php82-php-pecl-zip php82-php-process php82-php-soap php82-php-sodium php82-php-xml

systemctl enable php82-php-fpm

systemctl start php82-php-fpm
```

PHP Version 8.1
```
dnf install -y php81 php81-php-cli php81-php-common php81-php-fpm php81-php-gd php81-php-intl php81-php-libvirt php81-php-mbstring php81-php-lz4 php81-php-pear

dnf install -y php81-php-ast php81-php-bcmath php81-php-ffi php81-php-imap php81-php-ldap php81-php-mysqlnd php81-php-opcache php81-php-pdo php81-php-pecl-csv

dnf install -y php81-php-pecl-env php81-php-pecl-lzf php81-php-pecl-mailparse php81-php-pecl-zip php81-php-process php81-php-soap php81-php-sodium php81-php-xml

systemctl enable php81-php-fpm

systemctl start php81-php-fpm
```

PHP Version 8.0
```
dnf install -y php80 php80-php-cli php80-php-common php80-php-fpm php80-php-gd php80-php-intl php80-php-libvirt php80-php-mbstring php80-php-lz4 php80-php-pear

dnf install -y php80-php-ast php80-php-bcmath php80-php-ffi php80-php-imap php80-php-ldap php80-php-mysqlnd php80-php-opcache php80-php-pdo php80-php-pecl-csv

dnf install -y php80-php-pecl-env php80-php-pecl-lzf php80-php-pecl-mailparse php80-php-pecl-zip php80-php-process php80-php-soap php80-php-sodium php80-php-xml

systemctl enable php80-php-fpm

systemctl start php80-php-fpm
```

PHP Version 7.4
```dnf install -y php74 php74-php-cli php74-php-common php74-php-fpm php74-php-gd php74-php-intl php74-php-libvirt php74-php-mbstring php74-php-lz4 php74-php-pear

dnf install -y php74-php-ast php74-php-bcmath php74-php-ffi php74-php-imap php74-php-ldap php74-php-mysqlnd php74-php-opcache php74-php-pdo php74-php-pecl-csv

dnf install -y php74-php-pecl-env php74-php-pecl-lzf php74-php-pecl-mailparse php74-php-pecl-zip php74-php-process php74-php-soap php74-php-sodium php74-php-xml

systemctl enable php74-php-fpm

systemctl start php74-php-fpm
```

PHP Version 7.3
```
dnf install -y php73 php73-php-cli php73-php-common php73-php-fpm php73-php-gd php73-php-intl php73-php-libvirt php73-php-mbstring php73-php-lz4 php73-php-pear

dnf install -y php73-php-ast php73-php-bcmath php73-php-imap php73-php-ldap php73-php-mysqlnd php73-php-opcache php73-php-pdo php73-php-pecl-csv

dnf install -y php73-php-pecl-env php73-php-pecl-lzf php73-php-pecl-mailparse php73-php-pecl-zip php73-php-process php73-php-soap php73-php-sodium php73-php-xml

systemctl enable php73-php-fpm

systemctl start php73-php-fpm
```

PHP Version 7.2
```
dnf install -y php72 php72-php-cli php72-php-common php72-php-fpm php72-php-gd php72-php-intl php72-php-libvirt php72-php-mbstring php72-php-lz4 php72-php-pear

dnf install -y php72-php-ast php72-php-bcmath php72-php-imap php72-php-ldap php72-php-mysqlnd php72-php-opcache php72-php-pdo 

dnf install -y php72-php-pecl-env php72-php-pecl-lzf php72-php-pecl-mailparse php72-php-pecl-zip php72-php-process php72-php-soap php72-php-sodium php72-php-xml

systemctl enable php72-php-fpm

systemctl start php72-php-fpm
```

PHP Version 5.6
```
dnf install -y php56-php php56-php-bcmath php56-php-cli php56-php-common php56-php-fpm php56-php-gd php56-php-geos php56-php-imap php56-php-intl php56-php-ldap php56-php-lz4 php56-php-mbstring php56-php-mcrypt php56-php-mysqlnd php56-php-opcache php56-php-pdo php56-php-pear php56-php-pecl-env php56-php-pecl-imagick-im7 php56-php-pecl-jsond php56-php-pecl-mailparse php56-php-pecl-memcached php56-php-pecl-oauth php56-php-pecl-redis4 php56-php-pecl-uploadprogress php56-php-pecl-xattr php56-php-pecl-xdiff php56-php-pecl-xmldiff php56-php-pecl-yaml php56-php-pecl-zip php56-php-phpiredis php56-php-process php56-php-soap php56-php-xml

systemctl enable php56-php-fpm

systemctl start php56-php-fpm
```

Now we set the default version 


