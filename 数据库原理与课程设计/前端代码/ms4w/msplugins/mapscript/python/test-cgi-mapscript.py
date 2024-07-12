#!C:\ms4w\Python\python.exe -u

import cgi
import cgitb; cgitb.enable();

cgi.test()

import mapscript

print ("<h2>mapscript module attributes</h2>")
print (dir(mapscript))
