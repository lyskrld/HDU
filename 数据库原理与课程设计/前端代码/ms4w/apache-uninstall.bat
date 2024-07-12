@ECHO OFF

REM This stops and uninstalls apache service

cd Apache\bin
httpd -k stop -n "Apache MS4W Web Server"
httpd -k uninstall -n "Apache MS4W Web Server"
cd ..\..

:ALL_DONE
