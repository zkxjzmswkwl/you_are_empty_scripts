partice_system_desc = {

-- group 0 - Dust flying out

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .37, .33, .27, .63, .53, .43}, 1, },
		size = { "point", 17, 17, 17, },
		velocity = { "sphere", -2000, 0, 0, 0, 0, 100, 100, 200},
		rotation = { -180, 180, },
		angular_vel = { 0, 37, },
		max_count = 21,
		colliding = 0,
		actions = {
			{ "source", 50, { "sphere", 0, 0, -100, 50, 100}, time = {0, 0.3}, },
			{ "target_velocity", 0, 0, 30, 6},
			{ "target_size", 173,173,0,.3,.3,.3, },
			{ "target_color", .5, .5, .5, 0, 1, filter = {1.5, 3}, },
			{ "kill_old", 3, },
			{ "move", },
		},
	},

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

-- group 2 - Dust sprites on the floor

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .77, .63, .57, .93, .83, .73}, .81, },
		size = { "line", 37, 37, 37, 77, 77, 77, },
		velocity = { "sphere", 0, 0, 0, 0, 0, },
		rotation = { -180, 180, },
		angular_vel = { 0, 7, },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "source", 500, { "box", 0, -300, -100, 300, 0, -50}, time = {0, 10}, },
			{ "target_velocity", 0, 0, -5, 3},
--			{ "target_size", 73,73,0,.3,.3,.3, },
			{ "target_color", .5, .5, .5, 0, .55, filter = {3.7, 7}, },
			{ "kill_old", 7, },
			{ "move", },
		},
	},


}
sound_desc = {
	volume = 0,
	max_distance = 15*64,
	loop = false,
	file_name = {
		"BetonPlita0.wav", "BetonPlita2.wav", 
	},
}