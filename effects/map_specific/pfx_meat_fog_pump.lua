partice_system_desc = {

-- group 0 - Dust

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .063, .049, .027}, 1, },
		size = { "line", 207, 207, 5, 307,307, 17, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "point", 0, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 12, },
		max_count = 20,
		colliding = 0,
		actions = {
			{ "source", 500, { "box", -200, -100, 0, 100, 200, 300}, switchable = true,},
--			{ "target_velocity", 0, 0, 20, 3 },
--			{ "target_size", 270,270,0,1,1,1, },
--			{ "target_color", 0,0,0,.3,.3},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
--			{ "kill_old", 5, },
			{ "move", },
		},
	},
-- group 1 - Dust Flow 1

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .0, .0, .0}, 1, },
		size = { "line", 77, 77, 5, 137,137, 17, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "point", 0, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 12, },
		max_count = 30,
		colliding = 0,
		actions = {
			{ "source", 7, { "box", -100, 130, 250, 150, 170, 200}, switchable = true,},
			{ "target_velocity", 0, 0, 170, 1 },
			{ "target_size", 37,37,0,1,1,1, },
			{ "target_color",  .073, .049, .027,1,5},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 2, },
			{ "move", },
		},
	},

-- group 2 - Dust Flow 2

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .0, .0, .0}, 1, },
		size = { "line", 77, 77, 5, 137,137, 17, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "point", 0, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 12, },
		max_count = 30,
		colliding = 0,
		actions = {
			{ "source", 7, { "box", -100, -70, 250, 150, -50, 200}, switchable = true, },
			{ "target_velocity", 0, 0, 170, 1 },
			{ "target_size", 37,37,0,1,1,1, },
			{ "target_color",  .073, .049, .027,1,5},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 2, },
			{ "move", },
		},
	},


}