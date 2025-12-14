partice_system_desc = {

-- group 0 - Dust

	{
		type = "sprite_view_align_xy",
		texture = "prt_smoke_white04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "point", .63, .63, .63}, .27, },
--		size = { "line", 507, 507, 5, 1070, 1070, 17, },
		size = { "point", 507, 507, 5,},
		velocity = { "point", -1000, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 0, },
		angular_vel = { 0, 33, },
		max_count = 49,
		colliding = 0,
		actions = {
			{ "source", 27, { "box", -1000, -1000, -200, 1000, 1000, 500}, switchable = true, },
--			{ "target_velocity", 0, 77, 200, 3 },
--			{ "target_size", 270,270,0,1,1,1, },
			{ "target_color", 1,1,1,0,3, filter = {1.5,2},},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 2, },
			{ "move", },
		},
	},

-- group 1 - Leaves	

	{
		type = "sprite_view_align_xy",
		texture = "Leaves_01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .5, .9, .5, .5, .5, .5}, 1, },
		size = { "line", 7, 7, 5, 10, 10, 17, },
		velocity = { "point", -1000, 0, 0},
		rotation = { 0, 0, },
		angular_vel = { 0, 133, },
		max_count = 21,
		colliding = 0,
		actions = {
			{ "source", 21, { "box", -1000, -1000, -490, 1000, 1000, -100}, switchable = true, },
--			{ "random_velocity", 100, 10, { "sphere", 0, 0, 110, 100, 200}, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},

}