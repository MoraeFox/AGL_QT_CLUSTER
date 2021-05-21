uniform mediump mat4 mvp;

attribute mediump vec4 vertexPosition;
attribute mediump vec2 vertexTexCoord;

/*out*/
varying mediump vec2 v_texCoord;


void main()
{
    v_texCoord = vertexTexCoord;
    gl_Position = mvp * vertexPosition;
}
