partice_system_desc = {
auto_delete = 5,
--выстрел от пистолета, и других оружий стрел€ющих одиничными выстрелами
	{	-- дымо 1 (g0)
		max_count = 1,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_Black04.tga",
--		tex_animation = { 8, 4, 32, },
		flags = { "use_colors", "use_size", },
--		fixed_size = { 15, 15, 15, },
		blend_type = "add",
--		alpha_test_type = "greater",
--		alpha_test_ref = 0,
		color = { { "point", 1, 1, 1, }, 1, },
		size = { "point", 8, 8, 8, },
		velocity = { "blob", 0, 0, 460, 20, },
--		starting_age = { 0.5, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 100, 1, },
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
	{	-- дымок 2 (g1)
		max_count = 2,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_Black03.tga",
		flags = { "use_colors", "use_size","use_rotation", },
		blend_type = "add",
		color = { { "point", 0.4, 0.4, 0.4, }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 260, 30, },
		rotation = { 0, 360, },
		angular_vel = { 300, 50, },
		colliding = 0,
		actions = {
			{ "source", 100, { "point", 0, 0, 0,},time = {0,0.4,} },
			{ "gravity", 0, 0, -100, },
			{ "bounce2", 0.2, 0.5, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
--			{ "orbit_line", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 1, },
			{ "target_size", 70,70,0,0.5,0.5,5, },
			{ "target_color", 0,0,0,0,7, },
			{ "damping", -3.6,-3.6,-3.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
	{	-- вспышка
		max_count = 1,
		type = "sprite_view_align_xy",
		texture = "PRT_Spark.tga",
		flags = { "use_colors", "use_size", },
--		fixed_size = { 35, 35, 35, },
		blend_type = "add",
		color = { { "point", 0.8, 0.8, 0.8, }, 1, },
		size = { "point", 10, 10, 10, },
		rotation = { 0, 120, },
		angular_vel = { 100, 100, },
		colliding = 1,
		actions = {
			{ "source", 100, { "point", 0, 0, 0,},time = {0, 0.02,}, },
			{ "kill_old", 0.05, },
			{ "target_size", 1,1,1,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,1, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
	{	-- ќшметки материи 1
		type = "sprite_view_align_xy",
		max_count = 2,
		texture = "PRT_Derbis02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
--		fixed_size = { 2, 2, 2, },
		blend_type = "blend",
		color = { { "point", 0.3, 0.3, 0.3, }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 300, 70, },
--		starting_age = { 0.5, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 320, 200, },
		colliding = 1,
		actions = {
			{ "source", 20, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -1000, },
			{ "bounce2", 0.2, 0.1, },
			{ "kill_old", 2, },
			{ "target_size", 5,5,5,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,1.5, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
	{	-- ќшметки материи 2
		max_count = 2,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.2, 0.2, 0.2, }, 1, },
		size = { "point", 0.5, 0.5, 0.5, },
		velocity = { "blob", 0, 0, 400, 70, },
--		starting_age = { 1, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 390, 200, },
		colliding = 1,
		actions = {
			{ "source", 20, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -1000, },
			{ "bounce2", 0.2, 0.1, },
			{ "kill_old", 2, },
			{ "target_size", 5,5,5,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,1.5, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------
	{	-- ќшметки материи 3
		max_count = 2,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis03.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.4, 0.4, 0.4, }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 350, 70, },
--		starting_age = { 1, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 300, 200, },
		colliding = 1,
		actions = {
			{ "source", 20, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -1000, },
			{ "bounce2", 0.2, 0.1, },
			{ "kill_old", 1, },
			{ "target_size", 5,5,5,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,1.5, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------

}
--- собственно сами декалы выстрелов, обратите внимаение, а∆∆ шесть штук!
decal_desc = {
		width = 3,
		depth = 4,
		textures = {"WLM_WallBullet_Stone01.tga","WLM_WallBullet_Stone02.tga","WLM_WallBullet_Stone03.tga","WLM_WallBullet_Stone04.tga","WLM_WallBullet_Stone05.tga","WLM_WallBullet_Stone06.tga",}, 
		decal_type = "modulate",
		life_time = 15,
		fade_time = 2,
}


sound_desc = {
	file_name = { "klyu4_kick_beton1.wav", "klyu4_kick_beton2.wav", "klyu4_kick_beton3.wav", "klyu4_kick_beton4.wav", },
	volume = -0.5,
	max_distance = 35*64,
}
