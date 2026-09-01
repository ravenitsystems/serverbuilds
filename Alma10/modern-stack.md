# Modern Webserver With No Legacy Software

## Initial Server Setup

```
setenforce 0

cat >/etc/selinux/config <<EOL
SELINUX=disabled
SELINUXTYPE=targeted
EOL

dnf install -y epel-release

/usr/bin/crb enable

dnf -y install https://rpms.remirepo.net/enterprise/remi-release-10.rpm

dnf install -y nano wget bind-utils net-tools git zip unzip tar rsync 

dnf update -y
```
