partice_system_desc = {

-- group 0 - cone2_dust

-- [[

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_Black04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .19, .125, .07}, .27, },
		size = { "line", 70, 70, 50, 140, 140, 5,},
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 100, },
		angular_vel = { 0, 17},
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 1000, { "cylinder", 0, 0, -170, 0, 0, -120, 30, 70 }, switchable = true, },
			{ "move", },
		},
	},
--]]

-- group 1 - cone2_rays

-- [[

	{
		type = "sprite_velocity_align",
		texture = "pfx_flamethrower1b.tga",
		flags = { "use_colors", "use_size", "tex_animation", },
		tex_animation = { 8, 1, 0 },
		blend_type = "add",
		color = { { "point", .05, .03, .02}, .27, },
		size = { "point", 273, 17, 7, },
		velocity = { "point", 0, 0, -0.01},
		rotation = { 0, 100, },
		max_count = 30,
		colliding = 0,
		actions = {
			{ "source", 1000, { "box", 70, 70, -170, -70, -50, -173, }, switchable = true, },
			{ "move", },
--			{ "target_color", 0, 0, 0, 3, 3, 3, 0, filter = { 2, 3, }, },
--			{ "kill_old", 3}, 
		},
	},
--]]
-- group 2 - cone2_dust

-- [[

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_Black04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .19, .125, .07}, .27, },
		size = { "line", 70, 70, 50, 140, 140, 5,},
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 100, },
		angular_vel = { 0, 17},
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 1000, { "cylinder", 50, 100, -210, 50, 100, -300, 10, 70 }, switchable = true, },
			{ "move", },
		},
	},
--]]

}