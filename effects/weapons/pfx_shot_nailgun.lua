partice_system_desc = {
auto_delete = .2,

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .1, .1, .1}, 1, },
		size = { "point", 3, 3, 3, },
		velocity = { "line", 0, 0, 0, 1000, -50, -50},
		rotation = { 0, 180, },
		max_count = 5,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", -70, 0, 0}, time = {0.08, 0.1} },
			{ "target_size", 37, 37, .3, 1, 1, 3, },
			{ "target_color", 0, 0, 0, 2.5, 2.5, 2.5, 0, },
			{ "target_velocity", 0, 0, 5, 7, 7, 7, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},

-- group 1 - trace

	{
		type = "sprite_velocity_align",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .2, .2, .2}, 1, },
		size = { "point", 307, 3, 3, },
		velocity = { "point", 100, -2, -5},
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", -70, 0, 0}, time = {0.08, 0.1} },
			{ "target_color", 0, 0, 0, 7, 7, 7, 0, },
			{ "kill_old", .3, },
			{ "move", },
		},
	},
}

light_desc = {
	range = 250;
	duration = .1;
	color = { .37, .25, .17 };
}

