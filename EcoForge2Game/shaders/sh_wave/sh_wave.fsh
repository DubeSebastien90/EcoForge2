//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_fTime;

void main()
{
	vec2 vNewPos = vec2(v_vTexcoord[0], v_vTexcoord[1]);
	vNewPos.x += sin(u_fTime/10.0 + vNewPos.y * 30.0) * 0.005;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vNewPos );
}
