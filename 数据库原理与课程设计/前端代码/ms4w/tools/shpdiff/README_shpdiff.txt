shpdiff for MS4W Build Notes
============================

Source
------

  http://legacy.obviously.com/gis/shpdiff/

Description
-----------

  The "shpdiff" utility compares two shape files, printing a human-readable summary 
  of any differences, in a similar manner to the well known diff utility for 
  Unix/Linux.  The shapefile difference utility is helpful when reviewing or 
  merging changes made to an existing GIS dataset or theme.  It is particularly 
  useful when multiple contributors using ArcView maintain or collaborate on 
  development of the the same layer.  Both the attributes (stored in .dbf 
  database files) and the shapes (stored in .shp and .shx files) are compared.

Execution
---------

  Before running shpdiff.exe, you must set the appropriate PATH values by executing
  the /ms4w/setenv.bat script.
  
Usage
-----

  shpdiff original_shapefile comparison_shapefile
  
Build
-----

  compiled for win32 by Jeff McKenna, Gateway Geomatics
