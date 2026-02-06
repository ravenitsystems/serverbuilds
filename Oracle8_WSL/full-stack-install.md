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


