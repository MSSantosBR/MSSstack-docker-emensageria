CREATE ROLE emensageria LOGIN
  PASSWORD 'debug1234'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

-- DROP DATABASE emensageria_db;

CREATE DATABASE emensageria_db
  WITH OWNER = emensageria
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       TEMPLATE template0
       CONNECTION LIMIT = -1;
