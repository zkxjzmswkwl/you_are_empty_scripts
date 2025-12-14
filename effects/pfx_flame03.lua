partice_system_desc = {

-- group 0 - Flame glow

	{
		type = "sprite_axis_align_xy",
		texture = "PRT_spark01.tga",
		flags = { "use_colors", "use_size", "use_rotation", "use_velocity_scale" },
		blend_type = "add",
		color = { { "point", .5, .37, .7}, 1, },
		size = { "point", .05, .05, 7, },
		fixed_velocity_scale = { .1, .02 },
		velocity = { "point", 0, -2000, 0},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 21,
		colliding = 0,
		actions = {
			{ "source", 20, { "sphere", 0, 40, 0, 0, 10}, switchable = true, },
			{	"damping", -7, -7, -7 },
			{ "target_velocity", 0, 0, 70, 3},
			{ "target_size", 250, 250, 0, 3, 3, 3, },
			{ "target_color",  .3, .15, 0,0,15, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},

-- group 1 - Flame spray

	{
		type = "sprite_velocity_align",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", "use_rotation", "use_velocity_scale" },
		blend_type = "add",
		color = { { "point", 1, .8, 1}, 1, },
		size = { "point", .02, .02, 7, },
		fixed_velocity_scale = { .05, .001 },
		velocity = { "point", 0, -2000, 0},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 33,
		colliding = 0,
		actions = {
			{ "source", 20, { "point", 0, 40, 0}, switchable = true, },
			{	"damping", -10, -10, -10 },
			{ "target_velocity", 0, 0, 70, 3},
			{ "target_size", 250, 250, 0, 2, 2, 2, },
			{ "target_color",  1, .8, .5,0,10, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", .05, },
			{ "move", },
		},
	},

-- group 2 - Spot glow
--[[
	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Smoke_Black04.tga",
		flags = { "use_colors", "use_size", "use_rotation",  },
		blend_type = "add",
		color = { { "point", 1, .8, .7}, 1, },
		size = { "point", 27, 27, 7, },
		velocity = { "point", 0, -2000, 0},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 2,
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 0, 20, 0}, switchable = true, },
			{ "target_size", 100, 100, 0, 3, 3, 3, },
			{ "target_color",  0, 0, 0,0, 30, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", .05, },
			{ "move", },
		},
	},
--]]
-- group 3 - Fire
--
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", "use_rotation", "use_velocity_scale" },
		blend_type = "add",
		color = { { "point", .5, .4, .5}, 1, },
		size = { "point", .02, .02, 7, },
		fixed_velocity_scale = { .05, .001 },
		velocity = { "point", 0, -2000, 0},
		rotation = { -180, 180, },
		angular_vel = { -71, 71, },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "source", 7, { "point", 0, 70, 0}, switchable = true, },
			{	"damping", -7, -7, -7 },
			{ "target_velocity", 0, 0, 170, 3},
			{ "target_size", 150, 150, 0, .5, .5, .5, },
			{ "target_color",  .125, .07, .05, 0, 3, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},
--]]

}