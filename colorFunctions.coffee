#//////////////////////////////////////////////////////////////////////////
# Color functions derived from Processing
#//////////////////////////////////////////////////////////////////////////

colorModeA = 255
colorModeX = 255
colorModeY = 255
colorModeZ = 255


# Color component bit masks
ALPHA_MASK = 0xff000000
RED_MASK = 0x00ff0000
GREEN_MASK = 0x0000ff00
BLUE_MASK = 0x000000ff


###*
* Creates colors for storing in variables of the color datatype. The parameters are
* interpreted as RGB or HSB values depending on the current colorMode(). The default
* mode is RGB values from 0 to 255 and therefore, the function call color(255, 204, 0)
* will return a bright yellow color. More about how colors are stored can be found in
* the reference for the color datatype.
*
* @param {int|float} aValue1        red or hue or grey values relative to the current color range.
* Also can be color value in hexadecimal notation (i.e. #FFCC00 or 0xFFFFCC00)
* @param {int|float} aValue2        green or saturation values relative to the current color range
* @param {int|float} aValue3        blue or brightness values relative to the current color range
* @param {int|float} aValue4        relative to current color range. Represents alpha
*
* @returns {color} the color
*
* @see colorMode
###

colorIntFromRGB = (aValue1, aValue2, aValue3) ->
  r = undefined
  g = undefined
  b = undefined
  a = undefined
  r = Math.round(255 * aValue1 / colorModeX)
  g = Math.round(255 * aValue2 / colorModeY)
  b = Math.round(255 * aValue3 / colorModeZ)
  a = Math.round(255 * 255 / colorModeA)
  # Limit values less than 0 and greater than 255
  r = if r < 0 then 0 else r
  g = if g < 0 then 0 else g
  b = if b < 0 then 0 else b
  a = if a < 0 then 0 else a
  r = if r > 255 then 255 else r
  g = if g > 255 then 255 else g
  b = if b > 255 then 255 else b
  a = if a > 255 then 255 else a
  # Create color int
  a << 24 & ALPHA_MASK | r << 16 & RED_MASK | g << 8 & GREEN_MASK | b & BLUE_MASK

# Creates a WebGL color array in [R, G, B, A] format. WebGL wants the color ranges between 0 and 1, [1, 1, 1, 1]

colorIntToGLArray = (colorInt) ->
  [
    ((colorInt & RED_MASK) >>> 16) / 255
    ((colorInt & GREEN_MASK) >>> 8) / 255
    (colorInt & BLUE_MASK) / 255
    ((colorInt & ALPHA_MASK) >>> 24) / 255
  ]
