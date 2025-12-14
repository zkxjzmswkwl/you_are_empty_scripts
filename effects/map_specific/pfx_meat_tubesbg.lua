partice_system_desc = {

-- group 0 - Smoke

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_white04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .49, .49, .49, .33, .33, .33,}, .5, },
		size = { "line", 207, 207, 5, 307,307, 17, },
--		size = { "line", 307, 307, 5, 570, 570, 17, },
		velocity = { "point", 0, 0, 200},
		rotation = { 0, 180, },
		angular_vel = { 0, 3, },
		max_count = 20,
		colliding = 0,
		actions = {
			{ "source", .7, { "point", 0, 0, 0, }, switchable = true,},
			{ "target_velocity", -200, 0, 100, .3, filter = { 7, 10}, },
			{ "target_size", 570,570,0,.05,.05,1, filter = { 7, 10}, },
			{ "target_color", .39,.39,.39,0, .1, filter = { 15, 20}, },
--			{ "vortex", 0, 0, 0, 0, 0, 1, 500000, },
			{ "kill_old", 20, },
			{ "move", },
		},
	},

}