partice_system_desc = {

-- group 0 - Dust

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White01.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .37, .37, .37, .63, .63, .63}, .7, }, --gradient COLORA
		size = { "point", 7, 7, 7, },           -- nachalni razmer
--		size = { "line", 307, 307, 5, 570, 570, 17, }, 
		velocity = { "point", 0, 0, 100}, -- nachalnaia skorost
		rotation = { 0, 180, },           -- nachalni ugol povorota
		angular_vel = { 0, -180, },    --skorost vrasheniya
		max_count = 30,                 -- max kolichestvo partiklov v grupr
		colliding = 0,
		actions = {
			{ "source", 5, { "point", 0, 0, 0}, switchable = true, },-- kolichestvo rojdaemih chastic
			{ "target_velocity", 0, 0, 10, .3},-- Konechnaia skorost
			{ "target_size", 70, 70, 0, .5, .5, .5, },-- konechni SIZE
			{ "target_color", 0.9,0.9,0.9,0,5, filter = {1, 5}, }, -- cvet jizni
			{ "kill_old", 5, },    -- vremia jizni 
			{ "move", },
		},
	},

}

