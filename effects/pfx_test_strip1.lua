partice_system_desc = {
--	auto_delete = 5,

-- group 0 - strip
	{
		max_count = 1500;
--		type = "sprite_axis_aling_xy";
		type = "strip_view_align";
		texture = "prt_spark02.tga";
		flags = { "use_fixed_color", };
		blend_type = "add";
		fixed_color = { 1, 1, 1, 1, };
		fixed_size = { 30, 1/3064, 1, };
--		size = { "point", 70, 70, 3, };
		velocity = { "sphere", 0, 200, 1000, 100, 300, };
		starting_age = { 0, 0, };
		source_vel = { 0, 0, };
		colliding = 0;
		sorted = true;
		actions = {
			{ "source", 100, { "point", 0, 0, 0 }, switchable = true };
			{ "gravity", 0, 0, -100 };
			{ "bounce2", 0.2, 1 };
--			{ "kill_old", 1 };
			{ "move" };
		};
	};
}
