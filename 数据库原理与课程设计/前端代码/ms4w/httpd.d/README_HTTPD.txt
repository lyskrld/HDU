This folder contains a series of httpd configuration files, one for each
web application that is installed, and one for local configuration.

The files must be named "httpd_<app_name>.conf" where <app_name> is some
unique identifying name for an application.  For instance, to install
gmap, create a file called httpd_gmap.conf.  The web server must be
restarted after adding or changing files in this directory.

Note that if you would like to have a local configuration that is not
affected by updates to either the core package or app packages,
create an httpd_local.conf file and add directives there.

In general, you should just add one or more of the following for any
particular application:

Alias /gmap/ "/ms4w/apps/gmap/htdocs/"

<Directory "/ms4w/apps/gmap/htdocs/">
  AllowOverride None
  Options Indexes FollowSymLinks Multiviews 
  Order allow,deny
  Allow from all
</Directory>

Note that it is good practice to create a web-accessible directory
inside your application directory and point the above directives to
that directory rather than to the root of the application.  This allows
the addition of other application-specific files that are not web-
accessible.