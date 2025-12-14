partice_system_desc = {
auto_delete = .7,
--Кровавое поподание в тело! 
	{	-- Крававое месиво из мелких кусочков запекшейся крови!!! гыыыы  (g0)
		max_count = 3,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "blend",
		color = { { "point", 0.5, 0, 0, }, 1, },
		size = { "point", 10, 10, 10, },
		velocity = { "sphere", 0, 0, 370, 20, 300},
		rotation = { 0, 360, },
		angular_vel = { 100, 1, },
		colliding = 0,
		actions = {
			{ "source", 100, { "line", 0, 0, 0, 0,0,20,},time = {0,0.1,} },
			{ "gravity", 0, 0, -120, },
			{ "kill_old", .7, },
			{ "target_size", 70,70,0,0.5,0.5,3, filter = { 0.1, 0.7 },},
			{ "target_color", 0.5, 0, 0,0,7, filter = { 0.3, 0.7 }, },
			{ "damping", -5,-5,-5, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
	{	-- Капли крови
		type = "sprite_view_align_xy",
		max_count = 12,
		texture = "PRT_BloodDrop01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.5, 0, 0, }, 1, },
		size = { "line", 1, 1, 1, 3, 3, 3, },
		velocity = { "sphere", 0, 0, 700, 70, 200,},
		rotation = { 0, 360, },
		angular_vel = { 320, 200, },
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -1000, },
			{ "kill_old", .7, },
			{ "target_color", 0.3, 0, 0,0,1.5, },
			{ "damping", -2,-2,-2, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------

}

sound_desc = {
	file_name = { "player_pain.WAV", },
	volume = -0.5,
	max_distance = 35*64,
}

--- собственно сами декалы выстрелов, обратите внимаение, аЖЖ шесть штук!
decal_desc = {
		width = 3,
		depth = 4,
		textures = {"WLM_WallBullet_Stone01.tga","WLM_WallBullet_Stone02.tga","WLM_WallBullet_Stone03.tga","WLM_WallBullet_Stone04.tga","WLM_WallBullet_Stone05.tga","WLM_WallBullet_Stone06.tga",}, 
		decal_type = "modulate",
		life_time = 15,
		fade_time = 2,
}

