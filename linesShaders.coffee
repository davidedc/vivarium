vertexShaderSrcLines = """
varying vec4 vFaceColor;
attribute vec3 aVertex;
uniform vec4 uColor;
uniform mat4 uView;
uniform mat4 uProjection;
void main(void) {
  vFaceColor = uColor;
  gl_Position = uProjection * uView * vec4(aVertex, 1.0);
}
"""

fragmentShaderSrcLines = """
#ifdef GL_ES
precision highp float;
#endif

varying vec4 vFaceColor;
void main(void){
  gl_FragColor = vFaceColor;
}
"""
