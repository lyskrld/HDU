***********************************
MapServer for Windows (MS4W) README
***********************************

:Author: Jeff McKenna, `Gateway Geomatics`_
:Last Updated: 2020-01-30

.. _`Gateway Geomatics`: https://gatewaygeomatics.com/
.. _`User Forum`: https://ms4w.com/forum/

.. contents:: Table of Contents
    :depth: 3
    :backlinks: top
    
Introduction
============

Welcome to MS4W, the quick and easy installer developed by 
`Gateway Geomatics <https://gatewaygeomatics.com/>`__ for setting 
up MapServer For Windows and its accompanying applications 
(e.g. GeoMoose, Mapbender, OpenLayers, etc.). The purpose of this 
package is to allow novice to advanced MapServer users to quickly 
install a MapServer development environment on their 
Windows systems. The reasons for needing to do this are 
diverse but, in general, this package supports: developers 
who want to get to a stable state quickly, trainers who 
need an easily-installed configuration identical across 
multiple installs, and novices who need help just getting 
all the needed bits and pieces together.

Design
======

The MS4W package is designed to perform a full installation 
of Apache, PHP, MapServer CGI, MapScript (CSharp, Java, 
PHP, Python), and to provide the capability to install 
additional applications easily and quickly. The simplest 
way to do this on Windows is to provide a predetermined 
directory structure and force everything into that mold.

The directory structure, while fixed within itself, is 
designed to be somewhat portable. While the ms4w_xxx.zip
file needs to be installed at the root of a hard drive, 
it doesn't have to be the C:/ drive. Moving the package 
to the root of a different drive is simple - just copy 
it there. To move it to a subdirectory is more difficult 
- you'll need to search for /ms4w in all the files and 
replace it with your new path.

The design also accommodates simple upgrades to the core 
package and to applications, without affecting the local 
configuration or the configuration of other installed 
applications.

Contents
========

The following are included in the base package:

- Apache version 2.4.41

- PHP version 7.2.27

- Python version 3.7.5

- MapServer 7.6.0-dev CGI and MapScript
  
- GDAL 2.4.4 and bindings

- MapCache 1.9dev

- MapServer utilities

- GDAL/OGR utilities

- PROJ utilities

- PDAL utilities

- shp2tile utility

- osm2pgsql utility

- shapelib utilities

- shpdiff utility

- avce00 utilities

- spatialite utilities

- unixutils
        
- OWTChart 1.2.0

- H264 Streaming Module for Apache

.. Tip::

    If your server needs support for a specific version of PHP, 
    Python, Apache, MapServer, GDAL, Oracle, ECW, Microsoft SQL Server, 
    or any of MS4W's hundreds of libraries, or a specific Windows version, 
    or an entire MS4W package in x64 or 32bit, please contact 
    `Gateway Geomatics`_.  
    
MapServer Version Information
-----------------------------

::

  MapServer version 7.6.0-dev (MS4W 4.0.3) OUTPUT=PNG OUTPUT=JPEG 
  OUTPUT=KML SUPPORTS=PROJ SUPPORTS=AGG SUPPORTS=FREETYPE 
  SUPPORTS=CAIRO SUPPORTS=SVG_SYMBOLS SUPPORTS=SVGCAIRO 
  SUPPORTS=ICONV SUPPORTS=FRIBIDI SUPPORTS=WMS_SERVER 
  SUPPORTS=WMS_CLIENT SUPPORTS=WFS_SERVER SUPPORTS=WFS_CLIENT 
  SUPPORTS=WCS_SERVER SUPPORTS=SOS_SERVER SUPPORTS=FASTCGI 
  SUPPORTS=THREADS SUPPORTS=GEOS SUPPORTS=POINT_Z_M SUPPORTS=PBF 
  INPUT=JPEG INPUT=POSTGIS INPUT=OGR INPUT=GDAL INPUT=SHAPEFILE

MapServer Build Environment
---------------------------

Compiled, packaged, documented, and tested by `Gateway Geomatics`_.  
Please help support this great product that is downloaded 
over 6,000 times a month by organizations of all sizes - 
please contact us directly at `info@gatewaygeomatics.com`_ for 
custom builds or requests.  Thank you in advance for your 
generous support!
  
.. _`info@gatewaygeomatics.com`: mailto:info@gatewaygeomatics.com

Library versions used to build this version of MapServer:

::

    apache-ant-1.7.0
    apr-1.7.0
    apr-iconv-1.2.2
    apr-util-1.6.1
    berkeley-db-18.1.25
    bzip2-1.0.6
    cairo-1.16.0
    curl-7.68.0
    expat-2.2.9
    fcgi-2.4.0
    fits-3.470
    freetype-2.10.1
    freexl-1.0.5
    fribidi-0.19.1
    gdal-2.4.4
    geos-3.8.0
    gettext-runtime-0.17-source
    giflib-5.1.2
    harfbuzz-2.6.4
    hdf-4.2.14
    hdf5-1.10.5
    httpd-2.4.41
    jbigkit-1.6
    libecwj2-3.3
    libgeotiff-1.4.3
    libiconv-1.15
    libjpeg-turbo-git-20191012    
    libKML-git-20180824
    libpng-1.6.37
    librttopo-1.1.0
    libspatialite-5.0.0-beta0
    libspatialite-tools-4.4.0-RC0
    libsvg-0.5.0
    libsvg-cairo-0.5.0
    libtiff-4.1.0
    libxml2-2.9.9
    lua-5.1.5
    mapcache-1.9dev
    mapserver-git-master-20190708
    mod_fcgid-2.3.9
    mod_h264_streaming-2.2.7
    mod_wsgi-4.6.8
    mrsid-9.5.4
    mysql-6.1.11
    netcdf-c-4.7.3
    openssl-1.1.1d
    oracle-12.2.0.1.0
    pcre-8.42
    pixman-0.38.4
	php_ogr-1.5.1
    poppler-0.51.0
    postgresql-12.1
    proj-5.2.0
    protobuf-3.6.1
    protobuf-c-1.3.1
    Python-3.7.5
    readosm-1.0.0e
    shapelib-1.5.0
    spatialite-tools-4.4.0-RC0
    sqlite-3.30.1
    swig-1.3.39
    swigwin-3.0.12
    szip-2.1.1
    uriparser-0.7.5
    xerces-c-3.2.2
    zlib-1.2.7

OGR Formats Supported
---------------------

See the `OGR formats page`_ for full driver descriptions.

.. _OGR formats page: https://gdal.org/drivers/vector/

.. Note::

    If you require a specific data format or an updated 
    supported version, please contact `Gateway Geomatics`_
    for custom build information.    

::

   Supported Formats:
	  PCIDSK -raster,vector- (rw+v): PCIDSK Database File
	  netCDF -raster,vector- (rw+s): Network Common Data Format
	  PDF -raster,vector- (rw+vs): Geospatial PDF
	  MBTiles -raster,vector- (rw+v): MBTiles
	  EEDA -vector- (ro): Earth Engine Data API
	  DB2ODBC -raster,vector- (rw+): IBM DB2 Spatial Database
	  ESRI Shapefile -vector- (rw+v): ESRI Shapefile
	  MapInfo File -vector- (rw+v): MapInfo File
	  UK .NTF -vector- (rov): UK .NTF
	  OGR_SDTS -vector- (rov): SDTS
	  S57 -vector- (rw+v): IHO S-57 (ENC)
	  DGN -vector- (rw+v): Microstation DGN
	  OGR_VRT -vector- (rov): VRT - Virtual Datasource
	  REC -vector- (ro): EPIInfo .REC
	  Memory -vector- (rw+): Memory
	  BNA -vector- (rw+v): Atlas BNA
	  CSV -vector- (rw+v): Comma Separated Value (.csv)
	  NAS -vector- (rov): NAS - ALKIS
	  GML -vector- (rw+v): Geography Markup Language (GML)
	  GPX -vector- (rw+v): GPX
	  LIBKML -vector- (rw+v): Keyhole Markup Language (LIBKML)
	  KML -vector- (rw+v): Keyhole Markup Language (KML)
	  GeoJSON -vector- (rw+v): GeoJSON
	  GeoJSONSeq -vector- (rw+v): GeoJSON Sequence
	  ESRIJSON -vector- (rov): ESRIJSON
	  TopoJSON -vector- (rov): TopoJSON
	  OGR_GMT -vector- (rw+v): GMT ASCII Vectors (.gmt)
	  GPKG -raster,vector- (rw+vs): GeoPackage
	  SQLite -vector- (rw+v): SQLite / Spatialite
	  ODBC -vector- (rw+): ODBC
	  WAsP -vector- (rw+v): WAsP .map format
	  PGeo -vector- (ro): ESRI Personal GeoDatabase
	  MSSQLSpatial -vector- (rw+): Microsoft SQL Server Spatial Database
	  PostgreSQL -vector- (rw+): PostgreSQL/PostGIS
	  MySQL -vector- (rw+): MySQL
	  OpenFileGDB -vector- (rov): ESRI FileGDB
	  XPlane -vector- (rov): X-Plane/Flightgear aeronautical data
	  DXF -vector- (rw+v): AutoCAD DXF
	  CAD -raster,vector- (rovs): AutoCAD Driver
	  Geoconcept -vector- (rw+v): Geoconcept
	  GeoRSS -vector- (rw+v): GeoRSS
	  GPSTrackMaker -vector- (rw+v): GPSTrackMaker
	  VFK -vector- (ro): Czech Cadastral Exchange Data Format
	  PGDUMP -vector- (w+v): PostgreSQL SQL dump
	  OSM -vector- (rov): OpenStreetMap XML and PBF
	  GPSBabel -vector- (rw+): GPSBabel
	  SUA -vector- (rov): Tim Newport-Peace's Special Use Airspace Format
	  OpenAir -vector- (rov): OpenAir
	  OGR_PDS -vector- (rov): Planetary Data Systems TABLE
	  WFS -vector- (rov): OGC WFS (Web Feature Service)
	  WFS3 -vector- (ro): OGC WFS 3 client (Web Feature Service)
	  HTF -vector- (rov): Hydrographic Transfer Vector
	  AeronavFAA -vector- (rov): Aeronav FAA
	  Geomedia -vector- (ro): Geomedia .mdb
	  EDIGEO -vector- (rov): French EDIGEO exchange format
	  GFT -vector- (rw+): Google Fusion Tables
	  SVG -vector- (rov): Scalable Vector Graphics
	  CouchDB -vector- (rw+): CouchDB / GeoCouch
	  Cloudant -vector- (rw+): Cloudant / CouchDB
	  Idrisi -vector- (rov): Idrisi Vector (.vct)
	  ARCGEN -vector- (rov): Arc/Info Generate
	  SEGUKOOA -vector- (rov): SEG-P1 / UKOOA P1/90
	  SEGY -vector- (rov): SEG-Y
	  ODS -vector- (rw+v): Open Document/ LibreOffice / OpenOffice Spreadsheet
	  XLSX -vector- (rw+v): MS Office Open XML spreadsheet
	  ElasticSearch -vector- (rw+): Elastic Search
	  Walk -vector- (ro): Walk
	  Carto -vector- (rw+): Carto
	  AmigoCloud -vector- (rw+): AmigoCloud
	  SXF -vector- (rov): Storage and eXchange Format
	  Selafin -vector- (rw+v): Selafin
	  JML -vector- (rw+v): OpenJUMP JML
	  PLSCENES -raster,vector- (ro): Planet Labs Scenes API
	  CSW -vector- (ro): OGC CSW (Catalog  Service for the Web)
	  VDV -vector- (rw+v): VDV-451/VDV-452/INTREST Data Format
	  GMLAS -vector- (rwv): Geography Markup Language (GML) driven by application schemas
	  MVT -vector- (rw+v): Mapbox Vector Tiles
	  TIGER -vector- (rw+v): U.S. Census TIGER/Line
	  AVCBin -vector- (rov): Arc/Info Binary Coverage
	  AVCE00 -vector- (rov): Arc/Info E00 (ASCII) Coverage
	  NGW -raster,vector- (rw+s): NextGIS Web
	  HTTP -raster,vector- (ro): HTTP Fetching Wrapper
   
Oracle - see the `GDAL Plugins`_ section of this document to enable
   
.. Tip::

    ::

      "ro" means read-only
      "rw" means read and one-time creation only
      "rw+" means read, create and update
      "w+" means write-only
      "v" means that it supports virtual files  
   
GDAL Formats Supported
----------------------

See the `GDAL formats page`_ for full driver descriptions.

.. _GDAL formats page: https://gdal.org/drivers/raster/

.. Note::

    If you require a specific data format or an updated 
    supported version, please contact `Gateway Geomatics`_
    for custom build information. 

::

  Supported Formats:
	  VRT -raster- (rw+v): Virtual Raster
	  DERIVED -raster- (ro): Derived datasets using VRT pixel functions
	  GTiff -raster- (rw+vs): GeoTIFF
	  NITF -raster- (rw+vs): National Imagery Transmission Format
	  RPFTOC -raster- (rovs): Raster Product Format TOC format
	  ECRGTOC -raster- (rovs): ECRG TOC format
	  HFA -raster- (rw+v): Erdas Imagine Images (.img)
	  SAR_CEOS -raster- (rov): CEOS SAR Image
	  CEOS -raster- (rov): CEOS Image
	  JAXAPALSAR -raster- (rov): JAXA PALSAR Product Reader (Level 1.1/1.5)
	  GFF -raster- (rov): Ground-based SAR Applications Testbed File Format (.gff)
	  ELAS -raster- (rw+v): ELAS
	  AIG -raster- (rov): Arc/Info Binary Grid
	  AAIGrid -raster- (rwv): Arc/Info ASCII Grid
	  GRASSASCIIGrid -raster- (rov): GRASS ASCII Grid
	  SDTS -raster- (rov): SDTS Raster
	  DTED -raster- (rwv): DTED Elevation Raster
	  PNG -raster- (rwv): Portable Network Graphics
	  JPEG -raster- (rwv): JPEG JFIF
	  MEM -raster- (rw+): In Memory Raster
	  JDEM -raster- (rov): Japanese DEM (.mem)
	  GIF -raster- (rwv): Graphics Interchange Format (.gif)
	  BIGGIF -raster- (rov): Graphics Interchange Format (.gif)
	  ESAT -raster- (rov): Envisat Image Format
	  FITS -raster- (rw+): Flexible Image Transport System
	  BSB -raster- (rov): Maptech BSB Nautical Charts
	  XPM -raster- (rwv): X11 PixMap Format
	  BMP -raster- (rw+v): MS Windows Device Independent Bitmap
	  DIMAP -raster- (rov): SPOT DIMAP
	  AirSAR -raster- (rov): AirSAR Polarimetric Image
	  RS2 -raster- (rovs): RadarSat 2 XML Product
	  SAFE -raster- (rov): Sentinel-1 SAR SAFE Product
	  PCIDSK -raster,vector- (rw+v): PCIDSK Database File
	  PCRaster -raster- (rw+): PCRaster Raster File
	  ILWIS -raster- (rw+v): ILWIS Raster Map
	  SGI -raster- (rw+v): SGI Image File Format 1.0
	  SRTMHGT -raster- (rwv): SRTMHGT File Format
	  Leveller -raster- (rw+v): Leveller heightfield
	  Terragen -raster- (rw+v): Terragen heightfield
	  GMT -raster- (rw): GMT NetCDF Grid Format
	  netCDF -raster,vector- (rw+s): Network Common Data Format
	  HDF4 -raster- (ros): Hierarchical Data Format Release 4
	  HDF4Image -raster- (rw+): HDF4 Dataset
	  ISIS3 -raster- (rw+v): USGS Astrogeology ISIS cube (Version 3)
	  ISIS2 -raster- (rw+v): USGS Astrogeology ISIS cube (Version 2)
	  PDS -raster- (rov): NASA Planetary Data System
	  PDS4 -raster- (rw+vs): NASA Planetary Data System 4
	  VICAR -raster- (rov): MIPL VICAR file
	  TIL -raster- (rov): EarthWatch .TIL
	  ERS -raster- (rw+v): ERMapper .ers Labelled
	  L1B -raster- (rovs): NOAA Polar Orbiter Level 1b Data Set
	  FIT -raster- (rwv): FIT Image
	  GRIB -raster- (rwv): GRIdded Binary (.grb, .grb2)
	  MrSID -raster- (rov): Multi-resolution Seamless Image Database (MrSID)
	  JP2MrSID -raster- (rov): MrSID JPEG2000
	  MG4Lidar -raster- (ro): MrSID Generation 4 / Lidar (.sid)
	  RMF -raster- (rw+v): Raster Matrix Format
	  WCS -raster- (rovs): OGC Web Coverage Service
	  WMS -raster- (rwvs): OGC Web Map Service
	  MSGN -raster- (rov): EUMETSAT Archive native (.nat)
	  RST -raster- (rw+v): Idrisi Raster A.1
	  INGR -raster- (rw+v): Intergraph Raster
	  GSAG -raster- (rwv): Golden Software ASCII Grid (.grd)
	  GSBG -raster- (rw+v): Golden Software Binary Grid (.grd)
	  GS7BG -raster- (rw+v): Golden Software 7 Binary Grid (.grd)
	  COSAR -raster- (rov): COSAR Annotated Binary Matrix (TerraSAR-X)
	  TSX -raster- (rov): TerraSAR-X Product
	  COASP -raster- (ro): DRDC COASP SAR Processor Raster
	  R -raster- (rwv): R Object Data Store
	  MAP -raster- (rov): OziExplorer .MAP
	  KMLSUPEROVERLAY -raster- (rwv): Kml Super Overlay
	  PDF -raster,vector- (rw+vs): Geospatial PDF
	  Rasterlite -raster- (rwvs): Rasterlite
	  MBTiles -raster,vector- (rw+v): MBTiles
	  PLMOSAIC -raster- (ro): Planet Labs Mosaics API
	  CALS -raster- (rwv): CALS (Type 1)
	  WMTS -raster- (rwv): OGC Web Map Tile Service
	  SENTINEL2 -raster- (rovs): Sentinel 2
	  MRF -raster- (rw+v): Meta Raster Format
	  PNM -raster- (rw+v): Portable Pixmap Format (netpbm)
	  DOQ1 -raster- (rov): USGS DOQ (Old Style)
	  DOQ2 -raster- (rov): USGS DOQ (New Style)
	  PAux -raster- (rw+v): PCI .aux Labelled
	  MFF -raster- (rw+v): Vexcel MFF Raster
	  MFF2 -raster- (rw+): Vexcel MFF2 (HKV) Raster
	  FujiBAS -raster- (rov): Fuji BAS Scanner Image
	  GSC -raster- (rov): GSC Geogrid
	  FAST -raster- (rov): EOSAT FAST Format
	  BT -raster- (rw+v): VTP .bt (Binary Terrain) 1.3 Format
	  LAN -raster- (rw+v): Erdas .LAN/.GIS
	  CPG -raster- (rov): Convair PolGASP
	  IDA -raster- (rw+v): Image Data and Analysis
	  NDF -raster- (rov): NLAPS Data Format
	  EIR -raster- (rov): Erdas Imagine Raw
	  DIPEx -raster- (rov): DIPEx
	  LCP -raster- (rwv): FARSITE v.4 Landscape File (.lcp)
	  GTX -raster- (rw+v): NOAA Vertical Datum .GTX
	  LOSLAS -raster- (rov): NADCON .los/.las Datum Grid Shift
	  NTv1 -raster- (rov): NTv1 Datum Grid Shift
	  NTv2 -raster- (rw+vs): NTv2 Datum Grid Shift
	  CTable2 -raster- (rw+v): CTable2 Datum Grid Shift
	  ACE2 -raster- (rov): ACE2
	  SNODAS -raster- (rov): Snow Data Assimilation System
	  KRO -raster- (rw+v): KOLOR Raw
	  ROI_PAC -raster- (rw+v): ROI_PAC raster
	  RRASTER -raster- (rw+v): R Raster
	  BYN -raster- (rw+v): Natural Resources Canada's Geoid
	  ARG -raster- (rwv): Azavea Raster Grid format
	  RIK -raster- (rov): Swedish Grid RIK (.rik)
	  USGSDEM -raster- (rwv): USGS Optional ASCII DEM (and CDED)
	  GXF -raster- (rov): GeoSoft Grid Exchange Format
	  BAG -raster- (rwv): Bathymetry Attributed Grid
	  HDF5 -raster- (rovs): Hierarchical Data Format Release 5
	  HDF5Image -raster- (rov): HDF5 Dataset
	  NWT_GRD -raster- (rw+v): Northwood Numeric Grid Format .grd/.tab
	  NWT_GRC -raster- (rov): Northwood Classified Grid Format .grc/.tab
	  ADRG -raster- (rw+vs): ARC Digitized Raster Graphics
	  SRP -raster- (rovs): Standard Raster Product (ASRP/USRP)
	  BLX -raster- (rwv): Magellan topo (.blx)
	  PostGISRaster -raster- (rws): PostGIS Raster driver
	  SAGA -raster- (rw+v): SAGA GIS Binary Grid (.sdat, .sg-grd-z)
	  IGNFHeightASCIIGrid -raster- (rov): IGN France height correction ASCII Grid
	  XYZ -raster- (rwv): ASCII Gridded XYZ
	  HF2 -raster- (rwv): HF2/HFZ heightfield raster
	  OZI -raster- (rov): OziExplorer Image File
	  CTG -raster- (rov): USGS LULC Composite Theme Grid
	  E00GRID -raster- (rov): Arc/Info Export E00 GRID
	  ZMap -raster- (rwv): ZMap Plus Grid
	  NGSGEOID -raster- (rov): NOAA NGS Geoid Height Grids
	  IRIS -raster- (rov): IRIS data (.PPI, .CAPPi etc)
	  PRF -raster- (rov): Racurs PHOTOMOD PRF
	  RDA -raster- (ro): DigitalGlobe Raster Data Access driver
	  EEDAI -raster- (ros): Earth Engine Data API Image
	  SIGDEM -raster- (rwv): Scaled Integer Gridded DEM .sigdem
	  DB2ODBC -raster,vector- (rw+): IBM DB2 Spatial Database
	  GPKG -raster,vector- (rw+vs): GeoPackage
	  CAD -raster,vector- (rovs): AutoCAD Driver
	  PLSCENES -raster,vector- (ro): Planet Labs Scenes API
	  NGW -raster,vector- (rw+s): NextGIS Web
	  GenBin -raster- (rov): Generic Binary (.hdr Labelled)
	  ENVI -raster- (rw+v): ENVI .hdr Labelled
	  EHdr -raster- (rw+v): ESRI .hdr Labelled
	  ISCE -raster- (rw+v): ISCE raster
	  HTTP -raster,vector- (ro): HTTP Fetching Wrapper
   
Directory Structure
-------------------

- ms4w/ 
   - the main directory, assumed to be at the root of a 
     drive, normally C:

- ms4w/Apache 
   - the Apache installation

- ms4w/Apache/bin 
   - the Apache binaries

- ms4w/Apache/cgi-bin 
   - the location of mapserv.exe and its supporting 
     libraries, and php.ini, php.exe.
     
- ms4w/Apache/cgi-bin/zooplugins 
   - location of ZOO-Project files to enable additional support
     (see the `ZOO-Project`_ section of this document)     

- ms4w/Apache/conf 
   - the Apache configuration files. These should not be 
     modified.  Place all application-specific and local 
     httpd.conf files in /ms4w/httpd.d (see the README.txt 
     in that directory)

- ms4w/Apache/error 
   - error files for Apache to use

- ms4w/Apache/htdocs 
   - the Apache Web root directory, you shouldn't install 
     much in here except perhaps for testing.

- ms4w/Apache/icons 
   - icons used by Apache

- ms4w/Apache/include 
   - include directory for compiling against Apache

- ms4w/Apache/lib 
   - lib files for building against Apache

- ms4w/Apache/logs 
   - log files for Apache are stored here, this should be 
     archived or cleaned every so often.

- ms4w/Apache/manual 
   - the Apache manual pages.

- ms4w/Apache/modules 
   - modules for Apache
     (see the `Apache Modules`_ section of this document)

- ms4w/Apache/php 
   - the PHP installation
   
- ms4w/Apache/php/ext
   - location of phpmapscript dll   

- ms4w/apps 
   - put all applications in subdirectories here.
   
- ms4w/apps/etc
   - sample fonts and symbols for use in MapServer mapfiles
   
- ms4w/gdalbindings
   - contain GDAL bindings for CSharp, Java, and Python
     (see the `GDAL Bindings`_ section of this document)

- ms4w/gdaldata 
   - supporting files for GDAL data formats
    
- ms4w/gdalplugins 
   - move dlls to this folder that are required for GDAL plugins 
     e.g. 'oci_OCI.dll'
     (see the `GDAL Plugins`_ section of this document)
    
- ms4w/httpd.d 
   - put all application-specific and local httpd.conf files 
     here (see the README.txt in that directory)
     
- ms4w/msplugins
   - location of the plugin dlls for MapServer
     (see the `MapServer Plugins`_ section of this document)
     
- ms4w/msplugins/mapscript 
   - location of CSharp, Java, and Python mapscript files
     (see the `MapScript configuration`_ section of this document)     

- ms4w/proj 
   - an installation of PROJ (formerly referred to as "PROJ.4")
   - the epsg file used is /ms4w/proj/nad/epsg
   
- ms4w/Python 
   - an embedded installation of Python
   - must execute setenv.bat before use   

- ms4w/tmp 
   - temporary files go here. This should be cleaned 
     regularly

- ms4w/tmp/ms_tmp 
   - temporary files that need to be Web-accessible go 
     here (i.e. image files created by mapserver). This is 
     available as /ms_tmp/ via URL. Normally this means 
     that your MAP files would have an IMAGEPATH of 
     /ms4w/tmp/ms_tmp/ and a IMAGEURL of /ms_tmp/
    
- ms4w/tools 
   - contains useful tools such as the gdal/ogr utilities 
     and mapserv utilities (note that before running these 
     you must execute the /ms4w/setenv.bat script in 
     your command window)

How to Install MS4W
===================

Upgrading from an older version of MS4W
---------------------------------------

If you already have MS4W installed please do the following:
  
- open a DOS command window and execute the file 
  '/ms4w/apache-uninstall.bat' at the commandline.  This 
  file will stop and uninstall your Apache service.  You 
  should see the following message flash in the command 
  window:  

:: 

  The "Apache MS4W Web Server" service is stopping.
  The "Apache MS4W Web Server" service has stopped.
  
  Removing the "Apache MS4W Web Server" service
  The "Apache MS4W Web Server" service has been removed 
  successfully.

- your old apache service has now been removed 

- make sure no files or other services point the your ms4w 
  folder.  If your browser is currently open and you are a 
  viewing an ms4w page you will not be able to rename the 
  ms4w folder.  Therefore you must close all ms4w documents, 
  all ms4w browser windows...make sure no running files 
  point to the ms4w folder.

- rename the old ms4w folder to something like 'ms4w-old'

- extract the ms4w_xx.zip file to the root of a
  drive on your machine

- if successful, you should have a new directory named 'ms4w'
  at the root of the drive you chose (e.g. C:/ms4w or D:/ms4w ).

- follow the rest of the install instructions in 
  /ms4w/README_INSTALL.txt to start apache...


Extracting MS4W for the first time
----------------------------------


Please read through the following instructions before 
starting your installation.

1. To install the MS4W .zip file, use a compression program 
   (e.g. `7zip <http://www.7-zip.org/>`_) to extract the package at the root of a 
   drive, e.g., drive C:/. If successful, you should have a 
   new directory named 'ms4w' at the root of the drive you 
   chose (e.g. C:/ms4w).
   
   .. WARNING::
   
       If you are using the setup.exe installer: Some applications may 
       have a problem if you install MS4W
       in a path containing spaces.  It is therefore not
       recommended to install MS4W in a path that contains
       spaces.  It is always best to install MS4W at the root of a
       drive, such as C:/ or D:/
       
2. Be sure to follow the instructions in the local file 
   `/ms4w/REQUIREMENTS.txt` to install the C++ Redistributable on 
   your system before proceeding.

3. Start your MS4W Apache Web Server by running
   /ms4w/apache-install.bat (open a Command Prompt window and 
   execute it at the command line - it is not recommended
   to just double-click the file). This file installs Apache as a 
   Windows service (called "Apache Web Server") so that it 
   starts whenever your machine is restarted.  When 
   executed, the following message should be displayed in the
   command window:
    
   ::
   
        Installing the Apache MS4W Web Server service
        The Apache MS4W Web Server service is successfully installed.
        Testing httpd.conf....
        Errors reported here must be corrected before the service 
        can be started.
        The Apache MS4W Web Server service is starting.
        The Apache MS4W Web Server service was started successfully.
      
   This means that Apache is running and installed as a 
   service.
   
   **Note for Windows 10, 8, 7 and Vista Users:** 
   
   In order to run the apache-install.bat file, you must do
   the following:

   1. In Windows Explorer, goto the location of your cmd.exe
      file (C:/Windows/System32)
   
   2. Right-click the cmd.exe executable and choose `Run as 
      Administrator`
   
   3. Navigate to your ms4w folder in the command prompt window
      and run apache-install.bat   
     
4. To test that Apache is running properly, open your Web 
   browser and find your local host Web service by entering 
   one of the following URLs:

   ::
   
        http://localhost/

        or

        http://127.0.0.1/

   You should now see the main MS4W page in your Web 
   browser. This gives you general information about your 
   install along with configuration information. If this is 
   your first time using MS4W it is very important that you 
   review the listed "Features" installed within MS4W, and 
   test them by selecting each link found on this page.


5. Technically, at this point, MS4W is installed! However, 
   as you may have noticed from the MS4W main index.html 
   page, there are no applications running. What this means 
   is that there are no Web applications like GeoMoose or
   OpenLayers found within MS4W's Web-accessible directory, 
   /ms4w/apps/. The MS4W-configured Web applications can 
   be found on https://ms4w.com/release/apps/ 
   as separate zip files.

6. To install these Web application into /ms4w/apps/ all 
   that is required is to unzip the Web application 
   compressed file at the same root directory as MS4W 
   (e.g., C:/).

   Two things should happen when uncompressing this file. 
   First, the Web application directory should appear 
   within /ms4w/apps/.  Second, a new httpd_*.conf file 
   should be added to /ms4w/httpd.d/httpd_*.conf. (The 
   /httpd.d/ directory contains Apache configuration files 
   that define which files on your computer/server are 
   Web-accessible. For each Web application that you 
   install, a new configuration file will be found.)

7. The definitions of these Web-accessible directories are 
   called Web Aliases. In order to activate a Web Alias you 
   must restart Apache.  To test your latest installed 
   application, go to the MS4W main index.html page (i.e., 
   http://localhost/). In the applications section you 
   should now find a link to the application you just 
   installed. Select the link to the recently installed 
   application to see if it is configured correctly. Another 
   option is to find the Web Alias for your application and 
   call it from your Web browser directly. For example, if 
   you have installed the latest MS4W version of GeoMoose, 
   the Web Alias is "geomoose2". To go to the 
   GeoMoose index page, simply enter http://localhost/geomoose2/.

   Note: Applications with configuration files (e.g., GeoMoose 
   and OpenLayers) generally do not require any editing of 
   their files in order to work. Just unzip to the 
   appropriate driver root and restart Apache.

   WARNING: It is very possible that you may wish (but not 
   encouraged!) to run multiple versions of the same 
   product. For example, GeoMoose 2.8.0 vs. 
   GeoMoose 2.8.1. When installing these ms4w 
   GeoMoose application packages, you will notice when 
   unzipping GeoMoose that the httpd_geomoose2_ms4w.conf file found 
   under ./ms4w/httpd.d/ will be overwritten by the GeoMoose 
   you are currently installing. The reason for this is 
   that the GeoMoose Alias stays the same from version to new 
   version of GeoMoose. So, if you overwrite the 
   httpd_geomoose2_ms4w.conf when unzipping and then restart Apache, 
   you will get the latest version of GeoMoose that you just 
   installed. To run both GeoMoose versions simply follow the 
   instructions in Step 7. 
    

8. You also can create new Web Alias(es). To configure your 
   own personal Web Alias(es), follow the instructions in 
   /ms4w/httpd.d/README_HTTPD.txt

MapServer Plugins 
-----------------

Oracle 10g & 11g & 12c
######################

Steps to Enable Oracle 10g or 11g or 12c Support in MS4W
********************************************************

Oracle Spatial support in MapServer is handled by two methods: 
1) natively in MapServer, or 2) through the GDAL library.

1. Make sure you have Oracle 10g or 11g or 12c client software 
   installed on your machine (the same machine that you 
   are running MS4W on).  
   
   .. WARNING::
   
       Since the default MS4W package is 32-bit, you must 
       install the Oracle 32-bit client, in order to allow 
       MapServer and its tools to communicate with Oracle 
       (even if the Oracle server is x64).  If you need a 
       full x64 custom MS4W build please contact 
       `Gateway Geomatics`_.

2. For direct access to Oracle Spatial, replace the existing 
   libmap.dll in /ms4w/Apache/cgi-bin/ with the one in the 
   /ms4w/msplugins/oracle/
   folder.
   
   If this is successful, executing the following at the 
   commandline (after setting /ms4w/setenv.bat) 
   "mapserv -v" should return a string that contains
   "INPUT=ORACLESPATIAL".
   
   .. Note::
  
       It is possible that MapServer/Apache may have trouble 
       locating your Oracle client dll (oci.dll).  If you are
       having trouble connecting, try copying your oci.dll
       (possibly from a path such as /oracle/product/12.1.0/client/BIN)
       into the cgi-bin directory (/ms4w/Apache/cgi-bin/)
       
   .. Tip::
  
       Setting the Windows environment variables `ORACLE_HOME <http://www.orafaq.com/wiki/ORACLE_HOME>`__ 
       and `TNS_ADMIN <http://www.orafaq.com/wiki/TNS_ADMIN>`__ 
       will help MapServer/GDAL connect to your Oracle instance.   

3. For access to Oracle Spatial through the GDAL library, 
   move the ogr_OCI.dll plugin file up from 
   /ms4w/gdalplugins/ignored/oracle12/ into 
   /ms4w/gdalplugins/
   
   If this is successful, executing the following at the
   commandline (after setting /ms4w/setenv.bat) 
   "ogrinfo --formats" should list the OCI driver.    
   
4. Restart Apache to be safe.

5. For mapfile configuration see 
   https://mapserver.org/input/vector/oracle.html (note
   that the LAYER syntax differs depending if you use native
   access or through GDAL).  Here are some examples:
   
   ## Connect through OGR
   
   ::
   
     LAYER
       NAME "park-ogr"
       TYPE POLYGON
       STATUS ON
       CONNECTION "OCI:user/pass@SID"
       CONNECTIONTYPE OGR
       DATA "PARK"  
       CLASS
         NAME "Parks"
         STYLE
           COLOR 255 0 0
           OUTLINECOLOR 120 120 120
         END
       END
     END # Layer   
     
   .. Tip::
  
       In the CONNECTION parameter you can specify a different HOST or PORT with
       the syntax: `"OCI:username/password@host:port/SID"`        

   ## Connect through MapServer's OracleSpatial type   
   
   ::     

     LAYER
       NAME "park-native"
       TYPE POLYGON
       STATUS ON
       CONNECTIONTYPE oraclespatial
       CONNECTION "user/pass@SID"
       DATA "ORA_GEOMETRY FROM (SELECT ORA_GEOMETRY FROM PARK)"  
       CLASS
         NAME "Parks"
         STYLE
           COLOR 255 255 0
           OUTLINECOLOR 120 120 120
         END
       END
     END # Layer   

Microsoft SQL Server 2008
#########################

A read-only, native MapServer driver that connects to Microsoft SQL 
Server 2008's spatial capabilities is available in MS4W as of version
2.3.0.

Steps to Enable SQL Server 2008 Support in MS4W's MapServer
***********************************************************

1. The plugin exists in 
   /ms4w/msplugins/mssql/msplugin_mssql2008.dll

2. Modify your SQL Server 2008 layer in your mapfile to use the 
   CONNECTIONTYPE PLUGIN parameter and point to the appropriate 
   plugin using the PLUGIN parameter.  Use the CONNECTION
   parameter to specify the required connection parameters to access
   SQL Server, and use the DATA parameter to specify the table that
   holds the spatial information:
      
   ::
   
     LAYER
       ...
       CONNECTIONTYPE PLUGIN
       PLUGIN "C:/ms4w/msplugins/mssql/msplugin_mssql2008.dll"
       CONNECTION "server=mysqlserver2008.com;uid=dbusername;
                    pwd=dbpassword;database=Roads Database;
                      Integrated Security=false"
       DATA "the_geom from roads"
       TYPE LINE
       STATUS ON
       CLASS
          ...
       END
     END

3. Test your layer, possibly by using the shp2img commandline utility
   with the '-all_debug 5' switch
     
   The associated RFC document with the original notes on this support 
   is `RFC 38`_
   
.. _`RFC 38`: https://mapserver.org/development/rfc/ms-rfc-38.html

MapScript configuration
-----------------------

MS4W >= 1.5.0 includes pre-built support files for CSharp, Java, 
PHP, and Python mapscript.  In order to make use of these, 
however, they must be installed and configured in the 
appropriate locations on your system.

CSharp
######

1. Files are located in ``/ms4w/msplugins/mapscript/csharp``

2. See https://mapserver.org/installation/dotnet.html
   for installation notes.
   
3. Learn about the SWIG MapScript API at https://mapserver.org/mapscript/mapscript.html
   
Java
####

1. Files are located in ``/ms4w/msplugins/mapscript/java``

2. Learn about the SWIG MapScript API at https://mapserver.org/mapscript/mapscript.html

PHP
###

.. WARNING::
   
    As of the MS4W 4.0.0 release, PHPMapScript uses the `SWIG MapScript API <https://mapserver.org/mapscript/mapscript.html>`__.

1. PHPMapScript dll is located in ``/ms4w/Apache/php/ext``

2. PHP's configuration file "php.ini" is located in ``/ms4w/Apache/cgi-bin``

3. PHPMapScript is loaded by default

4. As of the MS4W 4.0.0 release, the PHPMapScript extension uses the SWIG MapScript API
   (see SWIG MapScript API docs at https://mapserver.org/mapscript/mapscript.html)

5. All of your PHP scripts must now always first include the ``mapscript.php`` file 
   containing MapServer constants:

::

  // required SWIG include (contains MapServer constants for PHP7)
  include("C:/ms4w/apps/phpmapscriptng-swig/include/mapscript.php");
  
6. Test this syntax with the provided quickmap.php file at ``/ms4w/Apache/htdocs/quickmap.php``
   (see usage instructions in the top of that file)

Python
######

Using the packaged Python Installation
**************************************

As of MS4W 4.0, Python_ is distributed as part of the base MS4W
install.  To call Python, open a Command Prompt window and 
cd to ``/ms4w/`` and then execute ``setenv.bat``.  You should 
see a message displayed such as:

::
  
  GDAL, mapserv, Python, PHP, and commandline MS4W tools path set
  
Next, in the same window, execute ``python --version``.  You should 
see a response such as:

::
  
  Python 3.7.5

.. Tip::

    As of MS4W 4.0, Python MapScript is already installed for you,
    (you can see the mapscript files inside ``/ms4w/Python/Lib/site-packages``).
    You can jump to the "Testing the Configuration" steps below.

.. _Python: http://www.python.org

Installing the Python Mapscript Support Files
*********************************************

   .. WARNING::
   
       The Python mapscript support files included in this 
       distribution are **built for Python 3.7.x**; 
       they will not work with 2.7 Python versions. It is
       strongly recommended that you use the Python instance
       that is distributed inside MS4W (at ``/ms4w/Python/``).

Quick and dirty (for use with ms4w only)
````````````````````````````````````````

1. Unpack ``/ms4w/msplugins/mapscript/python/mapscript*win32.zip`` 
   in a safe location

2. In the directory structure that results from the above 
   step, navigate to
   ``/Python-3.7.5/Lib/site-packages``

3. You should find 3 files there:
     - _mapscript.cp37-win32.pyd
     - mapscript.py
     - mapscript-<version>-py3.7.egg-info

4. Copy the 3 files into the ``/ms4w/Apache/cgi-bin`` 
   directory.

5. Place any python cgi scripts that you want to run under 
   ms4w in the ``/ms4w/Apache/cgi-bin`` directory, and add 
   a "shebang" line at the top of each script.  See the 
   section on `Configuring Apache to run Python scripts`_ 
   below for shebang-line details.

More robust (for system-wide access)
````````````````````````````````````

1. Unpack ``/ms4w/msplugins/mapscript/python/mapscript*win32.zip`` 
   in a safe location

2. In the directory structure that results from the above 
   step, navigate to ``/Python-3.7.5/Lib/site-packages``

3. You should find three files there:
     - _mapscript.cp37-win32.pyd
     - mapscript.py
     - mapscript-<version>-py3.7.egg-info

4. Copy the three files into the site-packages directory of 
   your Python 3.7.x installation 
   (eg., ``C:/ms4w/Python/Lib/site-packages``)

5. Add ``<drive_letter>:/ms4w/Apache/cgi-bin`` to your 
   system's PYTHONPATH environment variable.  

Configuring Apache to Run Python Scripts
****************************************

.. Tip::

    As of MS4W 4.0, `mod_wsgi <https://modwsgi.readthedocs.io/en/develop/>`__ 
    is installed for you.  (you can see the mod_wsgi files inside 
    ``/ms4w/Python/Lib/site-packages``).  For configuring the
    module, edit ``/ms4w/Apache/conf/httpd.conf`` and look
    for the section "mod_wsgi settings" around line# 617

You have a couple of additional options here:

via shebang lines
`````````````````

This may be the preferred approach if you have multiple 
Python installations on your machine.

Add a "shebang line" to the top of each python cgi script 
in ``/ms4w/apache/cgi-bin``.  This line must be the first 
line in the script, and it must begin with #! followed by 
the path to your systems python executable.  For example: 

::

  #!C:\ms4w\Python\python.exe -u

The ``-u`` option shown above causes the script to use 
unbuffered output, which is generally what you need in 
web-serving contexts.

via Apache directives
`````````````````````

This approach obviates the need to edit every python script 
in your cgi-bin directory; however, it may be problematic 
if you have multiple Python installations.

Add the following line to the end of 
``ms4w/Apache/conf/httpd.conf``: 

::

  ScriptInterpreterSource Registry

You may also want to add these: 

::

  SetEnv PYTHONUNBUFFERED 1
  PassEnv PYTHONPATH

The first of the above lines causes your python scripts to 
use unbuffered output (which you probably want), while the 
second passes the value of your system's PYTHONPATH 
environment variable through to Apache's environment 
(if set).


Testing the Configuration
*************************

Follow these steps to test your Python MapScript
installation:

1. Move the file ``/ms4w/msplugins/mapscript/python/test-cgi-mapscript.py``
   into the ``/ms4w/Apache/cgi-bin/`` folder.

2. Open the file in a text editor.
   
3. Edit the first line of that script to point to your
   proper Python path.
   
4. In your web browser goto 
   http://127.0.0.1/cgi-bin/test-cgi-mapscript.py

5. The script tests that the Python CGI is working, and
   that the mapscript module can be successfully imported.
   
   If successful you will see an HTML page listing several
   environment settings on your machine, as well a list of 
   the Python MapScript module attributes at the bottom
   of the page.
   
Python Troubleshooting:

- If you get an Internal Server Error check the Apache logs 
  for info.
  
- Make sure your script points to a valid Python installation
  path.
  
- Make sure you are using a recent Python version
  (containing the cgitb module).
  
Python MapScript Documentation
******************************

Python MapScript is handled through the SWIG API for MapServer: 
https://mapserver.org/mapscript/mapscript.html

GDAL Plugins
------------

Oracle
######

See the previous section to configure GDAL for Oracle connections: 
`Steps to Enable Oracle 10g or 11g or 12c Support in MS4W`_

ECW
###

As of MS4W 3.2.0, an old ECW version 3.3 SDK is used to read and display
ECW files in MS4W.  If you require more recent functionality from the newer
v5+ SDK, please contact `Gateway Geomatics`_ for a custom build quote. 

Steps to Enable ECW Support in MS4W
***********************************

1. For access to ECW files through the GDAL library, 
   move the *gdal_ECW_JP2ECW.dll* plugin file up from 
   /ms4w/gdalplugins/ecw/ into 
   /ms4w/gdalplugins/
   
   If this is successful, executing the following at the
   commandline (after setting /ms4w/setenv.bat) 
   "gdalinfo --formats" should list the "ECW" and "JP2ECW" drivers. 
   
   ::
   
       ECW -raster- (rw): ERDAS Compressed Wavelets (SDK 3.x)
       JP2ECW -raster,vector- (rw+v): ERDAS JPEG2000 (SDK 3.x)
       
2. For display in MapServer, after moving the plugin, follow the regular 
   `Raster Data <https://mapserver.org/input/raster.html>`_ document.  
   Here is an example mapfile configuration:
   
   ::
   
     LAYER
       NAME "ecw"
       TYPE RASTER
       STATUS ON
       DATA "00203065F09.ecw"
       CLASS
         NAME "ECW test"
       END
     END
     
GDAL Bindings
-------------

MS4W contains GDAL bindings for CSharp, Java, and Python, and are located 
at ``/ms4w/gdalbindings``

Using the Python GDAL Module
############################

.. Note::
  
    Since the MS4W 4.0 release, Python is included in the base MS4W (after you
    run setenv.bat you can call Python).  If you have
    your own Python instance instead: Python 3.7 is required for the Python GDAL module in 
    MS4W, and you must have C:/python-3.7.x in your PATH to use 
    the utilities.  

The Python GDAL module and its utilities are installed in
``/ms4w/gdalbindings/python/gdal/``.  To run the utilities:

1. Open a Command Prompt window

2. cd ms4w

3. setenv.bat

4. cd gdalbindings/python/gdal

5. excute the python utility, such as:

  ::
  
    python gdal_merge.py
    
gdal_merge.py notes:

- -n (nodata_value) switch requires the `NumPy module <https://pypi.org/project/numpy/>`__ 
  (the embedded Python instance in MS4W already includes NumPy)
    
- raster_copy_with_nodata() also requires the NumPy module 
  (the embedded Python instance in MS4W already includes NumPy)
 
FastCGI
-------

In order to use FastCGI you must do the following:

1. Open /ms4w/Apache/conf/httpd.conf in a text editor

2. Uncomment line#178, such as:

   ::
   
     LoadModule fcgid_module modules/mod_fcgid.so

3. At the bottom of the file you will see a commented 
   "<IfModule fcgid_module>" section.  If you want to use
   FastCGI directives (listed on the `mod_fcgid`_
   page) you can uncomment the section and add your
   directives, such as:
    
   ::
   
     <IfModule fcgid_module>
        FcgidMinProcessesPerClass 0
        FcgidIdleScanInterval 1
        FcgidProcessLifeTime 10 
     </IfModule>
    
.. _`mod_fcgid`: http://httpd.apache.org/mod_fcgid/mod/mod_fcgid.html
   
     
4. If you are connecting to an Oracle database using FastCGI, you
   must also add your Oracle Bin directory (where the 'oci.dll' 
   file exists) to the PATH variable above, such as:
   
   ::
   
     <IfModule fcgid_module>
         ...
         FcgidInitialEnv PATH "c:/oracle/product/10.2.0/client/BIN"
         ...
     </IfModule> 

5. Save the file and restart apache (execute /ms4w/apache-restart.bat)

6. Change your CGI application to point to "/fcgi-bin/mapserv.exe"
   instead of the usual "/cgi-bin/mapserv.exe"
    
7. Add the following parameter to your layer for which you
   want this FastCGI connection:
   
   ::
   
     PROCESSING "CLOSE_CONNECTION=DEFER"
     
8.  Try the application.  If successful you should see the 
    "mapserv.exe" process in the Windows Task Manager remain open 
    while the user interacts with your application.
    
Notes: 

* in testing this was successful with PostgreSQL 9.0.4 / PostGIS 1.5.2,
  and with Oracle 10.2.0.1.0.

* general MapServer and FastCGI notes can be found in the 
  `FastCGI Howto`_.

.. _`FastCGI Howto`: https://mapserver.org/optimization/fastcgi.html 

Apache Modules
--------------

MapCache Apache Module
######################

The MapCache Apache module and the mapcache commandline utilities (as of 
MS4W 3.1.0) are included. In order to use the MapCache Apache 
module you must do the following:

.. Note::

    For information about MS4W's included HTTPS certificate bundle, 
    and specific tips for MapCache, see the later section `Certificates for HTTPS`_ 
    of this document.

1. Open /ms4w/Apache/conf/httpd.conf in a text editor

2. Uncomment line#184, and change to your correct path, such as:

   ::
   
     LoadModule mapcache_module "C:/ms4w/Apache/cgi-bin/mod_mapcache.dll"

3. Around line#412 of your httpd.conf file you will see a 
   "<IfModule mapcache_module>" section.  Modify the path
   to the included MapCache configuration (XML) file, such as:
    
   ::
   
     <IfModule mapcache_module>
        <Directory "/ms4w/apps/mapcache/">
           AllowOverride None
           Options None
           Require all granted
        </Directory>
        MapCacheAlias /mapcache "C:/ms4w/apps/mapcache/mapcache.xml"
     </IfModule>  
     
4. Modify the mapcache.xml file.  Please see the associated `MapCache docs`_
   for assistance.
   
.. _`MapCache docs`: https://mapserver.org/mapcache/config.html   

5. Save your httpd.conf file and restart apache (execute /ms4w/apache-restart.bat)

6. If the module was successfully loaded your /ms4w/Apache/logs/error_log.txt
   file should contain a message similar to:
   
   ::
   
     [notice] Apache/2.4.41 (Win32) mod-mapcache/1.9dev configured 
     -- resuming normal operations
     
7. Test your MapCache configuration by following steps in the associated
   `MapCache testing docs`_
   
   .. _`MapCache testing docs`: https://mapserver.org/mapcache/install.html#test-your-mapcache-module  

8. The `MapCache seeding utility`_ is also included.  To run the 
   mapcache_seed.exe file be sure to first execute the /ms4w/setenv.bat 
   file in your command window.

.. _`MapCache seeding utility`: https://mapserver.org/mapcache/seed.html  
  
9. The `MapCache detail utility`_ is also included.  To run the 
   mapcache_detail.exe file be sure to first execute the /ms4w/setenv.bat 
   file in your command window.

.. _`MapCache detail utility`: https://mapserver.org/mapcache/coverage.html 

Notes: 

* this module was tested with the cache types: disk, sqlite, tiff, and berkeleyDB.  
  You should follow the `MapCache Cache Types docs`_ for assistance, 
  or contact `Gateway Geomatics`_ for assistance/custom builds/configurations.
  
   .. _`MapCache Cache Types docs`: https://mapserver.org/mapcache/caches.html  
   
* the module was tested on Windows 10; if you are using an older
  version of Windows and require this module you should consider upgrading, 
  or contact `Gateway Geomatics`_ for assistance/custom builds/configurations.
  .

* as this module is still in development, feedback is more than encouraged,
  it is required.  Please send your MapCache questions to the 
  `MapServer-users mailing list`_.  You are also encouraged to contact
  Gateway Geomatics `directly`_ for custom builds and to help fund 
  the development and maintenance of MS4W.

.. _`MapServer-users mailing list`: https://mapserver.org/community/lists.html#mapserver-users 
.. _`directly`: mailto:info@gatewaygeomatics.com 

mod_wsgi Apache Module
######################

The `mod_wsgi <https://modwsgi.readthedocs.io/>`__ Apache module is included, 
as of the MS4W 4.0.0 release.  In order to use the mod_wsgi Apache 
module you must do the following:

1. Open /ms4w/Apache/conf/httpd.conf in a text editor

2. Around line#617, make sure the paths are correct, such as:

   ::
   
     # mod_wsgi settings
     LoadFile "c:/ms4w/python/python37.dll"
     LoadModule wsgi_module "c:/ms4w/python/lib/site-packages/mod_wsgi/server/mod_wsgi.cp37-win32.pyd"
     WSGIPythonHome "c:/ms4w/python"   

3. Save your httpd.conf file and restart apache (execute /ms4w/apache-restart.bat)

4. If the module was successfully loaded your /ms4w/Apache/logs/error_log.txt
   file should contain a message similar to:
   
   ::
   
     [notice] Apache/2.4.41 (Win32) mod_wsgi/4.6.8 Python/3.7 configured 
     -- resuming normal operations
     
5. To test that Apache has loaded the module, at your Command prompt, cd into the
   */ms4w/Apache/bin/* directory.  Then execute the following:
   
   ::
   
     httpd -t -D DUMP_MODULES
     
   You should see a list of loaded modules, and mod_wsgi should
   be listed near the end, such as:
   
   ::
   
      setenvif_module (shared)
      version_module (shared)
      fcgid_module (shared)
      mapcache_module (shared)
      wsgi_module (shared) 

6. You can use your file explorer and see the mod_wsgi files inside 
   the folder: ``/ms4w/Python/Lib/site-packages``

H264 Streaming Module for Apache
################################

The `H264 Streaming Module <http://h264.code-shop.com/trac/>`__ is included for Apache (as of MS4W 3.1.0).
One of the features of this module is enabling your viewers to immediately 
jump to any part of the video regardless of the length of the video or 
whether it has all been downloaded yet. In order to use the H264 Streaming Module 
you must do the following:

1. Open /ms4w/Apache/conf/httpd.conf in a text editor

2. Uncomment line#183, such as:

   ::
   
     LoadModule h264_streaming_module modules/mod_h264_streaming.so

3. Around line#608 of your httpd.conf file you will see a 
   "<IfModule h264_streaming_module>" section.  You can leave this
   section as-is (no changes are needed):
    
   ::
   
     <IfModule h264_streaming_module>
       AddHandler h264-streaming.extensions .mp4
     </IfModule>    

4. Save your httpd.conf file and restart Apache (execute /ms4w/apache-restart.bat)

5. To test that Apache has loaded the module, at your Command prompt, cd into the
   */ms4w/Apache/bin/* directory.  Then execute the following:
   
   ::
   
     httpd -t -D DUMP_MODULES
     
   You should see a list of loaded modules, and the H264 Streaming Module should
   be listed near the end, such as:
   
   ::
   
      log_config_module (shared)
      mime_module (shared)
      negotiation_module (shared)
      setenvif_module (shared)
      h264_streaming_module (shared)
     
6. To test the module on an actual video file:

   - Download this mp4 file locally (right-click and Save Link As): https://gatewaygeomatics.com/dl/mapserver-6-0-visualization.mp4
   
   - Copy the file into the folder */ms4w/Apache/htdocs/*
   
   - Open a Command prompt window, and cd into */ms4w/* and execute *setenv.bat*
   
   - Execute the following command in that same window:
   
     ::
     
       wget -S -O mapserver-6-0-visualization.mp4 "http://127.0.0.1/mapserver-6-0-visualization.mp4?start=0&end=5"
       
     You should see a response as follows (notice the mention of the "X-Mod-H264-Streaming"
     and also that the size of the video is very small (click on the saved file now in /ms4w/mapserver-6-0-visualization.mp4 
     and view it, only the first 5 seconds of the video should be loaded):
     
       ::
       
	 1 HTTP/1.1 200 OK
	 2 Date: Mon, 10 Jul 2017 15:10:31 GMT
	 3 Server: Apache/2.4.27 (Win32) mod_fcgid/2.3.9
	 4 X-Mod-H264-Streaming: version=2.2.7
	 5 Content-Length: 574375
	 6 Last-Modified: Thu, 03 Dec 2015 02:15:30 GMT
	 7 ETag: "451ed18-525f4f7037480;574375"
	 8 Accept-Ranges: bytes
	 9 Keep-Alive: timeout=5, max=100
	10 Connection: Keep-Alive
	11 Content-Type: video/mp4
	 
        100%[====================================>] 574,375      547.77M/s    ETA 00:00
         
   - Now test the module in your Web browser, by going to: http://127.0.0.1/mapserver-6-0-visualization.mp4?start=0&end=5

     - the streamed video should be only 5 seconds long (if the whole video is shown, then there is 
       a problem with the configuration of the module)
     - experiment with the "start" and "end" parameters of the URL
   
7. Read more about the module's parameters: http://h264.code-shop.com/trac/wiki/Mod-H264-Streaming-Testing-Version2

Apache mod_rewrite & mod_alias Usage
####################################

As described earlier, MS4W is designed so you can easily include your
application's Apache settings in the /ms4w/httpd.d/ folder (see the
README_HTTPD.txt inside that folder for more information).  The following
examples will use the existing MS4W "MapServer CGI Viewer" application; the
CGI viewer's Apache settings are stored in the file "httpd_cgi_viewer.conf"
inside the /ms4w/httpd.d/ folder.  The contents of the file is:

  ::
  
    Alias /cgi/ "/ms4w/apps/cgi-viewer/htdocs/"
    
    <Directory "/ms4w/apps/cgi-viewer/htdocs/">
      AllowOverride None
      Options Indexes FollowSymLinks Multiviews 
      Order allow,deny
      Allow from all    
    </Directory>
    
.. Note::

    If you would prefer to make your application changes directly in the /ms4w/Apache/conf/httpd.conf 
    file you can, or also include them in an .htaccess file inside your application's folder.    

Let's say one of the filenames has changed (from "viewer-index.html" to "ttt.html"), 
but we want to make sure the old url works.  MS4W loads the mod_rewrite module by 
default (more about mod_rewrite: https://httpd.apache.org/docs/2.4/rewrite/), 
so we can add a few lines into our "httpd_cgi_viewer.conf" to call this
rewrite, such as:

  ::
  
    Alias /cgi/ "/ms4w/apps/cgi-viewer/htdocs/"
    
    <Directory "/ms4w/apps/cgi-viewer/htdocs/">
      AllowOverride None
      Options Indexes FollowSymLinks Multiviews 
      Order allow,deny
      Allow from all
      
      RewriteEngine On
      RewriteBase "/cgi/"
      RewriteRule "^viewer-index.html$"  "ttt.html"  
    
    </Directory>
    
We can alternatively use the Redirect directive through the mod_alias module, which is
loaded by MS4W by default (read more about mod_alias at 
https://httpd.apache.org/docs/2.4/mod/mod_alias.html) such as:

  ::
  
    Alias /cgi/ "/ms4w/apps/cgi-viewer/htdocs/"
    
    <Directory "/ms4w/apps/cgi-viewer/htdocs/">
      AllowOverride None
      Options Indexes FollowSymLinks Multiviews 
      Order allow,deny
      Allow from all    
    </Directory>
    
    Redirect 301 "/cgi/viewer-index.html" "/cgi/ttt.html"
    
.. Tip::
  
    Be sure to always restart the Apache service after any changes made to conf files 
    (execute apache-restart.bat at the commandline, after executing setenv.bat in the 
    same window)

TinyOWS
-------

`TinyOWS <https://mapserver.org/tinyows/index.html#tinyows>`__ and demo data are included 
(as of MS4W 3.1.0), giving you full WFS-Transaction support (making data changes in an MS4W map
that is then saved to the underlying database).  In order to use TinyOWS you must do the following:

1. Make sure that you have `PostgreSQL <http://www.postgresql.org/>`__ and `PostGIS <http://postgis.net/>`__ 
   installed locally, or have connection details for accessing it remotely.  This has been tested 
   with PostgreSQL 10.5 and PostGIS 2.4.4
   
2. First we must create a database and load some sample data:

   - Open */ms4w/apps/tinyows/demo/install-demo-data.bat* in a text editor

   - If necessary, modify the *PG-PORT*, *PG-SUPERUSER-NAME*, and *PG-SUPERUSER-PASSWORD* for your installation
     (lines ~17-19). Save your changes.
   
   - Open a Command prompt window, and cd into */ms4w/* and execute *setenv.bat*
   
   - cd into */ms4w/apps/tinyows/demo/* and execute the following in that same window:
   
     ::
     
       install-demo-data.bat
       
   - Verify that a new database was created ("tinyows"), and that there is a spatial table ("frida").
   
.. Tip::

    You can use `QGIS <http://qgis.org>`__ to view your new "frida" PostGIS layer (through `Layer/Add Layer
    /Add PostGIS Layers`)
       
3. Next we must configure TinyOWS:

   - Open */ms4w/apps/tinyows/config.xml* in a text editor

   - If necessary, modify the *online_resource* and *pg* connection parameters, for your installation.
     Refer to the TinyOWS `documentation <https://mapserver.org/tinyows/configfile.html>`__ for parameter
     descriptions.  Save your changes.
     
   - to test this configuration, in the same Command prompt window, execute the following (change the
     drive path if necessary):
   
     ::
     
       set TINYOWS_CONFIG_FILE=C:/ms4w/apps/tinyows/config.xml  
       
   - once that is set, execute the following in the same Command prompt window to see details 
     about your TinyOWS configuration:
   
     ::
     
       tinyows.exe --check
       
     the response should be something like:
     
     ::
     
       TinyOWS version:   1.1.0
       FCGI support:      Yes
       Config File Path:  C:/ms4w/apps/tinyows/config.xml (TinyOWS XML)
       PostGIS Version:   2.4.4
       PostGIS dsn:       host=localhost user=postgres password=postgres dbname=tinyows port=5432
       Output Encoding:   UTF-8
       Database Encoding: UTF8
       Schema dir:        /ms4w/apps/tinyows/schema/
       Display bbox:      Yes
       Estimated extent:  No
       Check schema:      Yes
       Check valid geoms: Yes
       Available layers:
 
         public.frida (31467) -> tows:frida [RW]
         
   - Note that Apache sets this same environment variable *TINYOWS_CONFIG_FILE* in the file 
     */ms4w/httpd.d/httpd_tinyows.conf*
   
4. Next we should configure the demo HTML application:

   - Open */ms4w/apps/tinyows/demo/tinyows.js* in a text editor
   
   - Verify that urls (such as http://127.0.0.1) used there are correct: see lines 65 & 69

5. Finally we are ready to test a WFS-T transaction to your database:

   - in a Web browser, goto http://127.0.0.1/tinyows/demo/tinyows.html (or modify that address if need be)
   
   - click on the "Draw Feature" icon on the top-right of the map, and click anywhere on the map
     to generate a polygon (to close the polygon double-click).
     
   - now click on the "Save Changes" icon, you should see a message in the right panel of that page as:
   
     ::
     
       Transaction successfully completed
       
   - Changes to the "frida" layer should be saved to the database.

pycsw
-----

`pycsw <http://pycsw.org/>`__ catalogue server is included in the base MS4W installer, 
as of the MS4W 4.0 release, giving you a lightweight metadata publisher, that runs through MS4W's
embedded Python instance.  Through pycsw you can not only serve your metadata catalogue, but 
also harvest other remote OGC services (WMS, WFS, WCS, WPS, etc.), as well as remotely
edit your metadata repository (through CSW-T transactions).  Here are some important 
notes on this pycsw instance:

1. As noted in the `mod_wsgi Apache Module`_ section of this document, pycsw runs through
   the mod_wsgi Apache module.  Please see that section for mod_wsgi configure instructions.
   
2. A sample CSW service is pre-configured for you, and the GetCapabilities request is:
   http://127.0.0.1/pycsw?service=CSW&version=3.0.0&request=GetCapabilities
   
.. Tip::

    You can use the `QGIS <http://qgis.org>`__ "MetaSearch" plugin to access your local MS4W 
    catalogue (through the menu `Web/MetaSearch/MetaSearch`).  Create a new "Service" entry there
    with the URL: http://127.0.0.1/pycsw
       
3. You can configure this sample service, in the file "default.cfg", and you can find the path
   to it on line#624 of the file: /ms4w/Apache/conf/httpd.conf (look for the "PYCSW_CONFIG"
   setting there).  For definitions of the parameters see pycsw's `configuration guide <http://docs.pycsw.org/en/latest/configuration.html>`__.
   
4. You must restart the Apache service after each change to that .cfg file. 
   (execute /ms4w/apache-restart.bat) 

5. To use the "pycsw-admin.py" utility:

     - open a Command window
     - cd ms4w
     - setenv.bat
     - cd apps/pycsw-xxx
     - python bin/pycsw-admin.py -h
     
   For usage parameters of the admin utility see pycsw's `administration guide <http://docs.pycsw.org/en/latest/administration.html>`__.

ZOO-Project
-----------

`ZOO-Project <http://zoo-project.org/>`__ Web Processing Server is included as an add-on package, 
as of the MS4W 4.0 release, giving you a full WPS server, that runs through MS4W's
Apache instance.  Here are some important notes on this ZOO-Project WPS instance and its many 
compiled services:

1. Please see your local MS4W homepage (http://127.0.0.1) for a working list of GetCapabilities,
   DescribeProcess, and Execute requests for the various WPS services.

 .. Important::

      Since 2020-01-30 a local demo is included, leveraging ZOO-Project's vector-based spatial
      analysis, through OGR services.  You can find the demo linked on your local MS4W homepage
      (as "local OGR Services demo"). 
   
2. The following support has been compiled into the ZOO-Project kernel, as part of MS4W:

     - MapServer support (official `docs <http://zoo-project.org/docs/kernel/mapserver.html>`__)
     - PHP support (official `docs <http://zoo-project.org/docs/services/howtos.html#php>`__)
     - Python support (official `docs <http://zoo-project.org/docs/services/howtos.html#python>`__)
     - C# Mono support (official `docs <http://zoo-project.org/docs/services/howtos.html#c>`__) *see note below to enable*
     - Java support (official `docs <http://zoo-project.org/docs/services/howtos.html#java>`__) *see note below to enable*
     - GDAL and OGR support (official `docs <http://zoo-project.org/docs/services/zoo-services.html?#based-on-gdal>`__)
     - Status service support (official `docs <http://zoo-project.org/docs/services/status.html>`__) 
   
.. Tip::

    If you require a specific WPS service support, or a specific version support, that is not part of the base MS4W, 
    please contact `Gateway Geomatics`_.  
       
3. The ZOO kernel configuration file *main.cfg* can be found in /ms4w/Apache/cgi-bin/ .  For definitions of 
   the parameters see the `configuration guide <http://zoo-project.org/docs/kernel/configuration.html>`__.
   
4. Individual ZOO service configuration files (*.zcfg*) can also be found in /ms4w/Apache/cgi-bin/ .  For definitions of 
   the parameters see the services `configuration guide <http://zoo-project.org/docs/services/zcfg-reference.html>`__.
   
5. To enable **C# Mono support** you are required to do the following:

     - move the *zoo_loader.cgi* plugin file up from 
       /ms4w/Apache/cgi-bin/zooplugins/mono/ into /ms4w/Apache/cgi-bin/
     - add the following to your *main.cfg* file, pointing to your local installation of `Mono <https://www.mono-project.com/download/>`__:
     
       ::
       
          [mono]
	  lib=C:\Program Files (x86)\Mono\lib
          etc=C:\Program Files (x86)\Mono\etc
       
6. To enable **Java support** you are required to do the following:

     - move the *zoo_loader.cgi* plugin file up from 
       /ms4w/Apache/cgi-bin/zooplugins/java/ into /ms4w/Apache/cgi-bin/       
     - add the following to your *main.cfg* file, pointing to your local installation of `JDK <https://www.oracle.com/technetwork/java/javase/downloads/index.html>`__:
     
       ::
       
          [java]
          java.library.path=C:\Program Files (x86)\Java\jdk1.8.0_77\jre\bin\client HelloJava.class
          
     - You may have to move your local *jvm.dll* file into /ms4w/Apache/cgi-bin/ as well

Certificates for HTTPS
----------------------

As of MapServer 5.4.1, MapServer can connect through HTTPS connections 
to WMS/WFS servers.  MS4W 3.0 (and newer) includes the necessary configuration 
as follows:

1. Certificate authority bundle is included in 
   /ms4w/Apache/conf/ca-bundle/cacert.pem
   
   Source: http://curl.haxx.se/ca/cacert.pem
   
2. Apache's httpd.conf points to the ca-bundle:

   ::
   
     SetEnv CURL_CA_BUNDLE "/ms4w/Apache/conf/ca-bundle/cacert.pem"
     
.. Tip::

    MS4W's MapCache module will check for this CURL_CA_BUNDLE value set in
    Apache's httpd.conf, and in the instances that it cannot find the value
    (which occurs on some x64 systems) it will check for the following hardcoded paths,
    in this order:
    
    ::
    
      "D:/ms4w/Apache/conf/ca-bundle/cacert.pem"
      
        or
      
      "C:/ms4w/Apache/conf/ca-bundle/cacert.pem"
     
3. MS4W's setenv.bat points to the ca-bundle:

   ::
   
     set CURL_CA_BUNDLE=\ms4w\Apache\conf\ca-bundle\cacert.pem
     set SSL_CERT_FILE=\ms4w\Apache\conf\ca-bundle\cacert.pem
     set OPENSSL_CONF=\ms4w\tools\openssl\openssl.cnf     
     
4. MS4W's php.ini points to the ca-bundle:

   ::
   
     curl.cainfo="/ms4w/Apache/conf/ca-bundle/cacert.pem"
     openssl.cafile="/ms4w/Apache/conf/ca-bundle/cacert.pem"     
     
5. For more information on SSL certificates, 
   see: http://curl.haxx.se/docs/sslcerts.html
   
6. To setup MapServer as a client to access a remote WMS/WFS server
   through HTTPS see: https://github.com/mapserver/mapserver/issues/3070
   
7. To enable HTTPS for your server host (to serve its own certificate, for your
   domain such as https://mydomain.com), you can use "win-acme" 
   at https://github.com/PKISharp/win-acme Here are some important tips specifically 
   related to win-acme:
   
   - follow the steps for Apache at https://github.com/PKISharp/win-acme/wiki/Apache-2.4-Basic-usage
   
   - be sure to set the SavePrivateKeyPem option in win-acme's settings.config to True
   
   - edit your httpd.conf and around line#176 be sure to uncomment the line:
   
     ::
     
       LoadModule ssl_module modules/mod_ssl.so
       
   - change the ServerName parameter in httpd.conf around line#226 to your domain such as:
   
     ::
     
       ServerName mydomain.com
       
   - add the following to the bottom of your httpd.conf (edit the paths to your
     generated certificate files):
     
     ::
     
       <IfModule mod_ssl.c>
           Listen 443
       </IfModule>
       
       <VirtualHost *:443>
           DocumentRoot "/ms4w/Apache/htdocs"
           ServerName mydomain.com
           ErrorLog "logs/https_error_log.txt"
           CustomLog "logs/https_error_access.txt" common          
           SSLEngine on
           SSLCertificateFile "C:/ProgramData/win-acme/acme-v02.api.letsencrypt.org/Certificates/ca-umz9yz4SYUGQm-esziIA9A-chain.pem"
           SSLCertificateKeyFile "C:/ProgramData/win-acme/acme-v02.api.letsencrypt.org/Certificates/umz9yz4SYUGQm-esziIA9A-key.pem"           
       </VirtualHost>
       
   - restart Apache (execute /ms4w/apache-restart.bat)
   
   - use a tool to verify your certificate such as https://www.ssllabs.com/ssltest/   

Troubleshooting 
---------------

**Warning: dl(): Unable to load dynamic library 
'/ms4w/Apache/php/extensions/php_mapscript.dll'**

1. Verify that the dll in question exists in the 
   specified location (/ms4w/Apache/php/extensions/).  If 
   this dll is not in that location, you might have to 
   modify the application to point to a different version of 
   the dll (e.g. you might have *php_mapscript.dll* in 
   the extensions directory, and your application might be 
   configured for *php_mapscript_48.dll* which is not in the 
   extensions directory).
   
2. This php_mapscript dll requires several other dlls, and 
   the problem may be that one is missing on your system.  
   In order to hopefully get more information on what dll 
   is missing, go to a command prompt, and do the following:
   
   ::

     cd ms4w\Apache\cgi-bin
   
     php C:/ms4w/Apache/htdocs/phpinfo_mapscript.php  
      
   A windows error window should open with a message like:
   
   ::
   
      The dynamic link library ***** could not be found in 
      the specified path...
      
   Locate this missing dll and copy it either to 
   /ms4w/Apache/cgi-bin/ or your system32 folder.
   
3. If you are still unsure what dll is causing this *unable 
   to load dynamic library* error, a useful utility to find 
   what associated dlls are missing on your system is 
   `Dependency Walker`_.  Download the utility, execute the 
   exe, and open your php_mapscript dll.
   
.. _`Dependency Walker`: http://www.dependencywalker.com/  

**The Program can't start because MSVCRxxx.dll is missing 
from your computer**

Please follow the instructions included locally inside the 
document `/ms4w/REQUIREMENTS.txt` to install the 
C++ Redistributable.

**Clicking on apache-install.bat flashes a DOS window and 
does not install the service**

To see the exact error message, open a Command window, and 
execute the 'apache-install.bat' file from a DOS prompt.

::

  cd ms4w
  
  apache-install.bat
  
**Only one usage of each socket address (protocol/network 
address/port) is normally permitted.  : make_sock: could not 
bind to address 0.0.0.0:80 no listening sockets available, 
shutting down**

Apache with MS4W is configured to use port 80.  Your system 
might be already using this port (IIS could cause this for 
example).  If you want to change the port that Apache uses 
modify the following file:

::

  /ms4w/Apache/conf/httpd.conf
  
  line 120: Listen 80
  
`TCPView`_ is an example of shareware that lets you see 
how the ports on your machine are being used.

.. _`TCPView`: https://technet.microsoft.com/en-us/sysinternals/bb897437.aspx
  
**The procedure entry point xxxx could not be located in the 
dynamic link library xxx.dll**
   
Make sure that MapServer (or the utility that you are trying 
to use) is actually using the 'xxx.dll' file that is part 
of the MS4W package.  You could be experiencing 'dll hell' 
(http://en.wikipedia.org/wiki/DLL_hell) where MS4W is 
actually finding an older dll on your system.  Try renaming 
the other dll(s) of the same name, keeping the one in MS4W 
as is, and retrying your application/command.

**Other Problems...**

1. Search the `mailing list archives`_ to see if someone has 
   encountered/solved your same issue.

.. _`mailing list archives`: https://lists.ms4w.com/pipermail/ms4w-users/ 

2. If your issue has not been brought up on the mailing list 
   and dealt with, submit a question to the 
   `MS4W mailing list`_.  Include the steps to reproduce 
   your problem, and state your exact error message.  Also 
   specify which version of MS4W you are using.

.. _`MS4W mailing list`: https://ms4w.com/forum/


Modifying MS4W for an Installation not at the Drive Root
--------------------------------------------------------

Do the following steps in a text editor:

1. Open /ms4w/Apache/conf/httpd.conf and search for "/ms4w/" and 
   replace with your new path from your drive root (such as 
   "/Temp/ms4w/")

2. Open /ms4w/Apache/cgi-bin/php.ini and search for "/ms4w/" 
   and replace with your new path from your drive root (such as 
   "/Temp/ms4w/")

3. Open all files in /ms4w/httpd.d and search for "/ms4w/" 
   and replace with your new path from your drive root (such as 
   "/Temp/ms4w/")

4. Open /ms4w/setenv.bat and search for "/ms4w/" and replace
   with your new path from your drive root (such as "/Temp/ms4w/")

5. Configure your add-on packages, typically installed at 
   /ms4w/apps/

Recommendation: avoid installing MS4W in a path that contains spaces


Installing the MS4W MapServer Binaries in Other Environments
------------------------------------------------------------

The following instructions will help non-MS4W users who want
to only use the MapServer binaries included in MS4W:

1. Download and extract the MS4W base package locally from 
   `ms4w.com <https://ms4w.com/>`__

2. Do not install the Apache service (apache-install.bat)

3. Copy the .dll files from the `/ms4w/apache/cgi-bin/` directory 
   into your desired cgi-bin directory:
   	   
4. For PHP/Mapscript, goto `/ms4w/Apache/php/ext/` and copy
   the `php_mapscript.dll` file into your own PHP
   extensions directory.  CSharp, Java, and Python mapscript
   files can be found in `/ms4w/msplugins/mapscript/`
   
5. For the commandline utilities that come with MS4W (mapserv,
   gdal, etc.) copy all of the `.exe` files from `/ms4w/tools/`
   to a desired location, but be aware that these utilities 
   use dlls that were installed in the cgi-bin directory.  
   Therefore you must add your cgi-bin directory into your
   Windows PATH environment variable before running the
   utilities.

6. Microsoft IIS users should refer to the `IIS Howto`_ for MapServer.

.. _`IIS Howto`: https://mapserver.org/installation/iis.html

Using Custom EPSG Projections
-----------------------------

Custom EPSG projections can be added to the bottom of your epsg file 
at `/ms4w/proj/nad/epsg/`.

As of MS4W 3.0-beta11, previously included custom projections for 
Canada have been removed.  Here is some of the history:

- Gateway Geomatics officially applied to have the custom Canadian 
  projection EPSG:42304 (common in Ontario and in the Atlas of 
  Canada) included in the EPSG geodetic registry in 2009
- the projection was accepted as EPSG:3978 in the EPSG geodetic 
  registry on 2009-06-02
- this new EPSG code is included in PROJ 4.7.0 release (2009-09)

For reference, here are the old custom Canadian EPSG codes:

::

  ##
  ## Custom projection codes for Canada
  ##
  ## WGS84 / LCC Canada
  <42101> +proj=lcc +ellps=WGS84 +lat_0=0 +lon_0=-95 +lat_1=49 
          +lat_2=77 +x_0=0 +y_0=-8000000.0 +datum=WGS84 
          +units=m no_defs <>
  ## NAD83 / BC Albers
  <42102> +proj=aea +ellps=GRS80 +lat_0=45 +lon_0=-126.0 
          +lat_1=50.0 
          +lat_2=58.5 +x_0=1000000.0 +y_0=0 +datum=NAD83 
          +units=m no_defs <>
  #
  ## NAD83 LCC for Canada
  <42304> +proj=lcc +ellps=GRS80 +lat_0=49 +lon_0=-95 
          +lat_1=49 +lat_2=77 
          +datum=NAD83 +units=m no_defs <>
  ##

Password Protection Configuration for Applications
==================================================

The following section explains how to add password 
authentication to your MS4W application.  However there are 
many other possible settings in Apache for this, so please 
consult the Apache HTTP Server documentation.

Here are the minimal steps for password protection:

1. Modify your application's httpd_xxx.conf file, so that 
   "AllowOverride None" is replaced with "AllowOverride 
   AuthConfig", such as:
   
   ::
   
     Alias /gmap/ "/ms4w/apps/gmap/htdocs/"
     
     <Directory "/ms4w/apps/gmap/htdocs/">
       AllowOverride AuthConfig
       Options Indexes FollowSymLinks Multiviews 
       Order allow,deny
       Allow from all       
     </Directory>
     
2. Create a password file.  

   - open a DOS command window, and go to Apache's bin 
     directory
   
   - enter the following (replace "jeff" with the username 
     you want to create, press ENTER and you will be 
     prompted for a password to create):
   
     ::
   
       C:/ms4w/Apache/bin> htpasswd -c htpasswd.txt jeff
      
3. Create the htaccess file.  

   - create a file in your application directory 
     (/ms4w/apps/gmap/htdocs/ in this example) named 
     '.htaccess'
     
   - the file should contain (you can modify it however you 
     wish though):
   
     ::
     
       AuthType Basic
       AuthUserFile C:/ms4w/Apache/bin/htpasswd.txt
       AuthName "Password Required"
       
       require valid-user
 
4. Restart Apache

   - run /ms4w/apache-restart.bat
   
5. Access your application in a web browser.

*Troubleshooting:*

- some Windows versions may have difficulty with the 
  '.htaccess' filename, so you might try naming it something 
  else, but you would have to modify Apache's httpd.conf 
  file (/ms4w/Apache/conf/httpd.conf) and add your filename, 
  such as:
  
  ::
  
    AccessFileName .htaccess yourfilename
    
  'htaccess.acl' is recommended, such as:
  
  ::
  
    AccessFileName .htaccess htaccess.acl 
    
- for more information please see the `Apache documentation <https://httpd.apache.org/docs/2.4/howto/auth.html>`__


MS4W Applications
=================

The following applications come with a pre-configured 
install package for MS4W. Go to 
https://ms4w.com/release/apps/ 
to find the desired package, and extract the packages to the 
MS4W root (e.g. if you installed in C:/ then extract at C:/,
and if you installed the base in D:/ then
extract the packages to D:/).
 
   1) GeoMoose
   
   2) Mapbender
      
   3) MapServer CGI Viewer
   
   4) MapServer Itasca Demo Application   
   
   5) MapServer OGC Workshop
   
   6) Matomo Analytics
   
   7) OpenLayers
   
   8) pycsw
   
   9) ZOO-Project WPS Server
   
   .. WARNING::
   
       Some applications may have a problem if you install MS4W
       in a path containing spaces.  It is therefore not
       recommended to install MS4W in a path that contains
       spaces.
   
   
Additional Support
==================

General questions and comments should be sent to the MS4W 
mailing list, which you can join at: 
https://ms4w.com/forum/

Requests for changes and enhancements to MS4W should be 
filed in the MS4W `tracker`_.

.. _`tracker`: https://ms4w.com/trac/

Custom support is also available from `Gateway Geomatics`_.   

About this Document
===================

Copyright/Licensing Information
-------------------------------

In general MS4W is licensed under an MIT/X style license with the
following terms:

Copyright (c) 2003-2019 Gateway Geomatics

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files
(the "Software"),to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Component Licensing
-------------------

MS4W contains several component packages that are provided under
their own licensing terms.

MapServer
#########

Copyright (c) 2008-2019 Open Source Geospatial Foundation.
Copyright (c) 1996-2008 Regents of the University of Minnesota.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies of this Software or works derived from
this Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

GDAL
####

Refer to the GDAL license found at /ms4w/gdaldata/LICENSE.TXT

MrSID
#####

Portions of this computer program are copyright (c) 1995-2019
LizardTech, Inc.
All rights reserved. MrSID is protected by U.S. Patent No. 5,710,835.
Foreign Patents Pending.

FreeType
########

Portions of this software are copyright (c) 2019 The FreeType Project
(www.freetype.org).  All rights reserved.

Apache
######

Refer to the Apache license found at /ms4w/Apache/LICENSE-APACHE.txt

PHP
###

Refer to the PHP license found at /ms4w/Apache/php/LICENSE_PHP.txt