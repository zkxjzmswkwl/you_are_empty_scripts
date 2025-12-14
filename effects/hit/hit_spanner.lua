partice_system_desc = {
	auto_delete = 4,
-------------------------------------------------------------------------------------
	{	-- дымо 1 (g0)
		max_count = 4,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
--		tex_animation = { 8, 4, 32, },
		flags = { "use_colors", "use_size", },
--		fixed_size = { 15, 15, 15, },
		blend_type = "blend",
--		alpha_test_type = "greater",
--		alpha_test_ref = 0,
		color = { { "point", 1, 1, 1, }, 0.6, },
		size = { "point", 8, 8, 8, },
		velocity = { "blob", 0, 0, 100, 20, },
--		starting_age = { 0.5, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 100, { "line", 0, 0, 0, 0,0,20,},time = {0,0.05,} },
			{ "gravity", 0, 0, -120, },
			{ "bounce2", 0.2, 0.5, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
--			{ "orbit_line", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 1, },
			{ "target_size", 70,70,0,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,3, },
			{ "damping", -4.6,-4.6,-4.6, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------
	{	-- Ошметки материи 3
		max_count = 7,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .5, .5, .5, }, 1, },
		size = { "line", 0.5, 0.5, 30, 5, 5, 60},  --rendom Razmera
		velocity = { "blob", 0, 0, 500, 70, },
		rotation = { 0, 360, },
		angular_vel = { 0, 200, },
		colliding = 0,          -- procenti koligena
		actions = {
			{ "source", 700, { "point", 5, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -3500, },
			{ "bounce2", 0.9, 0.3, },
			{ "kill_old", 1, },
                        { "target_color", 0, 0, 0, 1, 1.9, },
			{ "target_size", 5,5,5,0.5,0.5,1, },
			{ "target_angular_velocity", 0, 3, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
}


decal_desc = {
		width = 8,
		depth = 4,
		textures = { "WLM_Spanner1.tga", "WLM_Spanner2.tga", "WLM_Spanner3.tga",}, 
		decal_type = "blend",
		life_time = 8,
		fade_time = 2,
}


sound_desc = {
	file_name = { "klyu4_kick_beton1.wav", "klyu4_kick_beton2.wav", "klyu4_kick_beton3.wav", "klyu4_kick_beton4.wav", },
	volume = -0.5,
	max_distance = 35*64,
}
