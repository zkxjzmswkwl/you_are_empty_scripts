partice_system_desc = {
--	auto_delete = 1.8,

-- group 0 - Nozzle

--
	{
		type = "sprite_velocity_align",
		texture = "pfx_flamethrower1b.tga",
		flags = { "use_colors", "use_size", "tex_animation", },
		tex_animation = { 8, 1, 24 },
		blend_type = "add",
		color = { { "point", .3, .3, 1}, 1, },
		size = { "point", 77, 7, 7, },
		velocity = { "point", 1, 0, 0},
		max_count = 30,
		colliding = 0,
		local_position = true,
		actions = {
			{ "source", 37, { "point", 0, 0, 0, }, switchable = true, },
			{ "kill_old", .02, },
			{ "move", },
		},
	},
--]]


}

sound_desc = {
	file_name = { "fl_fire.wav", "fl_blow.wav", },
	volume = -0.5,
	max_distance = 10*64,
	loop = true,
	channel = "effect_shoot",
}