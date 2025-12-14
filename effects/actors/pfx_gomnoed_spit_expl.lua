partice_system_desc = {
	auto_delete = 7,

-- group 0 - Spit splash
-- [[

	{
		type = "sprite_axis_align_xy",
		texture = "pfx_goo1.tga",
		flags = { "use_colors", "use_size", "use_rotation", "tex_animation", },
		tex_animation = { 2, 2, 0, },
		blend_type = "modulate",
		tex_env = "add",
		color = { { "point", 0, 0, 0,}, .7, },
		size = { "line", 5, 5, 5, 10, 10, 10},
		velocity = { "sphere", 0, 0, 100, 300, 500, },
		rotation = { 0, 180, },
--		starting_age = { 0, 2 },
		max_count = 17,
		colliding = 1,
		actions = {
			{ "damping", -1, -1, -1, },
			{ "gravity", 0, 0, -1000, },
			{ "bounce2", 0.1, 0.1,},
			{ "source", 1000, { "sphere", 0, 0, 0, 0, 50}, switchable = true, time = {0, 0.1}, }, 
			{ "target_size", 10, 10, 0, 3, 3, 3, },
			{ "target_color", 1,1,1,0,3, filter = {.5, 5}, },
			{ "kill_old", 5, },
			{ "move", },
		},
	},
--]]
-- group 1 - Spit Puff
-- [[

	{
		type = "sprite_axis_align_xy",
		texture = "PRT_Droppers.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.47, 0.43, 0.35}, 1, },
		size = { "line", 20, 20, 10, 30, 30, 10},
		velocity = { "sphere", 0, 0, 30, 50, 100},
		rotation = { 0, 180, },
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 3000, { "point", 0, 0, 0}, switchable = true, time = {0, 0.1}, },
			{ "damping", -1, -1, -1,},
			{ "target_size", 100, 100, 0, 7, 7, 33, },
			{ "target_color", 0, 0, 0, 0, 3, filter = {.2, 5}, },
			{ "kill_old", 1, },
			{ "move", },
		},
	},
--]]
-- group 0 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_black05.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "modulate",
		tex_env = "add",
		color = { { "point", 0.47, 0.43, 0.35}, 1, },
		size = { "point", 15, 15, 15, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "sphere", 0, 0, 0, 0, 50},
		rotation = { 0, 180, },
		angular_vel = { 0, 49, },
		max_count = 70,
		colliding = 0,
		actions = {
			{ "source", 12, { "point", 0, 0, 0}, switchable = true, time = {0, 5}, },
			{ "target_velocity", 0, 0, 70, 3},
			{ "target_size", 70, 70, 0, 1, 1, .3, },
			{ "target_color", 1,1,1,0,2, filter = {5, 7}, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 1.75, },
			{ "move", },
		},
	},


}

decal_desc = {
		width = 70,
		depth = 40,
		textures = {"pfx_goo2.tga", "pfx_goo3.tga", }, 
		decal_type = "modulate",
		life_time = 11,
		fade_time = 3,
}

sound_desc = {
	file_name = { "Gomnoed_explosion1.wav", "Gomnoed_explosion2.wav", },
	volume = -0.5,
	max_distance = 50*64,
}
