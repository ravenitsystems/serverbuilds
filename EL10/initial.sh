##################################################################################################
# EL10 (Alma 10) Initial Build Script
##################################################################################################

# Disable SELinux as its not needed for most installations and gets in the way

setenforce 0

cat >/etc/selinux/config <<EOL
SELINUX=disabled
SELINUXTYPE=targeted
EOL

# Create a swap partition that the server will only use if its in difficulty

fallocate -l 2G /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

cat >>/etc/fstab <<EOL
/swapfile swap swap defaults 0 0
EOL

sysctl vm.swappiness=2

echo "vm.swappiness = 2" >> /etc/sysctl.conf

# Install common software repositories

dnf install -y epel-release

/usr/bin/crb enable

dnf -y install https://rpms.remirepo.net/enterprise/remi-release-10.rpm

# Install a minimum toolset for system maintinance

dnf install -y nano wget bind-utils net-tools

# Update the system as most ISO files are out of date

dnf update -y

reboot
