partice_system_desc = {

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .7, .7, 1}, 1, },
		size = { "point", 27, 27, 17, },
		velocity = { "point", 0, 0, 0},
		rotation = { -180, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 5, 0, 0}, time = {0, 0.02} },
			{ "kill_old", .1, },
			{ "move", },
		},
	},

-- group 1 - Sparks Spot
--
	{
		type = "sprite_velocity_align",
		texture = "PRT_spark01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .7, .7, 1}, 1, },
		size = { "point", 37, 3, 17, },
		velocity = { "sphere", 0, -1000, 0, 300, 700},
		max_count = 12,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 5, 0, 0}, time = {0, 0.02} },
			{ "gravity", 0, 0, -300},
			{ "kill_old", .1, },
			{ "move", },
		},
	},
--]]
-- group 2 - Sparks

	{
		type = "sprite_velocity_align",
		texture = "PRT_spark01.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .7, .7, 1}, 1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, -300, 0, 300, 700},
		fixed_velocity_scale = { .1, .001 },
		max_count = 21,
		colliding = 1,
		actions = {
			{ "source", 200, { "point", 5, 0, 0}, time = {0, 0.2} },
			{ "damping", -1, -1, -1},
			{ "bounce2", 0, 1, },
			{ "gravity", 0, 0, -1500},
			{ "kill_old", 1.2, },
			{ "move", },
		},
	},


}