partice_system_desc = {
auto_delete = 1,

-- Group 0 - Dust
	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .77, .63, .57, .93, .83, .73}, .81, },
		size = { "line", 7, 7, 7, 17, 17, 17, },
		velocity = { "point", 0, 0, 0, 0, 0, },
		rotation = { 0, 180, },
		angular_vel = { 0, 7, },
		max_count = 1,
		colliding = 0,
		actions = {
			{ "source", 5000, { "sphere", 0, 0, 0, 5, 20}, time = {0, 0.1}, },
--			{ "target_velocity", 0, 0, 50, 1},
			{ "target_size", 37,37,0,2,2,.3, },
			{ "target_color", .5, .5, .5, 0, 1,  },
			{ "kill_old", 1, },
			{ "move", },
		},
	},
}
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--[[
sound_desc = {
	file_name = { "body_main_0.wav", "body_main_1.wav", "body_main_2.wav", "body_main_3.wav", "body_main_4.wav", "body_main_5.wav", "body_main_6.wav", "body_main_7.wav", "body_main_8.wav", "body_main_9.wav", },
	volume = -0.9,
	min_distance = 5*64,
	max_distance = 15*64,
}
--]]

