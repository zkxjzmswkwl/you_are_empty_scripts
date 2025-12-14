partice_system_desc = {
	auto_delete = 1,

-- Shells
	{
		type = "sprite_view_align_xy",
		texture = "pfx_shells_machinegun.tga",
		tex_animation = { 8, 2, 32, },
		flags = { "use_colors", "tex_animation", },
		fixed_size = { 15, 15, 15, },
		blend_type = "blend",
		color = { { "point", 1, 1, 1, }, 1, },
		velocity = { "point", 0, 0, 250, },
		rotation = { 0, 20, },
		angulat_vel = { 70, 21, },
		colliding = 1,
		actions = {
			{ "source", 100, { "point", 0, 0, 100, }, },
			{ "gravity", 0, 0, -1500, },
			{ "bounce2", 0.2, 0.5, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},

}