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
		width = 3,
		depth = 4,
		textures = { "WLM_WallBullet_Stone01.tga","WLM_WallBullet_Stone02.tga","WLM_WallBullet_Stone03.tga","WLM_WallBullet_Stone04.tga","WLM_WallBullet_Stone05.tga","WLM_WallBullet_Stone06.tga",}, 
		decal_type = "modulate",
		life_time = 15,
		fade_time = 2,
}

sound_desc = {
	file_name = { "bullet_hit_telefon1.wav", "bullet_hit_telefon2.wav", "bullet_hit_telefon3.wav", "bullet_hit_telefon0.wav", },
	volume = -0.5,
	max_distance = 35*64,
}
