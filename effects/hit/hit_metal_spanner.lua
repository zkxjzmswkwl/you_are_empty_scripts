partice_system_desc = {
auto_delete = .7,

	{	-- дымо 1 (g0)
		max_count = 4,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "blend",
		color = { { "point", 1, 1, 1, }, 0.6, },
		size = { "point", 8, 8, 8, },
		velocity = { "blob", 0, 0, 100, 20, },
		rotation = { 0, 360, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 100, { "line", 0, 0, 0, 0,0,20,},time = {0,0.05,} },
			{ "gravity", 0, 0, -120, },
			{ "bounce2", 0.2, 0.5, },
			{ "kill_old", 1, },
			{ "target_size", 70,70,0,0.5,0.5,1, },
			{ "target_color", 0,0,0,0,3, },
			{ "damping", -4.6,-4.6,-4.6, },
			{ "move", },

		},
	},

-- group 2 - Sparks

	{
		type = "sprite_velocity_align",
		texture = "PRT_spark02.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, 0, 700, 300, 1200},
		fixed_velocity_scale = { .05, .001 },
		max_count = 12,
		colliding = 1,
		actions = {
			{ "source", 2000, { "point", 5, 0, 0}, time = {0, 0.2} },
			{ "damping", -2, -2, -2},
			{ "bounce2", 0, 1, },
			{ "gravity", 0, 0, -2500},
			{ "kill_old", .7, },
			{ "move", },
		},
	},
}

decal_desc = {
		width = 8,
		depth = 4,
		textures = {"WLM_Spanner1.tga", "WLM_Spanner2.tga", "WLM_Spanner3.tga",}, 
		decal_type = "bland",
		life_time = 8,
		fade_time = 2,
}

sound_desc = {
	file_name = { "klyu4_kick_metal_lyuk1.wav", "klyu4_kick_metal_lyuk2.wav", "klyu4_kick_metal_lyuk3.wav", "klyu4_kick_metal_lyuk4.wav", },
	volume = -0.5,
	min_distance = 1*64,
	max_distance = 35*64,
}
