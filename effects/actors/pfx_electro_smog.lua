partice_system_desc = {
	auto_delete = 20,

-- group 0 - Spark sphere
-- [[
	{
		type = "sprite_velocity_align",
		texture = "pfx_electro2.tga",
		flags = { "use_colors", "use_size", "use_rotation",},
		blend_type = "add",
		color = { { "point", 1, 1, 1,}, .7, },
		size = { "line", 10, 10, 10,  },
		velocity = { "sphere", 0, 0, 0, 700, 900, },
		rotation = { 180, 0, },
		max_count = 37,
		colliding = 0,
		actions = {
			{ "source", 2000, { "point", 0, 0, 0}, switchable = true, time = { 0, 0.1 },}, 
			{ "damping", -7, -7, -7, },
			{ "target_size", 337, 337, 0, 21, 21, 33, },
			{ "target_color", 0,0,0,0, 17, },
			{ "kill_old", .2, },
			{ "move", },
		},
	},
--]]
------------------------------------------------------------
-- group 1 - Dark center
-- [[
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
			{ "source", 70, { "point", 1, 0, 0}, switchable = true, time = { 0, 0.3 },},
			{ "target_size", 73, 73, 0, 21, 21, 21, },
			{ "target_color", 0,0,0,0,17, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},

--]]

group 2 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White03.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "add",
		color = { { "line", .05, .05, .07, .07, .07, 0.1}, .7, },
		size = { "point", 57, 75, 7, },
		velocity = { "sphere", 0, 0, 10, 300, 700},
		rotation = { 0, 180, },
		angular_vel = { 0, 21, },
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source", 200, { "sphere", 0, 0, 0, 10, 150}, time = {.2, .7}, },
			{ "target_velocity", 0, 0, 20, .3},
			{ "damping", -3, -3, -3, },
			{ "target_size", 337,337,0,.3,.3,.3, },
			{ "target_color", 0, 0, 0, 0, 2, filter = {3, 5}, },
			{ "kill_old", 5, },
			{ "move", },
		},
	},

}

sound_desc = {
	file_name = { "fireball_expl1.wav", "fireball_expl2.wav" },
	volume = -0.5,
	max_distance = 100*64,
}

