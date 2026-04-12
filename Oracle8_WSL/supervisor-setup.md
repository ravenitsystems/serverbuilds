# Install & Configure Supervisor

## Installation

The package is available on the epel repository so this is quite an easy install

```
dnf install supervisor -y

systemctl enable --now supervisord
```

## Configuration

The main configuration file is at `/etc/supervisord.conf` and contains by default a directive to load all config files in the directory `/etc/supervisord.d/`. So to configure a new application we create an ini file in that directory so it is loaded and processed.

This is an example program configuration file

```
[program:av2_schedule]
command=/usr/bin/php85 /var/www/av2_local_com/webroot/artisan schedule:work
directory=/var/www/av2_local_com/webroot
user=apache
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/var/log/av2_schedule_log
```
