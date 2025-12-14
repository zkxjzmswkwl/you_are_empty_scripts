partice_system_desc = {
auto_delete = .7,

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 3, 3, 3, },
		velocity = { "point", 0, 0, 0},
		rotation = { -180, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 5, 0, 0}, time = {0, 0.03} },
			{ "target_size", 17, 17, 17, 17, 17, 3, },
			{ "target_color", 0, 0, 0, 17, },
			{ "kill_old", .1, },
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
			{ "damping", -5, -5, -5},
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
		textures = { "WLM_Spanner1.tga", "WLM_Spanner2.tga", "WLM_Spanner3.tga",}, 
		decal_type = "blend",
		life_time = 15,
		fade_time = 2,
}

sound_desc = {
	file_name = { "klyu4_kick_katalka_invalidn_kreslo1.wav", "klyu4_kick_katalka_invalidn_kreslo2.wav", "klyu4_kick_katalka_invalidn_kreslo3.wav", "klyu4_kick_katalka_invalidn_kreslo4.wav", },
	volume = -0.5,
	max_distance = 35*64,
}
