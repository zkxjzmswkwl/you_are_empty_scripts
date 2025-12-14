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
	file_name = { "TeloMedium0.wav", "TeloMedium1.wav", "TeloMedium10.wav", "TeloMedium11.wav", "TeloMedium12.wav", "TeloMedium13.wav", "TeloMedium14.wav", "TeloMedium15.wav", "TeloMedium16.wav", "TeloMedium17.wav", "TeloMedium18.wav", "TeloMedium19.wav", "TeloMedium2.wav", "TeloMedium20.wav", "TeloMedium21.wav", "TeloMedium22.wav", "TeloMedium23.wav", "TeloMedium24.wav", "TeloMedium25.wav", "TeloMedium26.wav", "TeloMedium27.wav", "TeloMedium28.wav", "TeloMedium29.wav", "TeloMedium3.wav", "TeloMedium30.wav", "TeloMedium31.wav", "TeloMedium32.wav", "TeloMedium33.wav", "TeloMedium4.wav", "TeloMedium5.wav", "TeloMedium6.wav", "TeloMedium7.wav", "TeloMedium8.wav", "TeloMedium9.wav"},
	volume = -0.5,
	max_distance = 35*64,
}

-------------------------------------------------------------------------------------

decal_desc = {
		width = 73,
		depth = 21,
		textures = {"WLM_Blood01.tga",}, 
		decal_type = "modulate",
		life_time = 20,
		fade_time = 5,
}

