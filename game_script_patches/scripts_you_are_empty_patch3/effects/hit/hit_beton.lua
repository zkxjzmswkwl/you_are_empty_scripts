partice_system_desc = {
auto_delete = 5,
--выстрел от пистолета, и других оружий стрел€ющих одиничными выстрелами
	{	-- дымо 1 (g0)
		max_count = 20,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
--		tex_animation = { 8, 4, 32, },
		flags = { "use_colors", "use_size", },
--		fixed_size = { 15, 15, 15, },
		blend_type = "blend",
--		alpha_test_type = "greater",
--		alpha_test_ref = 0,
		color = { { "point", 1, 1, 1, }, 0.4, },
		size = { "point", 8, 8, 8, },
		velocity = { "blob", 0, 0, 460, 20, },
--		starting_age = { 0.5, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,},time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "bounce2", 0.2, 0.5, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
--			{ "orbit_line", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 1, },
			{ "target_size", 70,70,0,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,10, },
			{ "damping", -4.6,-4.6,-4.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
	{	-- дымок 2 (g1)
		max_count = 20,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "blend",
		color = { { "point", 1, 1, 1, }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 260, 40, },
		rotation = { 0, 360, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 540, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -200, },
			{ "bounce2", 0.2, 0.5, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
--			{ "orbit_line", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 2, },
			{ "target_size", 100,100,0,0.5,0.5,1, },
			{ "target_color", 1,1,1,0,5, },
			{ "damping", -2.6,-2.6,-2.6, },
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
		color = { { "point", 0.3, 0.3, 0.3, }, 1, },
		size = { "point", 6, 6, 6, },
		rotation = { 0, 120, },
		angular_vel = { 0, 100, },
		colliding = 1,
		actions = {
			{ "source", 50, { "point", 0, 0, 0,},time = {0, 0.02,}, },
			{ "kill_old", 0.1, },
			{ "target_size", 1,1,1,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,0, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
	{	-- ќшметки материи 1
		type = "sprite_view_align_xy",
		max_count = 20,
		texture = "PRT_Derbis02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
--		fixed_size = { 2, 2, 2, },
		blend_type = "blend",
		color = { { "point", 0.3, 0.3, 0.3, }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 300, 70, },
--		starting_age = { 0.5, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 0, 200, },
		colliding = 0,
		actions = {
			{ "source", 60, { "point", 0, 0, 0,},time = {0,0.05,} },
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
		max_count = 20,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.2, 0.2, 0.2, }, 1, },
		size = { "point", 0.5, 0.5, 0.5, },
		velocity = { "blob", 0, 0, 400, 70, },
--		starting_age = { 1, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 0, 200, },
		colliding = 0,
		actions = {
			{ "source", 80, { "point", 0, 0, 0,},time = {0,0.05,} },
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
		max_count = 20,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis03.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.4, 0.4, 0.4, }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 350, 70, },
--		starting_age = { 1, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 0, 200, },
		colliding = 0,
		actions = {
			{ "source", 70, { "point", 0, 0, 0,},time = {0,0.05,} },
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

--CreateDecal(tr.Point, tr.Normal/*dir*/, 3.f, 5.f, "vitia_wallmark1.tga", DCL_BLEND, 6000, 1000);
decal_desc = {
		width = 3,
		depth = 4,
		textures = {"WLM_WallBullet_Stone.tga",}, 
		decal_type = "modulate",
		life_time = 10,
		fade_time = 2,
}


sound_desc = {
	file_name = { "klyu4_kick_beton1.wav", "klyu4_kick_beton2.wav", "klyu4_kick_beton3.wav", "klyu4_kick_beton4.wav", },
	volume = -0.5,
	max_distance = 35*64,
	channel = "effect_hit",
}
