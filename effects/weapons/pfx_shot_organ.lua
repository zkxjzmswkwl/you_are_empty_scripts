partice_system_desc = {
auto_delete = 0.1,

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, 1, },
		size = { "point", 73, 73, 3, },
		velocity = { "line", 0, 0, 0, 0, 0, 0},
		rotation = { -180, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", -10, -5, 0}, time = {0.08, 0.1} },
			{ "target_size", 27, 12, 17, 17, 17, 3, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},
}

light_desc = {
	range = 550;
	duration = .1;
	color = { .37, .25, .17 };
}

