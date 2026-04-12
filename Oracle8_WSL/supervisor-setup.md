# Install & Configure Supervisor

## Installation

The package is available on the epel repository so this is quite an easy install

```
dnf install supervisor -y

systemctl enable --now supervisord
```

## Configuration

The main configuration file is at `/etc/supervisord.conf` and contains by default a directive to load all config files in the directory `/etc/supervisord.d/`. So to configure a new application we create an ini file in that directory so it is loaded and processed.

This is an example program configuration file `/etc/supervisord.d/av2_schedule.ini`

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

And a second program, this will be standard for the laravel queue and schedule systems `/etc/supervisord.d/av2_queue.ini`

```
[program:av2_queue]
command=/usr/bin/php85 /var/www/av2_local_com/webroot/artisan queue:work
directory=/var/www/av2_local_com/webroot
user=apache
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/var/log/av2_queue_log
```

And now we add a group so we can control these two programs as one unit `/etc/supervisord.d/av2.ini`

```
[group:av2]
programs=av2_schedule,av2_queue
```

If you are using a process group its always advisable to set the individual programs to start and stop as a group, this is especially relevent for laravel queues and schedules. You can do this by adding these lines into all the individual programs.

```
stopasgroup=true
killasgroup=true
```

After any configuration change you need to reload and update the configuration, you can do this by running the following commands

```
supervisorctl reread

supervisorctl update
```

## Controlling Programs & Groups

First of all it is useful to be able to see the status of all of the services, you can do that using the following command:

```
supervisorctl status
```

To control a program or group, you can use the following commands

```
supervisorctl start av2:av2_schedule

supervisorctl start av2:av2_queue

supervisorctl stop av2:av2_schedule

supervisorctl stop av2:av2_queue

supervisorctl start av2:*

supervisorctl stop av2:*

```
