for (var z = 0; z < world_size; z++) {
    for (var i = 0; i < world_size; i++) {
        for (var j = 0; j < world_size; j++) {
            
            var _tile_type = worldmap[i][j][z].tile;
            
			//joueur
			if (i == player_pos.i && j == player_pos.j && z == player_pos.k){
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

			// Ombre
			if is_obstacle(_tile_type){
				shader_set(sh_ombre)
				draw_sprite_ext(spr_tile, _tile_type,_draw_x - 5*dsin(angle_ombre), _final_y + 5 -5*dcos(angle_ombre),1,1,angle_ombre,c_white,1); 
				shader_reset();
			}

			// Créer la surface (pour appliquer shader)
			if (!surface_exists(surf)) {
			surf = surface_create(_w, _h);
			}

			// Dessiner la surface
			surface_set_target(surf);
				draw_clear_alpha(c_black, 0); // Effacer le contenu précédent (important !)
				draw_sprite(spr_tile, _tile_type, _w / 2, _h / 2); 
			surface_reset_target();

			// Outline
			if (i == selected_tile.i && j == selected_tile.j && z == selected_tile.k){
				shader_set(sh_pixel_outline);
				var tex = surface_get_texture(surf); 
				var texelW = texture_get_texel_width(tex);
				var texelH = texture_get_texel_height(tex);
				shader_set_uniform_f(upixelH,texelH)
				shader_set_uniform_f(upixelW,texelW)
				shader_set_uniform_f(uDrawingA,worldmap[i][j][z].a)
			}
			if saw_player && obj_tile.detect_collision(_tile_type,_draw_x,_final_y, obj_player){
				worldmap[i][j][z].a = lerp(worldmap[i][j][z].a,alpha_behind,0.1)
			} else {
				worldmap[i][j][z].a = lerp(worldmap[i][j][z].a,1,0.1)
			}
			// Dessiner
			draw_set_alpha(worldmap[i][j][z].a);
			draw_surface(surf, _draw_x - (_w / 2), _final_y - (_h / 2));
			draw_set_alpha(1)
			shader_reset()
			
        }
    }
}

