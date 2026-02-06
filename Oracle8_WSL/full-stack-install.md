# Oracle 8 WSL Full Stack Development Server

This manual will set up a full stack development server within WSL which includes the LAMP stack, redis server and the node development tools.

## Image Pereperation
This step will install the image and configure the image to use systemd which is vital to the rest of the process, we will also ensure the image is up to date and install the repositories and basic tools.

This is to be done in windows command line:
```
wsl --install OracleLinux_8_10
```
You will then be prompted to enter a username and then a password twice to confirm, you will then be inside the WSL container. 

We now need to enter super user mode, you will be asked to confirm your password:
```
sudo -i
```


```
sudo -i

cat >/etc/wsl.conf <<EOL
[boot]
systemd=true
EOL

exit

exit
```


