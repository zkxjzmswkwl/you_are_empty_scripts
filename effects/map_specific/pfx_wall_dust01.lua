partice_system_desc = {

-- group 0 - Dust

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .37, .33, .27, .63, .53, .43}, .37, },
		size = { "point", 17, 17, 17, },
		velocity = { "cylinder", 0, 0, 0, 0, 0, 100, 100, 200},
		rotation = { -180, 180, },
		angular_vel = { 0, 37, },
		max_count = 12,
		colliding = 0,
		actions = {
			{ "source", 3000, { "line", 0, -125, 0, 0, 125, 0}, time = {0, 0.1}, },
			{ "target_velocity", 0, 0, 0, 3},
			{ "target_size", 233,233,0,.3,.3,.3, },
			{ "target_color", .5, .5, .5, 0, 1, filter = {1.5, 3}, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},


}