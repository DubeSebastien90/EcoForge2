if (!surface_exists(surf_night)) {
    surf_night = surface_create(room_width, room_height);
}

surface_set_target(surf_night);
    // 1. On remplit TOUTE la surface d'une couleur opaque (Alpha = 1)
    // C'est l'obscurité totale
    draw_clear(color_night); 

    // 2. On change de mode pour "effacer" la couleur là où il y a de la lumière
    // gpu_set_blendmode(bm_subtract) est OK ici si la surface est opaque (Alpha 1)
    gpu_set_blendmode(bm_normal); 
    
    // On dessine la lumière du joueur
    // Note : Plus le sprite est BLANC, plus il "percera" l'obscurité
    draw_sprite_ext(spr_light, 1, obj_player.x, obj_player.y - 2, 0.5, 0.5, 0, c_white, 0.3);
    
    gpu_set_blendmode(bm_normal);
surface_reset_target();

// 3. C'est ICI que l'on gère l'intensité globale du cycle jour/nuit
// On dessine la surface avec l'opacité calculée (current_darkness)
draw_set_alpha(current_darkness);
    draw_surface(surf_night, 0, 0);
draw_set_alpha(1);