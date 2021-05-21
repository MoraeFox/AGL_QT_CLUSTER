#ifndef GL_ES

#define lowp
#define mediump
#define highp
#define precision

#endif

uniform highp samplerCube u_CubeMapTexture;
uniform highp vec3 u_rgbFactor;
uniform highp float u_alphaFactor;

uniform mediump float u_Dist_Rate;
uniform mediump float u_Dist_Position_Rate;


varying highp vec3 v_CubeTexCoord;
varying highp float v_Distance;

void main()
{    
    highp float DistDark = u_Dist_Position_Rate - v_Distance * u_Dist_Rate;

    gl_FragColor = textureCube(u_CubeMapTexture, v_CubeTexCoord) * vec4(u_rgbFactor * DistDark, u_alphaFactor);
}
