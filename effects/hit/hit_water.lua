partice_system_desc = {
	auto_delete = .5,
-------------------------------------------------------------------------------------
-- group 0 - Steam
	{
		max_count = 3,
		type = "sprite_view_align_xy",
		texture = "prt_smoke_white01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .7, .7, }, .7, },
		size = { "point", 8, 8, 8, },
		velocity = { "line", 0, 0, 30, 0, 0, 730},
		rotation = { 0, 330, },
		angular_vel = { 0, 50, },
		colliding = .5,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,}, time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "kill_old", .5, },
			{ "target_size", 70,70,0,1,1,1, },
			{ "target_color", .37, .37, .37,0,3, filter = {.3, 1}, },
			{ "damping", -7,-7,-7, },
			{ "move", },

		},
	},

-------------------------------------------------------------------------------------
-- group 0 - Kapli Vertikalnie
-- [[
	{
		type = "sprite_velocity_align",
		texture = "PRT_spark01.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .5, .5, .5}, .1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, 0, 1300, 0, 150},
		fixed_velocity_scale = { .05, .001 },
		max_count = 15,
		colliding = .5,
		actions = {
			{ "source", 200, { "point", 5, 0, 0}, time = {0, 0.2} },
			{ "damping", -5, -5, -5},
			{ "bounce2", 0, 1, },
			{ "gravity", 0, 0, -2000},
			{ "kill_old", .5, },
			{ "move", },
		},
	},
-- ]] 
-------------------------------------------------------------------------------------

-- group 0 - Kapli Gorizontalnie

	{
		type = "sprite_velocity_align",
		texture = "PRT_spark01.tga",
		flags = { "use_colors", "use_size", "use_velocity_scale"},
		blend_type = "add",
		color = { { "point", .5, .5, .5}, 1, },
		size = { "point", 1, .5, 17, },
		velocity = { "sphere", 0, 0, 0, 1500, 100, },
		fixed_velocity_scale = { .05, .001 },
		max_count = 20,
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 5, 0, 0}, time = {0, 0.2} },
			{ "damping", -5, -5, -5},
			{ "bounce2", 0, 1, },
			{ "gravity", 0, 0, -2000},
			{ "kill_old", .7, },
			{ "move", },
		},
	},
	
-------------------------------------------------------------------------------------


}

sound_desc = {
	file_name = { "bullet_hit_voda0.wav", "bullet_hit_voda1.wav", "bullet_hit_voda2.wav", "bullet_hit_voda3.wav", },
	volume = -0.5,
	max_distance = 35*64,
}
