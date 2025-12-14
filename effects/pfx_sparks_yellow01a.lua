partice_system_desc = {
auto_delete = .7,

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 3, 3, 3, },
		velocity = { "point", 0, 0, 0},
		rotation = { -180, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 5, 0, 0}, time = {0, 0.03} },
			{ "target_size", 17, 17, 17, 17, 17, 3, },
			{ "target_color", 0, 0, 0, 17, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},

-- group 2 - Sparks

	{
		type = "sprite_velocity_align",
		texture = "PRT_spark01.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, 0, 0, 300, 700},
		fixed_velocity_scale = { .1, .001 },
		max_count = 21,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 5, 0, 0}, time = {0, 0.2} },
			{ "damping", -3, -3, -3},
			{ "gravity", 0, 0, -2500},
			{ "kill_old", .7, },
			{ "move", },
		},
	},


}