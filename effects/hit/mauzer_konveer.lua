partice_system_desc = {
	auto_delete = 5,
-------------------------------------------------------------------------------------
-- group 0 - Smoke
	{
		max_count = 3,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_Black04.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "add",
		color = { { "point", 0.9, 0.9, 0.7, }, 0.9, },
		size = { "point", 4, 4, 8, },
		velocity = { "line", 0, 0, 30, 0, 0, 730},
		rotation = { -330, 330, },
		angular_vel = { 0, 50, },
		colliding = 0,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,}, time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "kill_old", 5, },
			{ "target_size", 70,70,0,1,1,1, },
			{ "target_color", 0, 0, 0, 1, 2.1, },
			{ "damping", -7,-7,-7, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
-- group 1 - Sparks

	{
		type = "sprite_view_align_xy",
		texture = "PRT_spark03.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 3, 3, 3, },
		velocity = { "point", 0, 0, 0},
		rotation = { -180, 180, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 5, { "point", 5, 0, 0}, time = {0, 0.1} },
			{ "target_size", 17, 17, 17, 17, 17, 3, },
			{ "target_color", 0, 0, 0, 17, },
			{ "kill_old", .1, },
			{ "move", },
		},
	},

-------------------------------------------------------------------------------------
-- group 2 - Sparks

	{
		type = "sprite_velocity_align",
		texture = "PRT_spark02.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, 0, 250, 100, 300},
		fixed_velocity_scale = { .09, .001 },
		max_count = 3,
		colliding = 0,
		actions = {
			{ "source_from_group", 1, 2000, time = {0, 0.2} },
--			{ "source", 2000, { "point", 5, 0, 0}, time = {0, 0.2} },
--			{ "damping", -7, -7, -7},
			{ "kill_old", .1, },
			{ "move", },
		},
	},

-------------------------------------------------------------------------------------

	{	-- Ошметки материи 3
		max_count = 7,
		type = "sprite_view_align_xy",
		texture = "PRT_Derbis02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .5, .5, .5, }, 1, },
		size = { "line", 0.5, 0.5, 30, 5, 5, 60},  --rendom Razmera
		velocity = { "blob", 0, 0, 500, 70, },
--		starting_age = { 1, 0.5, },
		rotation = { 0, 360, },
		angular_vel = { 0, 200, },
		colliding = 0,          -- procenti koligena
		actions = {
			{ "source", 700, { "point", 5, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -3500, },
			{ "bounce2", 0.9, 0.3, },
			{ "kill_old", 1, },
                        { "target_color", 0, 0, 0, 1, 1.9, },
			{ "target_size", 5,5,5,0.5,0.5,1, },
			{ "target_angular_velocity", 0, 3, },
			{ "damping", -2.6,-2.6,-2.6, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
}

sound_desc = {
	file_name = { "bullet_hit_shtukaturka0.wav", "bullet_hit_shtukaturka1.wav", "bullet_hit_shtukaturka2.wav", "bullet_hit_shtukaturka3.wav", },
	volume = -0.5,
	max_distance = 35*64,
}
