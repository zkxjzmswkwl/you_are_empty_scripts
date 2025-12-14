partice_system_desc = {

-- group 0 - Dust

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "point", .7, .7, .7}, 1, },
		size = { "line", 507, 507, 5, 1070, 1070, 17, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "point", 0, 0, 0},
--		velocity = { "cone", 0, 0, 700, 0, 0, 970, 0, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 7, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 21, { "point", 0, 0, 0}, },
--			{ "target_velocity", 0, 77, 200, 3 },
--			{ "target_size", 270,270,0,1,1,1, },
--			{ "target_color", 1,1,1,.3,.3},
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
--			{ "kill_old", 1, },
			{ "move", },
		},
	},


}