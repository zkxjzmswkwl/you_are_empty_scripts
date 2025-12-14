partice_system_desc = {

-- group 0 - Smoke

	{
		type = "sprite_velocity_align",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .01, .01, .01, .03, .03, .03}, .7, },
		size = { "point", 2027, 150, 227, },
		velocity = { "point", 0, 0, 3700,},
		rotation = { 0, 180, },
		angular_vel = { 0, 3, },
		max_count = 700,
		colliding = 0,
		actions = {
			{ "source", 27, { "sphere", 0, 0, -2700, 0, 300, }, switchable = true, },
			{ "target_color", 0,0,0,0,5, filter = {0.5, 10}, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},

-- group 1 - Particles

	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Derbis03.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .3, .3, .3, .5, .5, .5}, .7, },
		size = { "line", 3, 3, 3, 12, 12, 22, },
		velocity = { "point", 0, 0, 2700,},
		rotation = { 0, 180, },
		angular_vel = { 0, 3, },
		max_count = 700,
		colliding = 0,
		actions = {
			{ "source", 17, { "sphere", 0, 0, -2700, 0, 500, }, switchable = true, },
			{ "target_color", .3,.3,.3,0,5, filter = {1, 10}, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},


}

