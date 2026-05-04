for (var z = 0; z < world_size; z++) {
    for (var i = 0; i < world_size; i++) {
        for (var j = 0; j < world_size; j++) {
            
            var _tile_type = worldmap[i][j][z].tile;
            
			//joueur
			if (i == round(obj_player.f_i) && j == round(obj_player.f_j) && z == round(obj_player.k)) {
				draw_sprite(spr_player,0,obj_player.x,obj_player.y)
				saw_player = true
			}
			
            // Si la case est vide (on pourrait utiliser -1 pour "vide")
            if (_tile_type == -1) continue; 

            // Calcul de la position X/Y au sol
            var _draw_x = start_x + (j - i) * (tile_width / 2);
            var _draw_y = start_y + (j + i) * (tile_height / 2);
            
            // Ajustement de la hauteur Z
            // On soustrait car en GM, Y diminue vers le haut de l'écran
            var _final_y = _draw_y - (z * z_height);
			
			var surf_scale = 3
			var _w = tile_width * surf_scale;
			var _h = tile_width * surf_scale;

			// Créer la surface (pour appliquer shader)
			if (!surface_exists(surf)) {
			surf = surface_create(_w, _h);
			}

			// Dessiner la surface
			surface_set_target(surf);
				draw_clear_alpha(c_black, 0); // Effacer le contenu précédent (important !)
				draw_sprite(spr_tile, _tile_type, _w / 2, _h / 2); 
			surface_reset_target();

			
			// Dessiner
			draw_set_alpha(worldmap[i][j][z].a);
			draw_surface(surf, _draw_x - (_w / 2), _final_y - (_h / 2));
			draw_set_alpha(1)
			shader_reset()
			
        }
    }
}

