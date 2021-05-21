#ifndef GL_ES

#define lowp
#define mediump
#define highp
#define precision

#endif

uniform highp mat4 mvp;
uniform highp mat4 modelMatrix;
uniform highp mat3 modelNormalMatrix;
uniform highp vec3 eyePosition;

attribute highp vec4 vertexPosition;
attribute highp vec3 vertexNormal;

varying highp vec3  v_CubeTexCoord;
varying highp float v_Distance;

void main()
{
    gl_Position =  mvp * vertexPosition;

    v_Distance = gl_Position.z / gl_Position.w;

    highp vec3 view = eyePosition - (modelMatrix * vertexPosition).xyz;
    highp vec3 normalWorld = normalize(modelNormalMatrix * vertexNormal);
    v_CubeTexCoord = reflect(view, normalWorld);
}
