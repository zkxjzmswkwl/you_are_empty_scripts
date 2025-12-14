partice_system_desc = {

-- group 0 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_black05.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "modulate",
		tex_env = "add",
		color = { { "point", .17, .17, .17, }, .7, },
		size = { "point", 127, 127, 227, },
		velocity = { "point", 0, 0, 20,},
		rotation = { 0, 180, },
		angular_vel = { 0, 3, },
		max_count = 33,
		colliding = 0,
		actions = {
			{ "source", 7, { "box", -170, -850, -10, 170, 850, 10}, switchable = true, },
			{ "target_velocity", 0, 0, 190, 1},
			{ "target_size", 300, 300, 0, 1, 1, 1, },
			{ "target_color", 1,1,1,0,3, filter = {6, 7}, },
			{ "kill_old", 7, },
			{ "move", },
		},
	},


}