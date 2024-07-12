REM ***********
REM This script creates the 'tinyows' PostgreSQL database, for use with the TinyOWS demo data
REM   and testing with: https://mapserver.org/tinyows/openlayershowto.html
REM
REM Requires:
REM           - 'psql.exe', 'createdb.exe', 'dropdb.exe', and 'shp2pgsql.exe' in your PATH
REM Author:
REM           Jeff McKenna, Gateway Geomatics
REM           email: info@gatewaygeomatics.com
REM
REM Tested with PostgreSQL 10.5, PostGIS 2.4.4
REM ***********

REM Modify the following variables

set DB-NAME=tinyows
set PG-PORT=5432
set PG-SUPERUSER-NAME=postgres
set PG-SUPERUSER-PASSWORD=postgres

REM You shouldn't have to modify anything else after this

SET PGPASSWORD=%PG-SUPERUSER-PASSWORD%
dropdb -U %PG-SUPERUSER-NAME% -p %PG-PORT% %DB-NAME%
createdb -U %PG-SUPERUSER-NAME% -p %PG-PORT% -E UTF8 -T template0 %DB-NAME%
psql -U %PG-SUPERUSER-NAME% -d %DB-NAME% -p %PG-PORT% -c "CREATE EXTENSION postgis;"
psql -U %PG-SUPERUSER-NAME% -d %DB-NAME% -p %PG-PORT% -c "CREATE EXTENSION postgis_topology;"
psql -U %PG-SUPERUSER-NAME% -d %DB-NAME% -p %PG-PORT% -c "CREATE EXTENSION adminpack;"
psql -U %PG-SUPERUSER-NAME% -d %DB-NAME% -p %PG-PORT% -c "ALTER DATABASE %DB-NAME% SET client_min_messages TO WARNING;"

REM ************************
REM **** IMPORT DATA   *****
REM ************************

shp2pgsql.exe -c -D -g geom -s 31467 -I -W LATIN1 data\gruenflaechen.shp frida > data\frida.sql
psql.exe -U %PG-SUPERUSER-NAME% -d %DB-NAME% -p %PG-PORT% -f data\frida.sql