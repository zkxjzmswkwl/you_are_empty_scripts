partice_system_desc = {

-- group 0

	{
		type = "lines_view_align",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .9, .9, .9}, 1, },
		size = { "point", 5, 5, 1, },
		max_count = 3000,
		colliding = 1,
		
		actions = {
			{ "source", 1000, { "disc", 0, 0, 1000, 0, 0, -1, 1000, 0}, switchable = true, },
			{ "gravity", 0, 0, -10000},
			{ "kill_old", 2, },
			{ "kill_old", 0, filter = { 0, 10, true } },
			{ "move", },
		},
	},
}