light_desc = {
	range = 100;
	duration = 0;
	color = { 0.5, 0.5, 0.5 };
}

sound_desc = {
	volume = 0;
	max_distance = 15*64;
	loop = true;
	file_name = {
		"motor_a8.wav",
	};
}
--
partice_system_desc = {
--	auto_delete = 5,
	{	-- group0
		max_count = 1500;
		type = "sprite_view_align_xy";
--		type = "lines_view_align";
		texture = "PRT_Smoke_White01.tga";
--		tex_animation = { 8, 4, 32, };
--		flags = {};
		flags = { "use_colors", "use_size", };
--		fixed_size = { 5, 15, 15, };
		blend_type = "add";
--		alpha_test_type = "greater";
--		alpha_test_ref = 0;
		color = { { "point", 1, 1, 1, }, 1, };
		size = { "point", 3, 3, 3, };
		velocity = { "blob", 10, 0, 100, 10.0, };
		starting_age = { 1, 1, };
--		rotation = { 0, 120, };
--		angular_vel = { 0, 1200, };
		source_vel = { 0, 0, };
		colliding = 1;
--		sorted = true;
--		local_rotation = true;
--		local_position = true;
		actions = {
			{ "source", 50, { "point", 0, 0, 0 }, switchable = true };
			{ "gravity", 0, 0, -60 };
			{ "bounce2", 0.1, 0.3 };
			{ "vortex", 0, 0, 60, 0, 0, 1, 20000, local_position = true, local_rotation = true };
--			{ "orbit_line", 0, 0, 0, 0, 0, 1, 500000 };
			{ "kill_old", 5 };
--			{ "kill_old", 0, filter = { 0, 10, true } },
			{ "target_size", 3, 3, 0, 0.5, 0.5, 1 };
			{ "target_color", 1, 1, 1, 0, 20 };
--			{ "damping", 0.9, 0.9, 0.9 };
			{ "move" };
		};
	};
}
--[[
decal_desc = {
		width = 3,
		depth = 4,
		textures = {"WLM_WallBullet_Stone.tga",}, 
		decal_type = "modulate",
		life_time = 10,
		fade_time = 2,
}
--]]
--]]