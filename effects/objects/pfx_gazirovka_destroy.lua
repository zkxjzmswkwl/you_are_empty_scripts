partice_system_desc = {
	auto_delete = 5,

-- group 0 - Flame
-- [[
	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Droppers.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "add",
		color = { { "line", .77, .57, .57, .7, .45, .35}, .7, },
		size = { "line", 10, 10, 10, 20, 20, 20, },
		velocity = { "sphere", 0, 500, 0, 300, 500, },
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 2000, { "line", -20, 30, -100, 20, 30, 0}, time = {0, 0.03}, switchable = true, },
			{ "damping", -15, -15, -15, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "target_size", 77,77,0,3,3,3, },
			{ "target_color", 0,0,0,0,7, filter = {.3, 1}, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},
--]]
-- Smoke Raising
-- [[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_Black04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .49, .49, .49, .81, .81, .81}, 1, },
		size = { "line", 17, 17, 5, 37, 37, 17, },
		velocity = { "point", 0, 0, 20, },
		rotation = { 0, 180, },
		angular_vel = { 0, 7, },
		max_count = 30,
		colliding = 0,
		actions = {
			{ "source", 2, { "sphere", 0, 0, -150, 0, 30}, switchable = true, },
			{ "target_velocity", 0, 0, 70, .3},
			{ "target_size", 107, 107,0,.3,.3,.3, },
			{ "target_color", 0,0,0,0,4, filter = {6, 8}, },
			{ "kill_old", 8, },
			{ "move", },
		},
	},
--]]

-------------------------------------------------------------------------------------

-- Smoke
-- [[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_Black04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .49, .49, .49, .81, .81, .81}, 1, },
		size = { "line", 17, 17, 5, 37, 37, 17, },
		velocity = { "sphere", 0, 300, 10, 100, 300},
		rotation = { -180, 180, },
		angular_vel = { 0, 21, },
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 200, { "sphere", 0, 0, 0, 10, 50}, time = {.2, .7}, switchable = true, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "damping", -3, -3, -3, },
			{ "target_size", 137, 137,0,.3,.3,.3, },
			{ "target_color", 0,0,0, 0, 4, filter = {6, 8}, },
			{ "kill_old", 8, },
			{ "move", },
		},
	},
--]]

-------------------------------------------------------------------------------------

	{	-- Glass Debris Large
		max_count = 25,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 7, 7, 1, 16, 16, 1},
		velocity = { "sphere", 0, 200, 0, 0, 500},
		colliding = 0,
		actions = 
		{
			{ "target_color", 0.5, 0.5, 0.5, 0, 1.0, },
			{ "target_size", 16, 16, 1, 1, 1, 1, },
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
		max_count = 25,
		type = "sprite_axis_align_xy",
		texture = "pfx_glass_debris1.tga",
		tex_animation = { 8, 4, 32,  },
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .85, .85, .85, }, 1.0, },
		rotation = { 1000, 1000, },
		size = { "line", 2, 2, 1, 7, 7, 1},
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

