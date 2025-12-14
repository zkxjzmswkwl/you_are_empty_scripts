partice_system_desc = {
auto_delete = 1.5,

	{	
		max_count = 15,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "blend",
		color = { { "point", 0.7, 0, 0, }, 1, },
		size = { "point", 10, 10, 10, },
		velocity = { "sphere", 0, 0, 370, 20, 300},
		rotation = { 0, 360, },
		angular_vel = { 100, 1, },
		colliding = 0,
		actions = {
			{ "source", 100, { "line", 0, 0, 0, 0,0,20,},time = {0,0.1,} },
			{ "gravity", 0, 0, -250, },
			{ "kill_old", .7, },
			{ "target_size", 70,70,0,0.5,0.5,3, filter = { 0.1, 0.7 },},
			{ "target_color", 0.5, 0, 0,0,7, filter = { 0.3, 0.7 }, },
			{ "damping", -5,-5,-5, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------
	{	
		type = "sprite_view_align_xy",
		max_count = 12,
		texture = "PRT_BloodDrop01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.7, 0, 0, }, 1, },
		size = { "line", 3, 3, 3, 5, 5, 5, },
		velocity = { "sphere", 0, 0, 700, 70, 200,},
		rotation = { 0, 360, },
		angular_vel = { 320, 200, },
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 0, 0, 0,},time = {0,0.5,} },
			{ "bounce2", 0, 0.3, },
			{ "gravity", 0, 0, -2000, },
			{ "kill_old", 1, },
			{ "target_color", 0.3, 0, 0,0,1.5, },
			{ "damping", -2,-2,-2, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------

}

sound_desc = {
	file_name = { "Rat_explosion1.wav", "Rat_explosion2.wav", },
	volume = 0,
	max_distance = 35*64,
	
}