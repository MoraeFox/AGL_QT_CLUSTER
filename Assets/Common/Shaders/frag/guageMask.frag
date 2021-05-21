uniform mediump float angleBase;
uniform mediump float angle;
uniform mediump sampler2D src;
uniform mediump float qt_Opacity;
varying mediump vec2 coord;
void main(){
    mediump vec2 d=2.0*coord-vec2(1.0,1.0);
    mediump float a=atan(d.x,-d.y);
    mediump vec4 tex = texture2D(src, coord);
    gl_FragColor = (angleBase<=a && a<=angle) ?  tex * qt_Opacity : tex * 0.0;
}
