 partice_system_desc = 
{
auto_delete = 2,

	{	-- Debris Large
		max_count = 12,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 1, .95, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 7, 7, 1, 16, 16, 1},
		velocity = { "sphere", 0, 0, 150, 0, 200},
		colliding = 0,
		actions = 
		{
			{ "target_color", 0.5, 0.5, 0.5, 0, 1.0, },
			{ "target_size", 16, 16, 1, 1, 1, 1, },
			{ "source", 1000, { "box", -40, -3, -40, 40, 3, 40, }, 	},
			{ "gravity", 0, 0, -1000},
			{ "kill_old", 2.0, },
			{ "damping", -1.0, -1.0, -1.0, },
			{ "bounce2", 0, .5, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------

	{	-- Debris Small
		max_count = 25,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 1, .95, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 2, 2, 1, 7, 7, 1},
		velocity = { "sphere", 0, 0, 200, 0, 500},
		colliding = 0,
		actions = 
		{
			{ "source", 1000, { "box", -40, -3, -40, 40, 3, 40, }, 	},
			{ "gravity", 0, 0, -1000},
			{ "kill_old", 2.0, },
			{ "damping", -1.0, -1.0, -1.0, },
			{ "bounce2", 0, .5, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------

	{	-- Sparks Point
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", 1.5, 1.5, 1.5}, 1, },
		size = { "point", 3, 3, 3, },
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 1000, { "point", 0, 0, 0}, time = {0, 0.1} },
			{ "target_size", 73, 73, 37, 17, 17, 3, },
			{ "target_color", 0, 0, 0, 17, },
			{ "kill_old", .2, },
			{ "move", },
		},
	},

-------------------------------------------------------------------------------------

	{	-- Sparks
		type = "sprite_velocity_align",
		texture = "PRT_spark02.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, 0, 0, 100, 300},
		fixed_velocity_scale = { .03, .001 },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0, 0.2} },
--			{ "damping", -7, -7, -7},
			{ "kill_old", .37, },
			{ "move", },
		},
	},


}

sound_desc = {
	file_name = { "Window_Break_01.wav", "Window_Break_02.wav", },
	volume = -0.5,
	min_distance = 5*64,
	max_distance = 35*64,
}

