partice_system_desc = {
	auto_delete = 5,

------------------------------------------------------------
-- group 0 - Spit trail
	{
		type = "sprite_axis_align_xy",
		texture = "pfx_goo1.tga",
		flags = { "use_colors", "use_size", "use_rotation", "tex_animation", },
		tex_animation = { 2, 2, 0, },
		blend_type = "modulate",
		tex_env = "add",
		color = { { "point", 0, 0, 0,}, .7, },
		size = { "line", 15, 15, 15, 10, 10, 10},
		velocity = { "sphere", 0, 0, 100, 200, 300, },
		rotation = { 0, 180, },
--		starting_age = { 0, 2 },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "damping", -1, -1, -1, },
			{ "gravity", 0, 0, -1000, },
			{ "bounce2", 0.1, 0.1,},
			{ "source", 100, { "point", 0, 0, 0}, switchable = true, }, 
			{ "target_size", 20, 20, 0, 3, 3, 3, },
			{ "target_color", 1,1,1,0,3, },
			{ "kill_old", .5, },
			{ "move", },
		},
	},
}

