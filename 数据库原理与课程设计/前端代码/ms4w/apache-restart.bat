@ECHO OFF

REM This restarts the apache service 

cd Apache\bin
httpd -k restart -n "Apache MS4W Web Server"
cd ..\..

:ALL_DONE
