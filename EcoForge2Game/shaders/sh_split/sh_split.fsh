//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_fTime;

void main()
{
	vec2 vNewPos = vec2(v_vTexcoord[0], v_vTexcoord[1]);
	if (mod(floor(vNewPos.y * 10.0 + 0.5),2.0) == 0.0){
		vNewPos.x += sin(u_fTime/10.0) * 0.01;
	} else{
		vNewPos.x -= sin(u_fTime/10.0) * 0.01;
	}
	
	if (mod(floor(vNewPos.x * 10.0 + 0.5),2.0) == 0.0){
		vNewPos.y += sin(u_fTime/10.0) * 0.01;
	} else{
		vNewPos.y -= sin(u_fTime/10.0) * 0.01;
	}
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vNewPos );
}
