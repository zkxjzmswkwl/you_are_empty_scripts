partice_system_desc = {
auto_delete = .1,
custom_render = { 45, 0.2, 0.21 };	-- FOV, minZ, maxZ

-- Spot

-- [[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "line", 80, 80, 3, 57, 57, 3},
		velocity = { "line", 0, 0, 0, 0, 0, 0},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		local_position = true;
		local_rotation = true;
		actions = {
			{ "source", 2000, { "point", -70, 0, 0}, time = {0, 0.05} },
			{ "target_size", 50, 50, 17, 17, 17, 3, },
			{ "kill_old", .07, },
			{ "set_position", { "point", -70, 0, 0} },
			{ "move", },
		},
	},
--]]


-- Shells

	{
		type = "sprite_view_align_xy",
		texture = "pfx_shells_machinegun.tga",
		tex_animation = { 8, 2, 32, },
		flags = { "use_colors", "tex_animation", "use_rotation", },
		fixed_size = { 5, 5, 5, },
		blend_type = "blend",
		color = { { "point", .8, .8, .8, }, 1, },
		velocity = { "point", -10, 150, 350, },
		rotation = { 0, 20, },
		angular_vel = { 170, 21, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", -130, -5, 10, }, time = {0, 0.5} },
			{ "gravity", 0, 0, -1500, },
			{ "bounce2", 0.2, 0.5, },
			{ "kill_old", .7, },
			{ "move", },
		},
	},



}

light_desc = {
	range = 250;
	duration = .09;
	color = { .37, .25, .17 };
}

