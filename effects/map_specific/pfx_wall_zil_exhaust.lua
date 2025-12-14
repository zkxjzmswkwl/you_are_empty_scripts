partice_system_desc = {

-- group 2 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "prt_smoke_white04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .63, .73, .77, .0, .0, .0}, .2, },
		size = { "point", 3, 3, 17, },
		velocity = { "line", 0, 0, -190, 0, 0, -270, },
		rotation = { 0, 180, },
		angular_vel = { 0, 49, },
		max_count = 63,
		colliding = 0,
		actions = {
			{ "source", 27, { "line", 0, 0, 0, -20, 0, 0}, switchable = true, },
			{ "damping", -2, -2, -2, filter = {.3, 5,}, },
			{ "target_velocity", 0, 0, 70, 1},
			{ "target_size", 73, 73, 0, 1, 1, .3, },
			{ "target_color", .3,.3,.3,0,2, filter = {1, 5}, },
			{ "kill_old", 1.75, },
			{ "move", },
		},
	},


}