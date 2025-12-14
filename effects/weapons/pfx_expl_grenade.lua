partice_system_desc = {
	auto_delete = 5,

-- group 0 - Flame
-- [[
	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Droppers.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "add",
		color = { { "line", .77, .57, .57, .7, .45, .35}, .7, },
		size = { "line", 10, 10, 10, 20, 20, 20, },
		velocity = { "sphere", 0, 0, 2000, 3000, 5000, },
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 17,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0, 0.03}, },
			{ "damping", -15, -15, -15, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 137,137,0,3,3,3, },
			{ "target_color", 0,0,0,0,7, filter = {.3, 1}, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},
--]]
-- group 1 - Smoke
-- [[
	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "modulate",
		tex_env = "add",
		color = { { "line", .3, .3, .3, .7, .7, .7}, 1, },
		size = { "line", 10, 10, 10, 20, 20, 20, },
		velocity = { "sphere", 0, 0, 100, 1500, 2500, },
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 17,
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 0, 0, 0}, time = {0.05, 0.3}, },
			{ "damping", -7, -7, -7, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 230,230,0,1,1,1, },
			{ "target_color", 1,1,1,0,1, filter = {1, 1.8}, },
			{ "kill_old", 1.8, },
			{ "move", },
		},
	},
--]]
-- group 2 - Smoke
-- [[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .49, .49, .49, .81, .81, .81}, 1, },
		size = { "point", 57, 75, 7, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "sphere", 0, 0, 10, 300, 700},
		rotation = { -180, 180, },
		angular_vel = { 0, 21, },
		max_count = 17,
		colliding = 0,
		actions = {
			{ "source", 200, { "sphere", 0, 0, 0, 10, 150}, time = {.2, .7}, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "damping", -3, -3, -3, },
			{ "target_size", 237,237,0,.3,.3,.3, },
			{ "target_color", 1,1,1,0,1.5, filter = {3, 5}, },
			{ "kill_old", 5, },
			{ "move", },
		},
	},
--]]

-- group 3 - Glow

	{
		type = "sprite_axis_align_xy",
		texture = "prt_spark03.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "add",
		color = { { "point", .7, .7, .7,}, .7, },
		size = { "line", 10, 10, 10, 20, 20, 20, },
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0, 0.1}, },
			{ "target_size", 1000,1000,0,5,5,5, },
			{ "target_color", 0,0,0,0,3, },
			{ "kill_old", .15, },
			{ "move", },
		},
	},
}


light_desc = {
	range = 550;
	duration = .1;
	color = { .77, .55, .37 };
}



sound_desc = {
	file_name = { "Explosion1.wav", "Explosion2.wav", "Explosion3.wav", "Explosion4.wav", "Explosion5.wav", "Explosion6.wav", "Explosion7.wav", "Explosion8.wav", },
	volume = 0,
	min_distance = 5*64,
	max_distance = 50*64,
}

decal_desc = {
		width = 90,
		depth = 40,
		textures = {"prt_droppers_03.tga",}, 
		decal_type = "modulate",
		life_time = 15,
		fade_time = 2,
}
