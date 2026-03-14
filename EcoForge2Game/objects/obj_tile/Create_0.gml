//shader
upixelH = shader_get_uniform(sh_pixel_outline,"pixelH")
upixelW = shader_get_uniform(sh_pixel_outline,"pixelW")

//surface
surf = -1; // Initialisation vide


function detect_collision(tile_index, _x, _y, _obj){
	if tile_index == -1{
		return false
	}
	image_index = tile_index
	return place_meeting(_x,_y,_obj)
}

