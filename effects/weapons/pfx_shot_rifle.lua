partice_system_desc = {
auto_delete = .1,
custom_render = { 65, 0.2, 0.21 };	-- FOV, minZ, maxZ

-- Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, 1, },
		size = { "point", 33, 33, 3, },
		velocity = { "line", 0, 0, 0, 0, 0, 0},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		local_position = true;
		local_rotation = true;
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0.1, 0.12} },
			{ "target_size", 77, 77, 27, 27, 27, 3, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},

-- Spot Glow

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Spark02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "add",
		color = { { "point", .37, .37, .37}, .3, },
		size = { "point", 7, 7, 3, },
		velocity = { "line", 0, 0, 0, 0, 0, 0},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		local_position = true;
		local_rotation = true;
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0.1, 0.12} },
			{ "target_size", 137, 137, 137, 12, 12, 3, },
			{ "target_color",  0, 0, 0, 0, 3, filter = {0.05, 0.2}, },
			{ "kill_old", .2, },
			{ "move", },
		},
	},

-- Spot Smoke

	{
		type = "sprite_view_align_xy",
		texture = "prt_smoke_white04.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .7, .7}, .3, },
		size = { "line", 7, 7, 7, 7, 7, 7,},
		velocity = { "sphere", 0, 0, 0, 300, 500, },
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 5,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, time = {0.1, 0.12} },
			{ "target_size", 77, 77, 77, 7, 7, 7, },
			{ "target_color",  .7, .7, .7, 0, 3},
			{ "damping", -5, -5, -5, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},

-- Shells

	{
		type = "sprite_view_align_xy",
		texture = "pfx_shells_machinegun.tga",
		tex_animation = { 8, 2, 32, },
		flags = { "use_colors", "tex_animation", "use_rotation", },
		fixed_size = { 7, 7, 7, },
		blend_type = "blend",
		color = { { "point", .8, .8, .8, }, 1, },
		velocity = { "point", 100, 500, 500, },
		rotation = { 0, 20, },
		angular_vel = { 170, 21, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", -120, 0, 5, }, time = {0.1, 0.12} },
			{ "gravity", 0, 0, -1500, },
			{ "bounce2", 0.2, 0.5, },
			{ "kill_old", .3, },
			{ "move", },
		},
	},

-- Shells Smoke

	{
		type = "sprite_view_align_xy",
		texture = "prt_smoke_white04.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .7, .7}, .21, },
		size = { "line", 3, 3, 3, 7, 7, 7,},
		velocity = { "point", 0, 0, 0,},
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		source_vel = { .1, .1, },
		max_count = 10,
		colliding = 0,
		actions = {
			{ "source_from_group", 3, 200, time = {0.1, 0.32} },
			{ "target_size", 17, 17, 37, 1, 1, 1, },
			{ "target_color",  .7, .7, .7, 0, 3},
			{ "damping", -5, -5, -5, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},

}

light_desc = {
	range = 250;
	duration = .1;
	color = { .37, .25, .17 };
}

