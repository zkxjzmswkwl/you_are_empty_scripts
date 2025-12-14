partice_system_desc = {
	auto_delete = 1,
-------------------------------------------------------------------------------------
-- group 0 - Smoke
	{
		max_count = 3,
		type = "sprite_view_align_xy",
		texture = "prt_smoke_white01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .7, .7, }, .7, },
		size = { "point", 8, 8, 8, },
		velocity = { "line", 0, 0, 30, 0, 0, 730},
		rotation = { -330, 330, },
		angular_vel = { 0, 50, },
		colliding = 0,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,}, time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "kill_old", 1, },
			{ "target_size", 70,70,0,1,1,1, },
			{ "target_color", .37, .37, .37,0,3, filter = {.3, 1}, },
			{ "damping", -7,-7,-7, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
}


sound_desc = {
	file_name = { "klyu4_kick_beton1.wav", "klyu4_kick_beton2.wav", "klyu4_kick_beton3.wav", "klyu4_kick_beton4.wav", },
	volume = -0.5,
	max_distance = 35*64,
	channel = "effect_hit",
}
