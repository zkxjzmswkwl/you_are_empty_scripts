partice_system_desc = {
	auto_delete = 2,
	{	-- дымо 1 (g0)
		max_count = 5,
		type = "sprite_view_align_xy",
		texture = "PRT_Droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .65, .37, }, 1, },
		size = { "point", 5, 5, 5, },
		velocity = { "line", 0, 0, 30, 0, 0, 730, 130, 270},
		rotation = { -330, 330, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,},time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "kill_old", 1, },
			{ "target_size", 30,30,0,1,1,1, },
			{ "target_color", .37, .33, .21, 0, 2, },
			{ "damping", -4.6,-4.6,-4.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------

	{	-- Ошметки материи 3
		max_count = 7,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis03.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .5, .3, }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 350, 70, },
--		starting_age = { 1, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 0, 200, },
		colliding = 1,
		actions = {
			{ "source", 700, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -1000, },
			{ "bounce2", 0.9, 0.3, },
			{ "kill_old", 1, },
			{ "target_angular_velocity", 0, 3, },
			{ "target_size", 5,5,5,0.5,0.5,1, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
}
decal_desc = {
		width = 3,
		depth = 4,
		textures = {"WLM_WallBullet_Stone01.tga","WLM_WallBullet_Stone02.tga","WLM_WallBullet_Stone03.tga","WLM_WallBullet_Stone04.tga","WLM_WallBullet_Stone05.tga","WLM_WallBullet_Stone06.tga",}, 
		decal_type = "modulate",
		life_time = 15,
		fade_time = 2,
}

sound_desc = {
	file_name = { "Palma0.wav", "Palma1.wav", "Palma2.wav", "Palma3.wav" },
	volume = -0.5,
	max_distance = 35*64,
}
