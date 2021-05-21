uniform mediump mat4 qt_Matrix;
attribute mediump vec4 qt_Vertex;
attribute mediump vec2 qt_MultiTexCoord0;
varying mediump vec2 coord;
void main(){
    coord = qt_MultiTexCoord0;
    gl_Position = qt_Matrix * qt_Vertex;
}
