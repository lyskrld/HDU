Proj4 Library
=============

The Proj4 library was obtained from https://github.com/OSGeo/PROJ It is used 
in MapServer as a tool for on-the-fly reprojection.

Directory Structure
-------------------

  proj/bin       - proj commandline utilities (execute /ms4w/setenv.bat before
                   using the utilities, to set necessary environment
                   variables)
  
  proj/nad       - contains 'epsg' file, which is used by MapServer to reference
                   various projection parameters
                   
References
----------

For MapServer-related projection issues, start with the mapfile PROJECTION
object explanation page: https://mapserver.org/mapfile/projection.html