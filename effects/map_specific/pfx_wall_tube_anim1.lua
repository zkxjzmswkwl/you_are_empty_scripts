sound_desc = {
	volume = 0;
	max_distance = 35*64;
	loop = true;
	file_name = {
		"Fire1.wav", "Fire2.wav", "Fire3.wav",
	};
}

partice_system_desc = {

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, 1, },
		size = { "point", 17, 17, 17, },
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 180, },
		angular_vel = { 0, 1800 },
		max_count = 10,
		colliding = 0,
		actions = {
			{ "source", 20, { "point", 5, 0, 0}, switchable = true, },
			{ "target_size", 73, 73, 73, 37, 37, 3, },
			{ "target_color", 0, 0, 0, 0, 7},
			{ "kill_old", .3, },
			{ "move", },
		},
	},

-- group 1 - Flame

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .77, .53, .37, .73, .49, .37}, .3, },
		size = { "point", 12, 12, 12, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "sphere", 0, 10, 0, 40, 50},
		rotation = { -180, 180, },
		angular_vel = { -49, 49, },
		max_count = 49,
		colliding = 0,
		actions = {
			{ "source", 100, { "blob", 0, 0, 0, 7}, switchable = true, },
			{ "target_velocity", 0, 0, 120, 3},
			{ "target_size", 130, 130, 0, 1, 1, 1, },
			{ "target_color", 0,0,0,0,5, filter = {0.3, 5}, },
			{ "kill_old", .75, },
			{ "move", },
		},
	},


-- group 2 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Droppers_03.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "modulate",
		tex_env = "add",
		color = { { "line", .77, .53, .37, .0, .0, .0}, .3, },
		size = { "point", 17, 17, 17, },
		velocity = { "sphere", 0, 10, 0, 40, 50},
		rotation = { -180, 180, },
		angular_vel = { -49, 49, },
		max_count = 63,
		colliding = 0,
		actions = {
			{ "source", 37, { "blob", 0, 0, 0, 7}, switchable = true, },
			{ "target_velocity", 0, 0, 120, 3},
			{ "target_size", 120, 120, 0, 1, 1, .3, },
			{ "target_color", 1,1,1,0,2, filter = {1, 5}, },
			{ "kill_old", 1.75, },
			{ "move", },
		},
	},


}