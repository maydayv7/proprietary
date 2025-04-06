// Screen Dimming

precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;
void main()
{
  gl_FragColor = texture2D(tex, v_texcoord) * 0.3;
}
