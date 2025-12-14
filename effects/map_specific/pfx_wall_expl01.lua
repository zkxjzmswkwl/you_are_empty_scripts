partice_system_desc = {

-- group 0 - Flame

	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Droppers.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "add",
		color = { { "line", .77, .57, .57, .7, .45, .35}, .7, },
		size = { "line", 10, 10, 10, 20, 20, 20, },
		velocity = { "cone", 0, 0, 100, 0, 0, 3000, 100, 1000},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 12,
		colliding = 0,
		actions = {
			{ "source", 2000, { "line", 0, 0, -100, 0, 0, 200}, time = {0, 0.03}, },
			{ "damping", -7, -7, -7, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 137,137,0,2,2,2, },
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
		size = { "line", 10, 10, 10, 20, 20, 20, },
		velocity = { "cone", 0, 0, 100, 0, 0, 3000, 100, 1000},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 10,
		colliding = 0,
		actions = {
			{ "source", 200, { "line", 0, 0, -100, 0, 0, 200}, time = {0.05, 0.7}, },
			{ "damping", -5, -5, -5, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 200,200,0,1,1,1, },
			{ "target_color", 1,1,1,0,1, filter = {1, 3}, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},

}