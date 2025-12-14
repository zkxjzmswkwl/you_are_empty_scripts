partice_system_desc = {

-- group 0 - Dust

	{
		type = "sprite_view_align_xy",
		texture = "PRT_Smoke_White04.tga",
		flags = { "use_colors", "use_size", "use_rotation" },
		blend_type = "blend",
		color = { { "line", .12, .15, .04, .28, .18, .06}, .6, }, --gradient COLORA
		size = { "point", 7, 7, 7, },           -- nachalni razmer
		velocity = { "blob", 0, 0, 150, 20.0, }; -- nachalnaia skorost
		rotation = { 0, 90, },           -- nachalni ugol povorota
		angular_vel = { 0, 45, },    --skorost vrasheniya
		max_count = 30,                 -- max kolichestvo partiklov v grupr
		colliding = 0,
		actions = {
			{ "source", 20, { "point", 0, 0, 0}, switchable = true, },-- kolichestvo rojdaemih chastic
			{ "target_size",180, 180, 0, .5, .5, .5, },-- konechni SIZE
			{ "target_color", 0.1,0.1,0.1,0.0,2, filter = {1, 2}, }, -- cvet jizni
                       	{ "kill_old", 3, },    -- vremia jizni
                        { "target_angular_velocity", 10, 1/5, },-- Konechnaia skorost vrashenia
                        { "damping", 0.9, 0.9, 0.9 };
			{ "move", },
                        
		},

	},


}
sound_desc = {
	volume = 0;
	max_distance = 15*64;
	loop = true;
	file_name = {
		"Soplo1.wav",
	};
}
light_desc = {
	range = 150;
	duration = 0;
	color = { 0.9, 0.3, 0.1 };
}