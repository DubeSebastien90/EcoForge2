time = 0

ufTime = shader_get_uniform(sh_wave,"u_fTime")
ufTime_split = shader_get_uniform(sh_split,"u_fTime")

upixelH = shader_get_uniform(sh_pixel_outline,"pixelH")
upixelW = shader_get_uniform(sh_pixel_outline,"pixelW")

texelW = 10*texture_get_texel_width(sprite_get_texture(sprite_index,image_index))
texelH = 10*texture_get_texel_height(sprite_get_texture(sprite_index,image_index))
