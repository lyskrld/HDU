Simple demo for MapServer Mapbox Vector Tile (MVT) support using the Mapbox-GL library
--------------------------------------------------------------------------------------

Demo Source: https://github.com/sdlime/mvt-demo

Setup:

- MS4W 4.0.0 has been compiled with MVT support, with the required protobuf and protobuf-c libraries.
- Edit sample.json -> sources.compass.tiles property to reflect your setup:
    - URL for MapServer compiled with MVT support.
    - Location of the demo.map file.
- Point your browser to the index.html file and if all went well you should see something 
  like the screenshot in this directory.


