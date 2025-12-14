partice_system_desc = {
auto_delete = 1,
custom_render = { 45, 0.2, 0.21 };	-- FOV, minZ, maxZ

--------------------------------------------------------
-- group 0 - Spot

-- [[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, 1, },
		size = { "line", 20, 20, 3, 37, 37, 3},
		velocity = { "line", 0, 0, 0, 0, 0, 0},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		local_position = true;
		local_rotation = true;
		actions = {
			{ "source", 2000, { "point", -70, 0, 0}, time = {0, 0.05} },
			{ "target_size", 17, 17, 17, 17, 17, 3, },
			{ "kill_old", .07, },
			{ "move", },
		},
	},
--]]

--------------------------------------------------------
-- group 1 - Smoke
	{
		max_count = 3,
		type = "sprite_view_align_xy",
		texture = "prt_smoke_white01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .7, .7, }, .7, },
		size = { "point", 8, 8, 8, },
		velocity = { "line", 0, 0, 30, 0, 0, 730},
		rotation = { -330, 330, },
		angular_vel = { -50, 50, },
		colliding = 0,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,}, time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "kill_old", 1, },
			{ "target_size", 70,70,0,1,1,1, },
			{ "target_color", .37, .37, .37,0,3, filter = {.3, 1}, },
			{ "damping", -7,-7,-7, },
			{ "move", },

		},
	},

}
--------------------------------------------------------
--------------------------------------------------------

light_desc = {
	range = 350;
	duration = .09;
	color = { .37, .25, .17 };
}

