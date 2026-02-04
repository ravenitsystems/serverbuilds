dnf -y install postgresql-server

postgresql-setup --initdb

systemctl start postgresql

systemctl enable postgresql

service postgresql restart
