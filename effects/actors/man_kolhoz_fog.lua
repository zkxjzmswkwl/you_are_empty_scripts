------------------------------------------------------------------------------------------
partice_system_desc = {

-- group 1 - Smoke
-- [[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .05, .05, .05, .07, .07, 0.07}, .7, },
		size = { "point", 57, 75, 7, },
		velocity = { "sphere", 0, 0, 10, 300, 700},
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 15,
		colliding = 0,
		actions = {
			{ "source", 200, { "sphere", 0, 0, 0, 10, 150}, time = {.2, .7}, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "damping", -3, -3, -3, },
			{ "target_size", 337,337,0,.3,.3,.3, },
			{ "target_color", 0, 0, 0, 1, 0.3,  },
			{ "kill_old", 25, },
			{ "move", },
		},
	},
-- ]]
}

