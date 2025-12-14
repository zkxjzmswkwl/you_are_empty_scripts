partice_system_desc = {

-- group 1 - Dust sprites, slowly falling down in the room

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .05, .05, .05, .07, .07, 0.07}, .7, },
		size = { "point", 27, 45, 7, },
		velocity = { "sphere", 0, 0, 5, 200, 300},
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 15,
		colliding = 0,
		actions = {
			{ "source", 200, { "sphere", 0, 0, 0, 10, 70}, time = {.2, .7}, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "damping", -3, -3, -3, },
			{ "target_size", 137,137,0,.3,.3,.3, },
			{ "target_color", 0, 0, 0, 1, 1.1,  },
			{ "kill_old", 8, },
			{ "move", },
		},
	},


}


sound_desc = {
	volume = 0;
	max_distance = 15*64;
	loop = false;
	file_name = {
		"RazbivYas4ik1.wav", "RazbivYas4ik2.wav", "RazbivYas4ik3.wav",
	};
}
