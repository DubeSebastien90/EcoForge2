if keyboard_check_pressed(vk_left){
	j -= 1
}
if keyboard_check_pressed(vk_right){
	j += 1
}
if keyboard_check_pressed(vk_up){
	i -= 1
}
if keyboard_check_pressed(vk_down){
	i += 1
}



k = obj_world.floor_at_i_j(i,j) + 1
var _pos = obj_world.map_to_screen(i,j,k)
x = _pos.x
y = _pos.y