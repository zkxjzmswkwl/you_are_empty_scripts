-- Эффект трейса пули

partice_system_desc = {
auto_delete = 0.7,

-- group 0 - Spot

	{
		type = "lines_view_align",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .9, .9, .9}, 1, },
		size = { "point", 2, 2, 1, },
		-- Скорость трейса пули задавать по оси X
		velocity = { "point", 20000, 0, 0},
		max_count = 1,
		colliding = 1,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0.05, 0.07} },
			{ "kill_old", 2, },
			{ "kill_old", 0, filter = { 0, 10, true } },
			{ "move", },
		},
	},
}