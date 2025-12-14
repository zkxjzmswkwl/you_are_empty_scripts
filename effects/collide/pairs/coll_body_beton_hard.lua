partice_system_desc = {
auto_delete = 1,
--Кровавое поподание в тело! 
	{	-- Крававое месиво из мелких кусочков запекшейся крови!!! гыыыы  (g0)
		max_count = 3,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "blend",
		color = { { "point", 0.8, 0, 0, }, 1, },
		size = { "point", 8, 8, 8, },
		velocity = { "sphere", 0, 0, 250, 20, 100},
		rotation = { 0, 360, },
		angular_vel = { 100, 1, },
		colliding = 0,
		actions = {
			{ "source", 100, { "line", 0, 0, 0, 0,0,20,},time = {0,0.05,} },
			{ "gravity", 0, 0, -120, },
			{ "bounce2", 0.2, 0.5, },
			{ "kill_old", 1, },
			{ "target_size", 70,70,0,0.5,0.5,1, },
			{ "target_color", 0.8, 0, 0,0,3, filter = {0.5, 1}, },
			{ "damping", -4.6,-4.6,-4.6, },
			{ "move", },

		},
	},

}
-------------------------------------------------------------------------------------

sound_desc = {
	file_name = { "body_main_0.wav", "body_main_1.wav", "body_main_2.wav", "body_main_3.wav", "body_main_4.wav", "body_main_5.wav", "body_main_6.wav", "body_main_7.wav", "body_main_8.wav", "body_main_9.wav", },
	volume = -0.5,
	min_distance = 5*64,
	max_distance = 20*64,
}

-------------------------------------------------------------------------------------

decal_desc = {
		width = 33,
		depth = 16,
		textures = {"WLM_Blood01.tga", "WLM_Blood02.tga", "WLM_Blood03.tga",}, 
		decal_type = "modulate",
		life_time = 20,
		fade_time = 5,
}

