partice_system_desc = {
auto_delete = .7,

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
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 5000, { "sphere", 0, 0, 0, 5, 20}, time = {0, 0.1}, },
--			{ "target_velocity", 0, 0, 50, 1},
			{ "target_size", 33,33,0,1,1,3, },
			{ "target_color", .5, .5, .5, 0, 2.5,  },
			{ "kill_old", .7, },
			{ "move", },
		},
	},
}
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

sound_desc = {
	file_name = { "TeloMedium0.wav", "TeloMedium1.wav", "TeloMedium10.wav", "TeloMedium11.wav", "TeloMedium12.wav", "TeloMedium13.wav", "TeloMedium14.wav", "TeloMedium15.wav", "TeloMedium16.wav", "TeloMedium17.wav", "TeloMedium18.wav", "TeloMedium19.wav", "TeloMedium2.wav", "TeloMedium20.wav", "TeloMedium21.wav", "TeloMedium22.wav", "TeloMedium23.wav", "TeloMedium24.wav", "TeloMedium25.wav", "TeloMedium26.wav", "TeloMedium27.wav", "TeloMedium28.wav", "TeloMedium29.wav", "TeloMedium3.wav", "TeloMedium30.wav", "TeloMedium31.wav", "TeloMedium32.wav", "TeloMedium33.wav", "TeloMedium4.wav", "TeloMedium5.wav", "TeloMedium6.wav", "TeloMedium7.wav", "TeloMedium8.wav", "TeloMedium9.wav"},
	volume = -0.5,
	max_distance = 35*64,
}

