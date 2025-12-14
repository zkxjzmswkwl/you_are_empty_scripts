partice_system_desc = {

-- group 1 - Dust sprites under bright spotlight

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .07, .06, .05, .09, .08, .073}, 1, },
		size = { "line", 77, 77, 77, 117, 117, 117, },
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 180, },
		angular_vel = { 0, 7, },
		max_count = 21,
		colliding = 0,
		actions = {
			{ "source", 5000, { "cylinder", 0, 0, 50, 0, 0, 0, 0, 128}, switchable = true, },
--			{ "target_velocity", 0, 0, -5, 3},
--			{ "target_size", 73,73,0,.3,.3,.3, },
--			{ "kill_old", 30, },
			{ "move", },
		},
	},


}