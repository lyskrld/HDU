@ECHO OFF

REM Execute this file before running the GDAL, MapServer, and other commandline utilities.
REM After executing this file you should be able 
REM to run the utilities from any commandline location.

set PATH=\ms4w\Apache\cgi-bin;\ms4w\tools\gdal-ogr;\ms4w\tools\mapserv;\ms4w\tools\shapelib;\ms4w\proj\bin;\ms4w\tools\shp2tile;\ms4w\tools\shpdiff;\ms4w\tools\avce00;\ms4w\gdalbindings\python\gdal;\ms4w\tools\php;\ms4w\tools\mapcache;\ms4w\tools\berkeley-db;\ms4w\tools\sqlite;\ms4w\tools\spatialite;\ms4w\tools\unixutils;\ms4w\tools\openssl;\ms4w\tools\curl;\ms4w\tools\geotiff;\ms4w\tools\jpeg;\ms4w\tools\protobuf;\ms4w\Python;\ms4w\Python\Scripts;\ms4w\tools\osm2pgsql;\ms4w\tools\netcdf;\ms4w\tools\pdal;%PATH%
echo GDAL, mapserv, Python, PHP, and commandline MS4W tools path set

set GDAL_DATA=\ms4w\gdaldata

set GDAL_DRIVER_PATH=\ms4w\gdalplugins

set PROJ_LIB=\ms4w\proj\nad

set CURL_CA_BUNDLE=\ms4w\Apache\conf\ca-bundle\cacert.pem

set SSL_CERT_FILE=\ms4w\Apache\conf\ca-bundle\cacert.pem

set OPENSSL_CONF=\ms4w\tools\openssl\openssl.cnf

set PDAL_DRIVER_PATH=\ms4w\Apache\cgi-bin

:ALL_DONE
