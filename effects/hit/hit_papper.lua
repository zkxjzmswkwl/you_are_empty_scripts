--------------------------------------------------------------------------------------------
--Эфффект при попадании по бумаге
--------------------------------------------------------------------------------------------
partice_system_desc = {
	auto_delete = 2,

	{	-- дымо 1 (g0)
		max_count = 5,
		type = "sprite_view_align_xy",
		texture = "PRT_Droppers_02.tga",
		flags = { "use_colors", "use_size", "use_rotation", },
		blend_type = "blend",
		color = { { "point", .7, .7, .7, }, 1, },
		size = { "point", 5, 5, 5, },
		velocity = { "line", 0, 0, 30, 0, 0, 730, 130, 270},
		rotation = { 0, 330, },
		angular_vel = { 0, 21, },
		colliding = 0,
		actions = {
			{ "source", 340, { "line", 0, 0, 0, 0,0,20,},time = {0,0.05,} },
			{ "gravity", 0, 0, 20, },
			{ "kill_old", 1.95, },
			{ "target_size", 30,30,0,1,1,1, },
			{ "target_color", .37, .33, .21, 0, 2, },
			{ "damping", -4.6,-4.6,-4.6, },
			{ "move", },

		},
	},
}

sound_desc = {
	file_name = { "bullet_hit_shtukaturka1.wav", "bullet_hit_shtukaturka2.wav" ,},
	volume = -0.5,
	max_distance = 35*64,
}

decal_desc = {
		width = 3,
		depth = 4,
		textures = { "WLM_paper1.tga", "WLM_paper2.tga", "WLM_paper3.tga", "WLM_paper4.tga", "WLM_paper5.tga", "WLM_paper6.tga", "WLM_paper7.tga", }, 
		decal_type = "blend",
		life_time = 15,
		fade_time = 2,
}

