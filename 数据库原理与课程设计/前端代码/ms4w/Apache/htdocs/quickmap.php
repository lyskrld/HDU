<?php

/*
 Application:   QuickMap
 Purpose:       Use this file to test mapfiles with PHP MapScriptNG (PHP7)
 Instructions:  - modify the MAPFILE path, and the path to the SWIG include (lines 15 & 18)
                - in a web browser goto http://127.0.0.1/quickmap.php
                - an image of your data should be displayed in your browser, or
                  a MapServer error
 Documentation: - follow the SWIG MapScript API: https://mapserver.org/mapscript/mapscript.html
 Author:        - Jeff McKenna, info@gatewaygeomatics.com
 */

// define variables
define( "MAPFILE", "C:/ms4w/apps/phpmapscriptng-swig/sample.map" );

// required SWIG include (contains constants for PHP7)
require_once("C:/ms4w/apps/phpmapscriptng-swig/include/mapscript.php");

// open map
$oMap = new mapObj(MAPFILE);

//force all errors to display
//  comment out the next 2 lines, useful on servers not displaying errors
//ini_set('display_errors','On');
//error_reporting(E_ALL);

// set image size
$oMap->setsize(400, 300);

// set image format
$oMap->selectoutputformat("png");

// draw map
$oImage = $oMap->draw();

// save image file
//$file = $oImage->save("C:/ms4w/apps/phpmapscriptng-swig/ttt.png",$oMap);

// set header
header("Content-type: image/png");

//send image to stdout, without saving file locally
echo $oImage ->getBytes();

//clean output buffer
//ob_clean();

// read image to output buffer
//readfile("C:/ms4w/apps/phpmapscriptng-swig/ttt.png");

?>