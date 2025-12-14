partice_system_desc = {

-- group 0 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .12, .07, .03, }, .7, },
		size = { "point", 27, 27, 27, },
		velocity = { "point", 0, 0, 30,},
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 33,
		colliding = 0,
		actions = {
			{ "source", 3, { "line", 0, -100, 0, 0, 100, 0}, switchable = true, },
			{ "target_velocity", 0, 0, 90, 1},
			{ "target_size", 200, 200, 0, 1, 1, 1, },
			{ "target_color", 0,0,0,0,3, filter = {2, 3}, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},


}