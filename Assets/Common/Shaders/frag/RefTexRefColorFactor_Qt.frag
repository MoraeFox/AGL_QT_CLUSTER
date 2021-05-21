/*out*/

uniform mediump sampler2D u_Texture;
uniform mediump vec3 u_rgbFactor;
uniform mediump float u_alphaFactor;

/*in*/
varying mediump vec2 v_texCoord;

void main()
{
    gl_FragColor = texture2D(u_Texture, v_texCoord) * vec4(u_rgbFactor, u_alphaFactor);
}
