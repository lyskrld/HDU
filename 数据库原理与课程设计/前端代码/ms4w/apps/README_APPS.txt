This folder is used to distribute pre-configured web applications. The
applications typically create one or more directories in this folder and
an httpd configuration file in the httpd.d folder.  See the README.txt
in the httpd.d folder for information on configuring applications to
be automatically accessible via an alias.

Note that it is good practice to create a web-accessible directory
inside your application directory and point the above directives to
that directory rather than to the root of the application.  This allows
the addition of other application-specific files that are not web-
accessible.