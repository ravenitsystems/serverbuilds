# Installation on Centos 8 based systems

```
dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

dnf -qy module disable postgresql

dnf -y install postgresql18-server postgresql18

/usr/pgsql-18/bin/postgresql-18-setup initdb

systemctl enable --now postgresql-18
```

# Verify that it all went ok

## Verify the installed version
```
psql --version
```

## Verify the server status
```
systemctl status postgresql-18
```

# Setting up the database and schema

To get into postgresql command line as a super user use `sudo -u postgres psql`

# Creating A Database and User
```
CREATE DATABASE av2;
CREATE USER av2_user WITH PASSWORD '<password>';
grant all privileges on database av2 to av2_user;

```



By default a postgres server listens on port 5432



