partice_system_desc = {
	auto_delete = 5,

-------------------------------------------------------------------------------------

	{	-- Glass Debris Large
		max_count = 12,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 7, 7, 1, 15, 15, 1},
		velocity = { "sphere", 0, 200, 0, 0, 500},
		colliding = 0,
		actions = 
		{
			{ "target_color", 0.5, 0.5, 0.5, 0, 1.0, },
			{ "source", 1000, { "box", -40, -3, -40, 40, 3, 40, }, time = {0, 0.1}, switchable = true, },
			{ "gravity", 0, 0, -1000},
			{ "kill_old", 2.0, },
--			{ "damping", -1.0, -1.0, -1.0, },
			{ "bounce2", 1, .5, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------

	{	-- Glass Debris Small
		max_count = 50,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 1, 1, 1, 3, 3, 1},
		velocity = { "sphere", 0, 200, 0, 0, 500},
		colliding = 0,
		actions = 
		{
			{ "source", 1000, { "box", -40, -3, -40, 40, 3, 40, }, time = {0, 0.1}, switchable = true, },
			{ "gravity", 0, 0, -1000},
			{ "kill_old", 2.0, },
--			{ "damping", -1.0, -1.0, -1.0, },
			{ "bounce2", 1, .5, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------

		-- Sparks

	{
		type = "sprite_velocity_align",
		texture = "PRT_spark02.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, 300, 500, 100, 500},
		fixed_velocity_scale = { .05, .001 },
		max_count = 120,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 5, 0, 0}, time = {0, 0.2}, switchable = true, },
			{ "target_color", 0, 0, 0, 0, 10, filter = {0.3, 0.5}, },
			{ "damping", -2, -2, -2},
			{ "bounce2", 0, 1, },
			{ "gravity", 0, 0, -1500},
			{ "kill_old", .5, },
			{ "move", },
		},
	},


}


light_desc = {
	range = 550;
	duration = .1;
	color = { .77, .55, .37 };
}



sound_desc = {
	file_name = { "gazvoda_explosion.wav", },
	volume = -0.5,
	max_distance = 30*64,
}

