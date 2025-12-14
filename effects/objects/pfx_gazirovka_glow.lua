partice_system_desc = {

-- group 0 - yellow glow
-- [[

	{
		type = "sprite_view_align_xy",
		texture = "prt_spark01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "point", .037, .033, .027}, .27, },
		color = { { "point", .1, .081, .073}, .27, },
		size = { "point", 93, 49, 5,},
		velocity = { "point", 0, 0, 0},
		rotation = { 0, 0, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 1000, { "point", 0, 0, 0, }, switchable = true, },
			{ "kill_old", 0.01 },
			{ "move", },
		},
	},
--]]

}

sound_desc = {
	file_name = { "neon_noice.wav", },
	volume = -0.7,
	loop	= true,
	max_distance = 7*64,
}

