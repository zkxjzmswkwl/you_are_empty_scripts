partice_system_desc = {

-- group 0 - Steam

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .03, .03, .03, }, .7, },
		size = { "point", 177, 177, 127, },
		velocity = { "point", 0, 0, 90,},
		rotation = { 0, 180, },
		angular_vel = { 0, 3, },
		max_count = 33,
		colliding = 0,
		actions = {
			{ "source", 3, { "box", -203, -203, -733, 203, 203, -537}, switchable = true, },
			{ "target_color", 0,0,0,0,.3, filter = {8, 10}, },
			{ "kill_old", 10, },
			{ "move", },
		},
	},

-- group 1 - Drops

	{
		type = "sprite_velocity_align",
		texture = "PRT_BloodDrop01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .12, .12, .15, }, .7, },
		size = { "point", 37, 2, 127, },
		velocity = { "point", 0, 0, 0,},
		rotation = { 0, 180, },
		max_count = 303,
		colliding = 1,
		actions = {
			{ "source", 7, { "box", -173, -173, 273, 173, 173, 277}, switchable = true, },
			{ "bounce2", 1, 1, },
			{ "gravity", 0, 0, -1000, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},

-- group 2 - Splashes

	{
		type = "sprite_velocity_align",
		texture = "PRT_BloodDrop01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .21, .21, .27, }, .7, },
		size = { "point", 12, 1, 127, },
		velocity = { "sphere", 0, 0, 170, 70, 170},
		rotation = { 0, 180, },
		angular_vel = { 0, 37, },
		max_count = 33,
		source_vel = { 0, 0, },
		colliding = 0,
		actions = {
			{ "source_from_group", 1, 30, switchable = true, filter = true, },
			{ "gravity", 0, 0, -700, },
			{ "target_color", 0,0,0,0,7, },
			{ "kill_old", .3, },
			{ "move", },
		},
	},

}