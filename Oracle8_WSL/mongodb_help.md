# MONGODB HELP

## Installation 

Run the following on a root shell:
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

## Authenticate mode setup

To run the command line utility type
```
mongo
```

And yuou will see a screen similar to
```
MongoDB shell version v5.0.32
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("747c028e-7b62-45ec-a711-f353c09768fc") }
MongoDB server version: 5.0.32
================
Warning: the "mongo" shell has been superseded by "mongosh",
which delivers improved usability and compatibility.The "mongo" shell has been deprecated and will be removed in
an upcoming release.
For installation instructions, see
https://docs.mongodb.com/mongodb-shell/install/
================
```

First we need to switch to the admin database, we do this with the following command:
```
use admin
```

We then need to add a user so we can gain access after the mode change, we will create an all access account 
```
db.createUser(
  {
  user: "administrator",
  pwd: "password",
  roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
```

We can test what users we have on the system using the following command:
```
show users
```

Now we should exit mongo db shell utility to get back to our root SSH prompt, we now need to change the configuration of the mongodb service to enforce authentication.
```
cat >/lib/systemd/system/mongod.service <<EOL
[Unit]
Description=MongoDB Database Server
Documentation=https://docs.mongodb.org/manual
After=network-online.target
Wants=network-online.target

[Service]
User=mongod
Group=mongod
Environment="OPTIONS= --auth -f /etc/mongod.conf"
Environment="MONGODB_CONFIG_OVERRIDE_NOFORK=1"
EnvironmentFile=-/etc/sysconfig/mongod
ExecStart=/usr/bin/mongod \$OPTIONS
RuntimeDirectory=mongodb
# file size
LimitFSIZE=infinity
# cpu time
LimitCPU=infinity
# virtual memory size
LimitAS=infinity
# open files
LimitNOFILE=64000
# processes/threads
LimitNPROC=64000
# locked memory
LimitMEMLOCK=infinity
# total threads (user+kernel)
TasksMax=infinity
TasksAccounting=false
# Recommended limits for mongod as specified in
# https://docs.mongodb.com/manual/reference/ulimit/#recommended-ulimit-settings

[Install]
WantedBy=multi-user.target
EOL
```

Then we restart the services and restart mongodb
```
systemctl daemon-reload

systemctl restart mongod
```

Now the mongo installation will be in authenticate mode and will block commands the current user does not have rights to perform, to log in open the mongo shell and type:
```
db.auth('administrator', 'password')
```
