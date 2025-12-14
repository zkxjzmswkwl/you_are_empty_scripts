partice_system_desc = {
auto_delete = .7,


	-- Blood puffs

	{
		max_count = 3,
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", },
		blend_type = "blend",
		color = { { "point", 0.5, 0, 0, }, 1, },
		size = { "point", 10, 10, 10, },
		velocity = { "sphere", 0, 0, 370, 20, 300},
		rotation = { 0, 360, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 100, { "line", 0, 0, 0, 0,0,20,},time = {0,0.1,} },
			{ "gravity", 0, 0, -120, },
			{ "kill_old", .7, },
			{ "target_size", 70,70,0,0.5,0.5,3, filter = { 0.1, 0.7 },},
			{ "target_color", 0.5, 0, 0,0,7, filter = { 0.3, 0.7 }, },
			{ "damping", -5,-5,-5, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------

	-- Blood drops

	{
		type = "sprite_view_align_xy",
		max_count = 12,
		texture = "PRT_BloodDrop01.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", 0.27, 0, 0, }, 1, },
		size = { "line", .3, .3, .3, 1, 1, 1, },
		velocity = { "sphere", 0, 0, 700, 70, 200,},
		rotation = { 0, 360, },
		angular_vel = { 0, 70, },
		colliding = 0,
		actions = {
			{ "source", 200, { "point", 0, 0, 0,},time = {0,0.05,} },
			{ "gravity", 0, 0, -1000, },
			{ "kill_old", .7, },
			{ "target_color", 0.15, 0, 0,0,1.5, },
			{ "damping", -2,-2,-2, },
			{ "move", },

		},
	},
-------------------------------------------------------------------------------------

}

sound_desc = {
	file_name = { "Player_bullet_take1.wav", "Player_bullet_take2.wav", "Player_bullet_take3.wav", "Player_bullet_take4.wav", "Player_bullet_take5.wav", },
	volume = 0,
	max_distance = 35*64,
}

decal_desc = {
		width = 6,
		depth = 6,
		textures = {"WLM_Blood01.tga", "WLM_Blood02.tga", "WLM_Blood03.tga", }, 
		decal_type = "modulate",
		life_time = 20,
		fade_time = 5,
}