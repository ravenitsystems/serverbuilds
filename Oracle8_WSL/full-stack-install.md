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





