//surface
surf = -1; // Initialisation vide


function detect_collision(tile_index, _x, _y, _obj){
	if tile_index == -1{
		return false
	}
	image_index = tile_index
	return place_meeting(_x,_y,_obj)
}

