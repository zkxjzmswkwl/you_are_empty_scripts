partice_system_desc = {
	auto_delete = 5,

-- group 0 - Sparks center
-- [[
	{
		type = "sprite_axis_align_xy",
		texture = "wlm_mauzer_glass1.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "blend",
		color = { { "point", .7,.8,1}, .7, },
		size = { "line", 10, 10, 10,  },
		velocity = { "point", 0, 0, 0, },
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0, 0.1}, switchable = true, },
			{ "target_size", 137,137,0,12,12,12, },
			{ "target_color", .8,.9,1,0,7, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},
--]]
------------------------------------------------------------
-- group 1 - Dark center
	{
		type = "sprite_axis_align_xy",
		texture = "wlm_mauzer_glass1.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "blend",
		color = { { "point", .8,.9,1,}, .7, },
		size = { "line", 1, 1, 1, 3, 3, 3},
		velocity = { "line", 50, 0, 0, 1000, 0, 0, },
		rotation = { 0, 180, },
		angular_vel = { 0, 121, },
		max_count = 15,
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 1, 0, 0}, time = {0, 0.1}, switchable = true, },
			{ "damping", -3,-3,-3, },
			{ "target_size", 49,49,0,7,7,7, },
			{ "target_color", .8,.9,1,0,10, },
			{ "kill_old", .3, },
			{ "move", },
		},
	},
}

