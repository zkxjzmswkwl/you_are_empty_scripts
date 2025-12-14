partice_system_desc = {

-- group 1 - Steam Fill
--
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation", "use_velocity_scale" },
		blend_type = "blend",
		color = { { "point", .5, .5, .5}, .5, },
		size = { "point", 37, 37, 37, },
		fixed_velocity_scale = { 100, 1 },
		velocity = { "line", 0, 0, 10, 0, 0, 30},
		rotation = { 0, 180, },
		angular_vel = { 0, 3, },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "source", 3, { "box", -105, -170, 0, 105, 170, 10, },  switchable = true, },
			{ "target_velocity", 0, 0, 5, .3},
			{ "target_size", 300, 300, 0, .25, .25, .25, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 10, },
			{ "move", },
		},
	},
--]]

}


