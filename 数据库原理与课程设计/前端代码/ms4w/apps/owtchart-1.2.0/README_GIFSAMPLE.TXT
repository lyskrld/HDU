
The "gifsample" executable in this distribution is a CGI that can be used
to produce color and line samples for charts.

e.g.
   http://your.host.name/cgi-bin/gifsample/40/30/255/0/0
   http://your.host.name/cgi-bin/gifsample/40/30/0/0/255?LineStyle=xx+++

Here is the way the gifsample URLs should be built:


 *  The parameters for the color sample to return are taken from the 
 *  PATH_INFO:
 *
 *  /cgi-bin/gifsample/<width>/<height>/<R>/<G>/<B>
 *
 * /<R>/<G>/<B> are optional and behave the same way as the Color parameter
 *
 * Optional QUERY_STRING params:
 *
 * The default behavior with only the PATH_INFO parameters above is to 
 * generate a solid color sample.  The following QUERY_STRING parameters
 * are optional can be used to generate other types of symbology:
 *
 * LineStyle - The sample will be a single line, using the specified
 *             pattern.  The pattern is a string in which spaces 
 *             correspond to transparent pixels, and any other character
 *             will draw a pixel of the sample's color.
 *             Passing an empty LineStyle value will draw a solid line.
 *             Also note that spaces are invalid in a URL and have to be
 *             replaced with the '+' character.
 *             eg. "..&LineStyle=xxxx++++&..."
 * LineWidth - Width of the line sample in pixels (default is 1 pixel)
 * LineType  - There is 3 types of line : ZigZag, Hatch, Line.
 *             Default is Line. All the type are influenced by 
 *             LineStyle and LineWidth.
 * HatchType - Type of hatch (Default is 1):
 *             1 : Slash
 *             2 : Backslash
 *             3 : Horizontal
 *             4 : Vertical
 *             5 : XXXXX
 *             6 : +++++
 * HatchSpacing - Space between line in pixels in the Hatch type (default = 4)
 * SymbolID  - Type of symbol (no default): 
 *             1 : square
 *             2 : circle
 *             3 : triangle
 *             4 : plus (+)
 *             5 : star
 *             6 : dot (filled circle)
 * SymbolSize- Size of the symbol called by SymbolID (in pixels).
 *             The biggest symbol that can enter in the gif is the default
 * Color     - Fore color in RGB (FFFFFF) method (Default is black)
 *             if only this parameter is passed it's the background 
 *             color too
 * BgColor   - Background color of the gif.Default is a transparent white.
 * Outline   - The color of the border around the image. These parameter
 *             must be passed to have a border. Its width is 1 pixel.
 * Corner    - Remove 1 pixel at each corner of the image. If the browser
 *             don't support transparency the corner color will be the color
 *             passed in parameter (Ex : Corner=FFFFFF will make black corner).

--------
$Id: README_GIFSAMPLE.TXT,v 1.1 2003/01/30 03:23:54 daniel Exp $

