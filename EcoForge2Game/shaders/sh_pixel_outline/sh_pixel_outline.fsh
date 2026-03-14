//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float pixelH; //pourcentage de l'écran pris par un pixel
uniform float pixelW;
uniform float drawingA;

void main()
{
	vec2 offsetx;
	offsetx.x = pixelW;
	vec2 offsety;
	offsety.y = pixelH;
	
	//ajouter alpha si pixel à côté est non transparent
	float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;
	
	//couleur de l'outline
	vec4 newVColour = v_vColour;
	
	//if (alpha < 0.1){
		//newVColour = vec4(1.0,0.0,0.0,1.0);
	//}
	
	alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord + offsetx).a);
	alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord - offsetx).a);
	alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord + offsety).a);
	alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord - offsety).a);
	
    gl_FragColor = newVColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.a = alpha;
	if (gl_FragColor.a > 0.0){
		gl_FragColor.a = drawingA;
	}
	
}
