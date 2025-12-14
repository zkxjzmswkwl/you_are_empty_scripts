partice_system_desc = {
auto_delete = .1,

-- group 0 - Spot

-- [[
	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark02.tga",
		flags = { "use_colors", "use_size", "use_rotation", "use_tm", },
		blend_type = "add",
		color = { { "point", .5, .45, .39}, 1, },
		size = { "line", 21, 21, 3, 27, 27, 3},
		velocity = { "point", 0, 0, 0,},
		rotation = { 0, 180, },
		max_count = 1,
		colliding = 0,
		local_position = true;
		local_rotation = true;
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, },
			{ "target_size", 5, 5, 3, 17, 17, 3, },
--			{ "target_color", 0, 0, 0, 0, .3,},
--			{ "kill_old", .07, },
			{ "set_position", { "point", 0, 0, 0} },
			{ "move", },
		},
	},
--]]


}

light_desc = {
	range = 250;
	duration = .09;
	color = { .37, .25, .17 };
}

