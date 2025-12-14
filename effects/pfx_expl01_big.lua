partice_system_desc = {
	auto_delete = 2.5,

-- group 0 - Flame

	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Droppers.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "add",
		color = { { "line", .77, .57, .57, .7, .45, .35}, .7, },
		size = { "line", 30, 30, 30, 70, 70, 70, },
		velocity = { "sphere", 0, 5000, 1000, 1000, 3000, },
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 17,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0, 0.03}, },
			{ "damping", -5, -5, -5, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 537,537,0,2,2,2, },
			{ "target_color", 0,0,0,0,7, filter = {.3, 1}, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},
-- group 1 - Smoke
	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "modulate",
		tex_env = "add",
		color = { { "line", .37, .27, .21, .17, .15, .15}, 1, },
		size = { "line", 30, 30, 30, 70, 70, 70, },
		velocity = { "sphere", 0, 5000, 1000, 1500, 3500, },
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 17,
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 0, 0, 0}, time = {0.05, 0.3}, },
			{ "damping", -5, -5, -5, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 730,730,0,1,1,1, },
			{ "target_color", 1,1,1,0,.7, filter = {1.25, 2.5}, },
			{ "kill_old", 2.5, },
			{ "move", },
		},
	},
-- group 1 - Smoke
--[[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .37, .37, .37, .63, .63, .63}, .5, },
		size = { "point", 57, 75, 7, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "sphere", 0, 0, 10, 100, 200},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 17,
		colliding = 0,
		actions = {
			{ "source", 200, { "sphere", 0, 0, 0, 10, 150}, time = {.2, .7}, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 337,337,0,.3,.3,.3, },
			{ "target_color", 1,1,1,0,5, filter = {1, 2}, },
			{ "kill_old", 2, },
			{ "move", },
		},
	},
--]]

}


light_desc = {
	range = 1250;
	duration = .2;
	color = { .77, .55, .37 };
}



sound_desc = {
	file_name = { "Explosion1.wav", "Explosion2.wav", "Explosion3.wav", "Explosion4.wav", "Explosion5.wav", "Explosion6.wav", "Explosion7.wav", "Explosion8.wav", },
	volume = -0.5,
	max_distance = 335*64,
}
