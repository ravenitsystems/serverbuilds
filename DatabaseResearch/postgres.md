# Database Research - Postgres


## Instalation

Installation can be done using the standard EPEL repo through the package manager, the only difference between this and other database servers is that the database must be initialized first before the service is started.

```
dnf -y install postgresql-server

postgresql-setup --initdb

systemctl start postgresql

systemctl enable postgresql
```

The configuration files are stored in `/var/lib/pgsql/data`

