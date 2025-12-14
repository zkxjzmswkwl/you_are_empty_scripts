partice_system_desc = {
auto_delete = .1,

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, 1, },
		size = { "point", 50, 50, 3, },
		velocity = { "line", 0, 0, 0, 0, 0, 0},
		rotation = { -180, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 5, -5, 0}, time = {0.08, 0.1} },
			{ "target_size", 17, 17, 17, 17, 17, 3, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},
}

light_desc = {
	range = 250;
	duration = .1;
	color = { .77, .55, .37 };
}

sound_desc = {
	file_name = { "mauz_bullet0.wav", "kly4_kick1.wav", "mauz_bullet3.wav", "mauz_bullet2.wav", },
	volume = -0.5,
	max_distance = 150*64,
	channel = "effect_shoot",
}