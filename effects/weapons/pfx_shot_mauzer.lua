partice_system_desc = {
auto_delete = .1,
--custom_render = { 65, 0.2, 0.21 };	-- FOV, minZ, maxZ

-- group 0 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, 1, },
		size = { "point", 73, 73, 3, },
		velocity = { "line", 0, 0, 0, 0, 0, 0},
		rotation = { -180, 180, },
		max_count = 1,
		colliding = 0,
		local_position = true;
		local_rotation = true;
		actions = {
			{ "source", 2000, { "point", -30, 0, 0}, time = {0.08, 0.1} },
			{ "target_size", 17, 17, 17, 17, 17, 3, },
			{ "kill_old", .1, },
			{ "set_position", { "point", 0, 0, 0} },
			{ "move", },
		},
	},

-- group 1 - Spot

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .1, .1, .1}, 1, },
		size = { "point", 3, 3, 3, },
		velocity = { "line", 0, 0, 0, 1000, -10, -10},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", -90, 5, -25}, time = {0.08, 0.1} },
			{ "target_size", 27, 27, .3, 1, 1, 3, },
			{ "target_color", 0, 0, 0, 2.5, 2.5, 2.5, 0, },
			{ "target_velocity", 0, 0, 5, 7, 7, 7, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},

-- Shells

	{
		type = "sprite_view_align_xy",
		texture = "pfx_shells_pistol.tga",
		tex_animation = { 8, 2, 32, },
		flags = { "use_colors", "tex_animation", "use_rotation", },
		fixed_size = { 7, 7, 7, },
		blend_type = "blend",
		color = { { "point", .8, .8, .8, }, 1, },
		velocity = { "point", 100, 300, 300, },
		rotation = { 0, 20, },
		angular_vel = { 170, 21, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", -70, 0, 5, }, time = {0, 0.05} },
			{ "gravity", 0, 0, -1500, },
			{ "bounce2", 0.2, 0.5, },
			{ "kill_old", .3, },
			{ "move", },
		},
	},


}

light_desc = {
	range = 250;
	duration = .1;
	color = { .37, .25, .17 };
}

