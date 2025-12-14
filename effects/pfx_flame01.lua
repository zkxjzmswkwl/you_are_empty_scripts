partice_system_desc = {
--	auto_delete = 5,

-- group 0 - Flames

--[[
	{
		type = "sprite_view_align_xy",
		texture = "flare_test01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", 1, .73, 0.3}, 1, },
		size = { "line", 7, 7, 5, 17, 17, 17, },
		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 0, },
		angular_vel = { 0, 33, },
		max_count = 33,
		colliding = 0,
		actions = {
			{ "source", 21, { "point", -50, 0, 0, }, },
			{ "target_velocity", 0, 77, 200, 3 },
			{ "target_size", 270,270,0,1,1,1, },
			{ "target_color", 0,0,0,0,5},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 0.3, },
			{ "move", },
		},
	},
--]]

-- group 1 - Flames

--[[
	{
		type = "sprite_view_align_xy",
		texture = "flare_test01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", 1, .73, 0.3}, 1, },
		size = { "line", 7, 7, 5, 17, 17, 17, },
		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 0, },
		angular_vel = { 0, 33, },
		max_count = 33,
		colliding = 0,
		actions = {
			{ "source", 21, { "point", 50, 0, 0, }, },
			{ "target_velocity", 0, 77, 200, 3 },
			{ "target_size", 270,270,0,1,1,1, },
			{ "target_color", 0,0,0,0,5},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 0.3, },
			{ "move", },
		},
	},
--]]


-- group 2 - Smoke
--
	{
		type = "sprite_view_align_xy",
		texture = "prt_droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
--		alpha_test_type = "less",
--		alpha_test_ref = 1,
		color = { { "point", 0.49, .21, 0.07}, 3, },
		size = { "line", 37, 37, 5, 77, 77, 77, },
		velocity = { "point", 0, 30, -100, },
		rotation = { 0, 180, },
		angular_vel = { 0, 33, },
		max_count = 73,
		colliding = 0,
		actions = {
			{ "source", 7, { "sphere", 0, -70, 100, 0, 30}, },
			{ "target_velocity", 0, 0, 300, 2 },
			{ "target_size", 270,270,0,1,1,1, },
			{ "target_color", 0,0,0,0,1.5},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 2, },
			{ "move", },
		},
	},
--]]


}