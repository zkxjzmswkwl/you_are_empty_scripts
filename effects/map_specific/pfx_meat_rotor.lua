partice_system_desc = {

-- group 0 - Dust

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .033, .025, .017}, 1, },
		size = { "line", 27, 27, 5, 37,37, 17, },
		velocity = { "point", 0, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 12, },
		max_count = 300,
		colliding = 0,
		actions = {
			{ "source", 150, { "cylinder", 0, -500, 0, 0, 200, 0, 50, 70}, switchable = true,},
--			{ "target_velocity", 0, 0, 20, 3 },
--			{ "target_size", 270,270,0,1,1,1, },
			{ "target_color", 0,0,0,.3,.3},
			{ "vortex", 7764, 2007, 314, 7764, 3007, 314, -15000, 10000, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},

-- group 1 - Center

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .133, .093, .081}, 1, },
		size = { "line", 27, 27, 5, 37,37, 17, },
		velocity = { "point", 0, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 120, },
		max_count = 100,
		colliding = 0,
		actions = {
			{ "source", 150, { "cylinder", 0, -500, 0, 0, 200, 0, 00, 20}, switchable = true,},
--			{ "target_velocity", 0, 0, 20, 3 },
--			{ "target_size", 270,270,0,1,1,1, },
			{ "target_color", 0,0,0,.3,.3},
--			{ "vortex", 7764, 2007, 314, 7764, 3007, 314, -15000, 10000, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},

-- group 2 - Center Flow

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .063, .063, .063}, 1, },
		size = { "line", 27, 27, 5, 37,37, 17, },
		velocity = { "point", 0, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 37, },
		max_count = 100,
		colliding = 0,
		actions = {
			{ "source", 15, { "cylinder", 0, -200, 0, 0, 200, 0, 00, 20}, switchable = true,},
			{ "target_velocity", 0, 0, 37, 3 },
			{ "target_size", 170,170,0,.1,.1,1, filter = {2, 5}, },
			{ "target_color", 0,0,0,.3,.3, filter = {2, 5}, },
--			{ "vortex", 7764, 2007, 314, 7764, 3007, 314, -15000, 10000, },
			{ "kill_old", 5, },
			{ "move", },
		},
	},


}