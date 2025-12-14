partice_system_desc = {
	auto_delete = 1,
-------------------------------------------------------------------------------------
	{	-- дымо 1 (g0)
		max_count = 5,
		type = "sprite_view_align_xy",
		texture = "PRT_Droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .65, .65, }, 1, },
		size = { "point", 5, 5, 5, },
		velocity = { "line", 0, 0, 30, 0, 0, 730, 130, 270},
		rotation = { 0, 330, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,},time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "kill_old", 1.95, },
			{ "target_size", 30,30,0,1,1,1, },
			{ "target_color", .37, .33, .21, 0, 2, },
			{ "damping", -4.6,-4.6,-4.6, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------
	{	-- ќшметки материи 
		max_count = 5,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis03.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.4, 0.45, 0.45 }, 1, },
		size = { "point", 1, 1, 1, },
		velocity = { "blob", 0, 0, 400, 50, },
		rotation = { 0, 360, },
		angular_vel = { 0, 200, },
		colliding = 0,
		actions = {
			{ "source", 700, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -1000, },
			{ "bounce2", 0.9, 0.3, },
			{ "kill_old", 1, },
			{ "target_size", 5,5,5,0.5,0.5,1, },
			{ "target_angular_velocity", 0, 3, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------
}
--- собственно сами декалы выстрелов, обратите внимаение, а∆∆ шесть штук!
decal_desc = {
		width = 6,
		depth = 4,
		textures = {"WLM_WallBullet_Stone01.tga","WLM_WallBullet_Stone02.tga","WLM_WallBullet_Stone03.tga","WLM_WallBullet_Stone04.tga","WLM_WallBullet_Stone05.tga","WLM_WallBullet_Stone06.tga",}, 
		decal_type = "modulate",
		life_time = 15,
		fade_time = 2,
}

sound_desc = {
	file_name = { "bullet_hit_zemlya0.wav", "bullet_hit_zemlya1.wav", "bullet_hit_zemlya2.wav", "bullet_hit_zemlya3.wav", },
	volume = -0.5,
	max_distance = 35*64,
}
