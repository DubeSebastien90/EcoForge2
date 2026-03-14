randomise()

tile_width = 32;
tile_height = 16; // En iso, la hauteur apparente est souvent la moitié de la largeur
world_size = 10;
world_depth = 3;
z_height = 12;

alpha_behind = 0.3

//tuiles
FLOOR = [0,1,3]
OBSTACLES = [4,5]

// Initialisation du monde
worldmap = array_create(world_size);


for (var i = 0; i < world_size; i++) {
    worldmap[i] = array_create(world_size);
    for (var j = 0; j < world_size; j++) {
        var height = choose(world_depth-1,world_depth-2,world_depth-2,world_depth-2,world_depth-2,world_depth-2)
		for (var k = 0; k < world_size; k++) {
			if k < height{
				worldmap[i][j][k] = {tile: 1, a : 1}
			} else if k == height{
				worldmap[i][j][k] = {tile: 0, a : 1}
			} else if k == height + 1{
				worldmap[i][j][k] = {tile: choose(-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,4,5), a : 1}
			} else worldmap[i][j][k] =  {tile: -1, a : 1}
		}
    }
}

// Position de départ (le sommet du diamant)
start_x = room_width / 2;
start_y = room_height / 2 - tile_height*(world_size-world_depth)/2;

//sélection
selected_tile = {
	i : -1,
	j : -1,
	k : -1
}

//joueur
player_pos = {
	i : -1,
	j : -1,
	k : -1
}

function screen_to_map(screen_x, screen_y) {
    var _found_i = -1;
    var _found_j = -1;
    var _found_k = -1;

    // On parcourt dans le MÊME ORDRE que le Draw (de l'arrière vers l'avant)
    for (var k = 0; k < world_size; k++) {
        for (var i = 0; i < world_size; i++) {
            for (var j = 0; j < world_size; j++) {
                
                var _tile_type = worldmap[i][j][k].tile;
                if (_tile_type == -1) continue; // On ignore les trous

                // Récupérer la position où la tuile est dessinée
                var _pos = map_to_screen(i, j, k);

                // Détection de collision
                // Comme ton origine est Bottom-Center :
                // _pos.x est le milieu horizontal, _pos.y est le bas du sprite.
                if (obj_tile.detect_collision(_tile_type, _pos.x, _pos.y, obj_mouse)) {
                    // Si on touche, on mémorise. 
                    // Comme on avance vers le "devant", la nouvelle valeur écrasera l'ancienne.
                    _found_i = i;
                    _found_j = j;
                    _found_k = k;
                }
            }
        }
    }

    return { i: _found_i, j: _found_j, k: _found_k };
}

function map_to_screen(map_i, map_j, map_k) {
    var _screen_x = start_x + (map_j - map_i) * (tile_width / 2);
    var _screen_y = start_y + (map_j + map_i) * (tile_height / 2);
    
    // On remonte de z_height pour chaque niveau k
    _screen_y -= (map_k * z_height);
    
    return { x: _screen_x, y: _screen_y };
}

function floor_at_i_j(map_i, map_j) {
    // On part du sommet (world_depth - 1) vers le bas (0)
    for (var k = world_depth - 1; k >= 0; k--) {
        
        var _tile_id = worldmap[map_i][map_j][k].tile;
        
        // On vérifie si cet ID est contenu dans le tableau FLOOR
        if (is_floor(_tile_id)) {
            return k; // On retourne l'index de l'étage le plus haut
        }
    }
    return -1; // Aucun sol trouvé à cette position i, j
}

function is_floor(_id) {
    for (var i = 0; i < array_length(FLOOR); i++) {
        if (_id == FLOOR[i]) return true;
    }
    return false;
}

function is_obstacle(_id) {
    for (var i = 0; i < array_length(OBSTACLES); i++) {
        if (_id == OBSTACLES[i]) return true;
    }
    return false;
}

//shaders
upixelH = shader_get_uniform(sh_pixel_outline,"pixelH")
upixelW = shader_get_uniform(sh_pixel_outline,"pixelW")
uDrawingA = shader_get_uniform(sh_pixel_outline,"drawingA")

surf_ombre = -1;
angle_ombre = 45+180;

surf = -1

