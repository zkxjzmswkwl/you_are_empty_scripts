partice_system_desc = {
auto_delete = 1,

-- Group 0 - Dust
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "point", .49, .49, .49, }, .81, },
		size = { "line", 3, 3, 3, 7, 7, 7, },
		velocity = { "point", 0, 0, 0, 0, 0, },
		rotation = { 0, 180, },
		angular_vel = { 0, 7, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 5000, { "sphere", 0, 0, 0, 5, 20}, time = {0, 0.1}, },
--			{ "target_velocity", 0, 0, 50, 1},
			{ "target_size", 49,49,0,1,1,3, },
			{ "target_color", .5, .5, .5, 0, 3,  },
			{ "kill_old", 1, },
			{ "move", },
		},
	},
}
