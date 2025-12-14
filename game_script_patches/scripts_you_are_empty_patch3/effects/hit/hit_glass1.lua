partice_system_desc = 
{
auto_delete = 2,
	-------------------------------------------------------------------------------------
	-- Cone Backward
	-------------------------------------------------------------------------------------
	{	-- sparks
		max_count = 12,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 0, 180, },
		angular_vel = { 0, 1000, },
		size = { "line", 2, 2, 1, 7, 7, 1},
		velocity = { "cone", 0, 0, 0, 0, 0, -700, 10, 70, },
		colliding = 0,
		actions = 
		{
			{ "damping", -2 -2, -2, },
			{ "source", 5000, { "point", 0, 0, 0}, time = {0, .1} },
			{ "kill_old", 2, },
			{ "gravity", 0, 0, -1000},
			{ "move", },

		},
	},
	
	-------------------------------------------------------------------------------------
	-- Dust Backward
	-------------------------------------------------------------------------------------
	{	-- sparks
		max_count = 7,
		type = "sprite_axis_align_xy",
		texture = "prt_droppers.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 1, 1, 1, }, 1.0, },
		rotation = { 0, 180, },
		size = { "point", 7, 7, 1, },
		velocity = { "cone", 0, 0, -300, 0, 0, -700, 10, 70, },
		colliding = 0,
		actions = 
		{
			{ "target_color", 1, 1, 1, 0, 5, },
			{ "target_size", 37,37,0, 3, 3, 1, },
			{ "source", 40, { "point", 0, 0, 0,}, time = {0, .1} },			
			{ "kill_old", .3, },
			{ "damping", -3.7, -3.7, -3.7, },
			{ "move", },


		},
	},
	
	-------------------------------------------------------------------------------------
	-- Sphere Center
	-------------------------------------------------------------------------------------
	{	-- sparks
		max_count = 12,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 0, 180, },
		angular_vel = { 0, 1000, },
		size = { "line", 2, 2, 1, 7, 7, 1},
		velocity = { "sphere", 0, 0, 0, 0, 370, },
		colliding = 0,
		actions = 
		{
			{ "damping", -0.2 -0.2, -0.2, },
			{ "source", 5000, { "point", 0, 0, 0}, time = {0, .1} },
			{ "kill_old", 1.6, },
			{ "gravity", 0, 0, -1000},
			{ "move", },

		},
	},
	
	-------------------------------------------------------------------------------------
	-- Dust particles
	-------------------------------------------------------------------------------------
	{	-- sparks
		max_count = 1,
		type = "sprite_axis_align_xyz",
		texture = "prt_droppers.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 1, 1, 1, }, 1, },
		size = { "line", 16, 16, 1, 16, 16, 1},
		velocity = { "point", 0, 0, 0, },
		rotation = { 0, 180, },
		actions = {
			{ "target_color", 1, 1, 1, 0, 5, },  
			{ "target_size", 73,73,0, 3, 3, 1, },
			{ "source", 40, { "point", 0, 0, 0,}, time = {0, .1} },			
			{ "kill_old", .3, },
			{ "damping", -1, -1, -1, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------

}


sound_desc = {
	file_name = { "glass_hit_01.wav", "glass_hit_02.wav", "glass_hit_03.wav", },
	volume = -0.7,
	min_distance = 5*64,
	max_distance = 35*64,
	channel = "effect_hit",
}

decal_desc = {
		width = 5,
		depth = 4,
		textures = {"wlm_mauzer_glass1.tga","wlm_mauzer_glass2.tga","wlm_mauzer_glass3.tga", "wlm_mauzer_glass4.tga", "wlm_mauzer_glass5.tga", "wlm_mauzer_glass6.tga", "wlm_mauzer_glass7.tga", "wlm_mauzer_glass8.tga",}, 
		decal_type = "bland",
		life_time = 15,
		fade_time = 2,
}

