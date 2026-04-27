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
-- 1) Create application role/user
CREATE ROLE avantiy_secure_billing_platform_user
WITH
    LOGIN
    PASSWORD 'Corralus1980!!'
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION;
-- 2) Create database owned by that user
CREATE DATABASE avantiy_secure_billing_platform_data
    OWNER avantiy_secure_billing_platform_user
    ENCODING 'UTF8'
    TEMPLATE template0;
-- 3) Connect to the new database
\c avantiy_secure_billing_platform_data
-- 4) Make sure permissions are correct on public schema
-- (required for Laravel migrations to create tables)
ALTER SCHEMA public OWNER TO avantiy_secure_billing_platform_user;
GRANT USAGE, CREATE ON SCHEMA public TO avantiy_secure_billing_platform_user;
-- 5) Optional but useful: ensure future objects are accessible
ALTER DEFAULT PRIVILEGES FOR USER avantiy_secure_billing_platform_user IN SCHEMA public
GRANT ALL ON TABLES TO avantiy_secure_billing_platform_user;
ALTER DEFAULT PRIVILEGES FOR USER avantiy_secure_billing_platform_user IN SCHEMA public
GRANT ALL ON SEQUENCES TO avantiy_secure_billing_platform_user;
-- 6) Optional: set default search path
ALTER ROLE avantiy_secure_billing_platform_user
SET search_path = public;
```

# Creating a test table
```

```



By default a postgres server listens on port 5432



