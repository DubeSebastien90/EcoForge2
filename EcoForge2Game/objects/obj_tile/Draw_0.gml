// 1. Calculer les dimensions (2x plus grand)
var surf_scale = 3
var _w = 32 * surf_scale;
var _h = 32 * surf_scale;

// 2. Vérifier/Créer la surface
if (!surface_exists(surf)) {
    surf = surface_create(_w, _h);
}

// 3. Dessiner sur la surface
surface_set_target(surf);
    draw_clear_alpha(c_black, 0); // Effacer le contenu précédent (important !)
    // On dessine le sprite au centre de la surface
    draw_sprite(sprite_index, image_index, _w / 2, _h / 2); 
surface_reset_target();

// 4. Dessiner la surface à l'écran avec le shader
shader_set(sh_pixel_outline);
	var tex = surface_get_texture(surf); 
    var texelW = texture_get_texel_width(tex);
    var texelH = texture_get_texel_height(tex);
	shader_set_uniform_f(upixelW, texelW);
    shader_set_uniform_f(upixelH, texelH);
    // On dessine la surface en compensant le décalage pour que 
    // le sprite reste à sa position d'origine dans la room
    //draw_surface(surf, x - (_w / 2), y - (_h / 2));
shader_reset();