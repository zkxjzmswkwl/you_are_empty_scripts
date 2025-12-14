sound_desc = {
	volume = 0;
	min_distance = 5*64;
	max_distance = 10*64;
	loop = true;
	file_name = {
		"Fire1.wav", "Fire2.wav", "Fire3.wav",
	};
}

partice_system_desc = {

-- group 0 - Flame

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .77, .53, .37, .73, .49, .37}, .3, },
		size = { "point", 12, 12, 12, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "sphere", 0, 10, 0, 40, 50},
		rotation = { -180, 180, },
		angular_vel = { -49, 49, },
		max_count = 27,
		colliding = 0,
		actions = {
			{ "source", 50, { "blob", 0, 0, 0, 7}, switchable = true, },
			{ "target_velocity", 0, 0, 120, 3},
			{ "target_size", 70, 70, 0, .5, .5, .5, },
			{ "target_color", 0,0,0,0,5, filter = {0.3, 5}, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", .75, },
			{ "move", },
		},
	},

}