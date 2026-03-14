if keyboard_check_pressed(vk_tab){
	window_set_fullscreen(!window_get_fullscreen())
}

if keyboard_check_pressed(ord("R")){
	game_restart()
}

selected_tile = screen_to_map(mouse_x,mouse_y)

player_pos = {
	i : obj_player.i,
	j : obj_player.j,
	k : obj_player.k,
}

saw_player = false

angle_ombre = mouse_y*4 %360