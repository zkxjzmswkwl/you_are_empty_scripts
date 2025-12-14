partice_system_desc = {
	auto_delete = 5,

-- group 0 - Spark sphere
--[[
	{
		type = "sprite_axis_align_xy",
		texture = "pfx_electro1.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "add",
		color = { { "point", 1, 1, 1,}, .7, },
		size = { "line", 10, 10, 10,  },
		velocity = { "sphere", 0, 0, 0, 100, 200,},
		rotation = { 0, 180, },
		angular_vel = { 0, 121, },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "source", 20, { "point", 0, 0, 0}, switchable = true, },
			{ "target_size", 7,7,0,12,12,33, },
			{ "target_color", 0,0,0,0,7, },
			{ "kill_old", .2, },
			{ "move", },
		},
	},
--]]
------------------------------------------------------------
-- group 1 - Dark center
	{
		type = "sprite_axis_align_xy",
		texture = "pfx_electro1.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "add",
		color = { { "point", 1, 1, 1,}, .7, },
		size = { "line", 10, 10, 10, 10, 10, 10},
		velocity = { "point", 0, 0, 0, },
		rotation = { 0, 180, },
		angular_vel = { 0, 121, },
		max_count = 5,
		colliding = 0,
		actions = {
			{ "source", 70, { "point", 1, 0, 0}, switchable = true, },
			{ "target_size", 73,73,0,12,12,12, },
			{ "target_color", 0,0,0,0,17, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},
}


sound_desc = {
	file_name = { "Electrik_fireball.wav", },
	volume = -0.5,
	loop = true,
	max_distance = 50*64,
}

