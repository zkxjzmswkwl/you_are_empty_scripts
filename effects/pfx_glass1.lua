partice_system_desc = 
{
auto_delete = 2,

	{	-- Debris Large
		max_count = 25,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 7, 7, 1, 16, 16, 1},
		velocity = { "sphere", 0, 0, 0, 0, 500},
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
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 2, 2, 1, 7, 7, 1},
		velocity = { "sphere", 0, 0, 0, 0, 500},
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

}

sound_desc = {
	file_name = { "Window_Break_01.wav", "Window_Break_02.wav", },
	volume = -0.7,
	min_distance = 1*64,
	max_distance = 35*64,
}

