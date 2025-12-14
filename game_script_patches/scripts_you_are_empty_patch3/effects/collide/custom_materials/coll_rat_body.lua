partice_system_desc = {
auto_delete = 1,

-- 1 Blood puff
	{
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
	file_name = { "Rat_body0.wav", "Rat_body1.wav", "Rat_body2.wav", "Rat_body3.wav", "Rat_body4.wav", "Rat_body5.wav", "Rat_body6.wav", },
	volume = -0.5,
	max_distance = 35*64,
	channel = "effect_interaction",
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

