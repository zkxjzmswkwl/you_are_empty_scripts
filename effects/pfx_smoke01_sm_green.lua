partice_system_desc = {

-- group 0 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .37, 1, .37, .63, 1, .63}, .3, },
		size = { "point", 7, 7, 7, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "point", 0, 0, 10},
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 17,
		colliding = 0,
		actions = {
			{ "source", 2, { "point", 0, 0, 0}, switchable = true, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 37,37,0,.3,.3,.3, },
			{ "target_color", 1,1,1,0,3, filter = {4.5, 5}, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 5, },
			{ "move", },
		},
	},


}