partice_system_desc = {
	auto_delete = 1.8,

-- group 0 - Flame Strip

--
	{
		type = "sprite_velocity_align",
		texture = "pfx_flamethrower1b.tga",
		flags = { "use_colors", "use_size", "tex_animation", },
		tex_animation = { 8, 1, 24 },
		blend_type = "add",
		color = { { "point", .5, .33, .21}, 1, },
		size = { "point", 173, 17, 7, },
		velocity = { "point", 1, 0, 0},
		max_count = 30,
		colliding = 0,
		local_position = true,
		actions = {
			{ "source", 70, { "point", 0, 0, 0, }, switchable = true, },
			{ "target_color", 0, 0, 0, 17, },
			{ "kill_old", .03, },
			{ "move", },
		},
	},
--]]

-- group 1 - Flame

--
	{
		type = "sprite_view_align_xy",
		texture = "pfx_flamethrower1.tga",
		flags = { "use_colors", "use_size", "tex_animation" },
		tex_animation = { 8, 8, 24 },
		blend_type = "add",
		color = { { "point", 1, 1, 1}, 1, },
		size = { "line", 7, 7, 5, 17, 17, 17, },
		velocity = { "cone", 1000, 0, 0, 1200, 0, 0, 0, 200},
		rotation = { 0, 0, },
		max_count = 37,
		colliding = 1,
		actions = {
			{ "source", 21, { "point", 0, 0, 0, }, switchable = true, },
			{ "damping", -2, -2, -2, },
			{ "bounce2", 0, 0, },
			{ "gravity", 0, 0, 200, },
			{ "target_size", 77,77,0,3,3,3, },
			{ "target_color", 0.2,0.2,0.2,0,3, filter = {0, 2,}, },
			{ "kill_old", 1.8, },
			{ "move", },
		},
	},
--]]


}

sound_desc = {
	file_name = { "fl_stream.wav" },
	volume = -0.5,
	max_distance = 150*64,
	loop = true,
}