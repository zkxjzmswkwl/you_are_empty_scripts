partice_system_desc = {

-- group 0 - yellow point
--[[

	{
		type = "sprite_view_align_xy",
		texture = "flare_glow01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .81, .73, .63}, .27, },
		size = { "point", 100, 100, 5,},
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 0, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", 0, 0, 0, }, switchable = true, },
			{ "move", },
		},
	},
--]]
-- group 0 - yellow glow
--[[

	{
		type = "sprite_view_align_xy",
		texture = "flare_glow01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .39, .33, .27}, .27, },
		size = { "point", 700, 700, 5,},
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 0, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", 0, 0, 0, }, switchable = true, },
			{ "move", },
		},
	},
--]]
-- group 0 - blue glow
--[[
	{
		type = "sprite_view_align_xy",
		texture = "flare_glow01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .39, .33, .49}, .27, },
		size = { "point", 300, 300, 5,},
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 0, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", 0, 0, 0, }, switchable = true, },
			{ "move", },
		},
	},
--]]
-- group 3 - flare_cone
--[[

	{
		type = "sprite_view_align_xy",
		texture = "flare_cone01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, .27, },
		size = { "point", 210, 210, 5,},
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 0, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", 0, 0, -200, }, switchable = true, },
			{ "move", },
		},
	},
--]]

-- group 4 - cone2_dust

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

}