SOURCE ./docker-entrypoint-initdb.d/wp_db.sql
CREATE USER 'okiapp_admin'@'%' IDENTIFIED BY 'WvARH7Rh?Qhk!J*R';
GRANT ALL PRIVILEGES ON *.* TO 'okiapp_admin'@'%' WITH GRANT OPTION;