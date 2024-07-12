This folder is used to store temporary files and should be cleaned
out periodically.  It contains a single folder called ms_tmp that
is used for web-accessible temporary files.  The ms_tmp folder
should not be removed when cleaning this directory.  However,
the file contents of the ms_tmp folder should be deleted periodically 
(the 'buttons' folder should not be removed however).

A small script 'del-ms_tmp.bat' is included in this package.  Running
this file will remove the file contents of the 'ms_tmp' folder.  You
can use the Windows Scheduled Tasks utility to run the script automatically.