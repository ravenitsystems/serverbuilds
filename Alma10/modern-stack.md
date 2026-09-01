# Modern Web Server With No Legacy Software

A secure and robust web server stack based on EL10 with no legacy allowances compromising security. This is designed to run production sites as there is no debug tools or any front end builder tools included. 

## Initial Server Setup

```
fallocate -l 4G /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

cat >>/etc/fstab <<EOL
/swapfile swap swap defaults 0 0
EOL

sysctl vm.swappiness=2

echo "vm.swappiness = 2" >> /etc/sysctl.conf

```


```
setenforce 0

cat >/etc/selinux/config <<EOL
SELINUX=disabled
SELINUXTYPE=targeted
EOL

dnf install -y epel-release

/usr/bin/crb enable

dnf -y install https://rpms.remirepo.net/enterprise/remi-release-10.rpm

dnf install -y nano wget bind-utils net-tools git zip unzip tar rsync mc
```

Update the OS

```
dnf update -y

```
