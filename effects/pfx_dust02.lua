partice_system_desc = {

-- group 1 - Dust sprites, slowly falling down in the room

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .77, .63, .57, .93, .83, .73}, .81, },
		size = { "line", 77, 77, 77, 117, 117, 117, },
		velocity = { "sphere", 0, 0, 0, 0, 0, },
		rotation = { -180, 180, },
		angular_vel = { 0, 7, },
		max_count = 21,
		colliding = 0,
		actions = {
			{ "source", 50, { "sphere", 150, 0, 50, 50, 200}, time = {0, 0.3}, },
			{ "target_velocity", 0, 0, -5, 3},
--			{ "target_size", 73,73,0,.3,.3,.3, },
			{ "target_color", .5, .5, .5, 0, .3, filter = {25, 30}, },
			{ "kill_old", 30, },
			{ "move", },
		},
	},


}