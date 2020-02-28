vertexShaderSrcFaces = """
varying vec3 vFaceColor;

attribute float aVertex;

uniform mat4  uView;
uniform mat4  uProjection;
uniform ivec2 uElementIDAndSide[#{MAX_FACES_PER_BATCH}];
uniform ivec3 uXYZ[#{MAX_FACES_PER_BATCH}];
uniform ivec3 uElementsColors[#{elementsCount}];

void main(void) {
  vec4 theVertex;
  highp int vertexNumberInFace = int(mod(aVertex,6.0));
  highp int faceNumberInt = int(aVertex/6.0);
  highp int aElementIDInt = uElementIDAndSide[faceNumberInt][0];
  highp int aSideInt = uElementIDAndSide[faceNumberInt][1];

  highp int tx = uXYZ[faceNumberInt][0];
  highp int ty = uXYZ[faceNumberInt][1];
  highp int tz = uXYZ[faceNumberInt][2];


  vFaceColor[0] = float(uElementsColors[aElementIDInt-1][0])/255.0;
  vFaceColor[1] = float(uElementsColors[aElementIDInt-1][1])/255.0;
  vFaceColor[2] = float(uElementsColors[aElementIDInt-1][2])/255.0;

  // give a different shade to the sides so there is some
  // basic sense of illumination
  // right or left
  if (aSideInt == 0 || aSideInt == 1) {
    vFaceColor -= 60.0/255.0;
  }
  // front or back
  else if (aSideInt == 4 || aSideInt == 5) {
    vFaceColor -= 30.0/255.0;
  }
  // bottom
  else if (aSideInt == 2) {
    vFaceColor -= 90.0/255.0;
  }
  //
  //


  //FACE_FRONT = 4.0 FACE_BACK = 5.0
  if (aSideInt == 4 || aSideInt == 5) {
    if (vertexNumberInFace == 0 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 1 ) {
      theVertex = vec4( tx+ 1, ty+ 0, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 2 ) {
      theVertex = vec4( tx+ 1, ty+ 1, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 3 ) {
      theVertex = vec4( tx+ 1, ty+ 1, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 4 ) {
      theVertex = vec4( tx+ 0, ty+ 1, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 5 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz+ 0, 1.0 );
    }
  }


  //FACE_TOP = 3.0 FACE_BOTTOM = 2.0
  if (aSideInt == 3 || aSideInt == 2 ) {
    if (vertexNumberInFace == 0 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 1 ) {
      theVertex = vec4( tx+ 1, ty+ 0, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 2 ) {
      theVertex = vec4( tx+ 1, ty+ 0, tz+ 1, 1.0 );
    }
    else if (vertexNumberInFace == 3 ) {
      theVertex = vec4( tx+ 1, ty+ 0, tz+ 1, 1.0 );
    }
    else if (vertexNumberInFace == 4 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz+ +1, 1.0 );
    }
    else if (vertexNumberInFace == 5 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz+ 0, 1.0 );
    }
  }


  //FACE_LEFT = 1 FACE_RIGHT = 0
  if (aSideInt == 1 || aSideInt == 0 ) {
    if (vertexNumberInFace == 0 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 1 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz- 1, 1.0 );
    }
    else if (vertexNumberInFace == 2 ) {
      theVertex = vec4( tx+ 0, ty+ 1, tz - 1, 1.0 );
    }
    else if (vertexNumberInFace == 3 ) {
      theVertex = vec4( tx+ 0, ty+ 1, tz - 1, 1.0 );
    }
    else if (vertexNumberInFace == 4 ) {
      theVertex = vec4( tx+ 0, ty+ 1, tz+ 0, 1.0 );
    }
    else if (vertexNumberInFace == 5 ) {
      theVertex = vec4( tx+ 0, ty+ 0, tz+ 0, 1.0 );
    }
  }

  gl_Position = uProjection * uView * theVertex;
}
"""


fragmentShaderSrcFaces = """
precision mediump float;

varying vec3 vFaceColor;

void main(void){
 gl_FragColor = vec4(vFaceColor,1.0);
}
"""
