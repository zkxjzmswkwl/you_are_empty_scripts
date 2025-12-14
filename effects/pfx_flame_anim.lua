partice_system_desc = {



	{
		type = "sprite_velocity_align",
--		type = "sprite_view_align_xy",
		texture = "pfx_flamethrower3.tga",
		tex_animation = { 8, 8, 32, },
		flags = { "use_colors", "tex_animation", },
		fixed_size = { 100, 30, 100, },
		blend_type = "add",
		color = { { "point", 1, 1, 1, }, 0.1},
		velocity = { "point", 0, 0, -0.1, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 100, { "point", 0, 0, 0, }, },
			{ "gravity", 0, 0, 0, },
			{ "bounce2", 0.2, 0.5, },
--			{ "kill_old", .7, },
			{ "move", },
		},
	},



}

light_desc = {
	range = 250;
	duration = .09;
	color = { .37, .25, .17 };
}

