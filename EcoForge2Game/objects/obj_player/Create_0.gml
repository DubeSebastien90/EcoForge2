i = floor(obj_world.world_size/2)
j = floor(obj_world.world_size/2)
k = obj_world.floor_at_i_j(i,j) + 1

image_alpha = 0

var _pos = obj_world.map_to_screen(i,j,k)
x = _pos.x
y = _pos.y

f_i = i; // Position i fractionnaire
f_j = j; // Position j fractionnaire
move_speed = 0.05; // Vitesse en "unités de tuile" par frame