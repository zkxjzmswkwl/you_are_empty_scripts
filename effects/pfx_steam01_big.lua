partice_system_desc = {

-- group 0 - Steam spray

	{
		type = "sprite_velocity_align",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation", "use_velocity_scale" },
		blend_type = "add",
		color = { { "point", .15, .15, .15}, 1, },
		size = { "point", .02, .02, 7, },
		fixed_velocity_scale = { .1, .001 },
		velocity = { "point", 0, -3000, 0},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 21,
		colliding = 0,
		actions = {
			{ "source", 20, { "point", 0, 30, 0},  switchable = true, },
			{	"damping", -5, -5, -5 },
			{ "target_velocity", 0, 0, 30, 3},
			{ "target_size", 350, 350, 0, 1, 1, 1, },
--			{ "target_color", 0,0,0,0,2, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", .05, },
			{ "move", },
		},
	},

-- group 1 - Steam
--
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation", "use_velocity_scale" },
		blend_type = "add",
		color = { { "point", .15, .15, .15}, .5, },
		size = { "point", 7, 7, 7, },
		fixed_velocity_scale = { 100, 1 },
		velocity = { "line", 0, -1000, 0, 0, -2000, 0},
		rotation = { -180, 180, },
		angular_vel = { -21, 21, },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "source", 10, { "point", 0, 0, 0},  switchable = true, },
			{	"damping", -2, -2, -2 },
			{ "target_velocity", 0, 0, 30, 3},
			{ "target_size", 300, 300, 0, .5, .5, .5, },
			{ "target_color", 0,0,0,0,3, filter = {.5, 1.5}, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 1.5, },
			{ "move", },
		},
	},
--]]

}