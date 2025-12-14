-- Ёффект трейса пули

partice_system_desc = {
auto_delete = 0.7,

-- group 0 - ќпредел€ет вид сбоку

	{
		type = "lines_view_align",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .9, .9, .9}, 1, },
		size = { "point", 2, 2, 1, },
		-- —корость трейса пули задавать по оси X
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

-- group 1 - ќпредел€ет вид сзади
	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .9, .9, .9}, 1, },
		size = { "point", 3, 3, 1, },
		-- —корость трейса пули задавать по оси X
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