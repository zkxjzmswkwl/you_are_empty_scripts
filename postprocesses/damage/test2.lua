--------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от выстрелов (TEST)
--------------------------------------------------------------------

postprocesses["damage_TEST_1"] =
{
	material_template = "damage_test",
	time = 2000,

	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		filter_r	= { points = { {0, 1} } },
		filter_g	= { points = { {0, 1} } },
		filter_b	= { points = { {0, 1} } },
		Offset = { points = { {0, 5},  {2, 0}, } },
		Kernel = { points = { {0, 0},  {0, 0}, } },
		Intensivity = { points = { {0, 1},  {2, 0}, } },
		Contrast = { points = { {0, 1},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_2"] =
{
	material_template = "damage_test",
	time = 3000,

	properties = 
	{
		filter_r	= { points = { {0, 1} } },
		filter_g	= { points = { {0, 1} } },
		filter_b	= { points = { {0, 1} } },
		Offset = { points = { {0, 5},  {2, 0}, } },
		Kernel = { points = { {0, 0},  {0, 0}, } },
		Intensivity = { points = { {0, 1},  {2, 0}, } },
		Contrast = { points = { {0, 1},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_3"] =
{
	material_template = "damage_test",
	time = 5000,

	properties = 
	{
		filter_r	= { points = { {0, 1} } },
		filter_g	= { points = { {0, 1} } },
		filter_b	= { points = { {0, 1} } },
		Offset = { points = { {0, 5},  {2, 0}, } },
		Kernel = { points = { {0, 0},  {0, 0}, } },
		Intensivity = { points = { {0, 1},  {2, 0}, } },
		Contrast = { points = { {0, 1},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_4"] =
{
	material_template = "damage_test",
	time = 5000,

	properties = 
	{
		filter_r	= { points = { {0, 1} } },
		filter_g	= { points = { {0, 1} } },
		filter_b	= { points = { {0, 1} } },
		Offset = { points = { {0, 5},  {2, 0}, } },
		Kernel = { points = { {0, 0},  {0, 0}, } },
		Intensivity = { points = { {0, 0.1},  {2, 0}, } },
--		Contrast = { points = { {0, 1},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_5"] =
{
	material_template = "damage_test",
	time = 5000,

	properties = 
	{
		filter_r	= { points = { {0, 1} } },
		filter_g	= { points = { {0, 1} } },
		filter_b	= { points = { {0, 1} } },
		Offset = { points = { {0, 5},  {2, 0}, } },
		Kernel = { points = { {0, 0},  {0, 0}, } },
		Intensivity = { points = { {0, 0.1},  {2, 0}, } },
--		Contrast = { points = { {0, 1},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_6"] =
{
	material_template = "damage_test",
	time = 5000,

	properties = 
	{
		filter_r	= { points = { {0, 1} } },
		filter_g	= { points = { {0, 1} } },
		filter_b	= { points = { {0, 1} } },
		Offset = { points = { {0, 5},  {2, 0}, } },
		Kernel = { points = { {0, 0},  {0, 0}, } },
		Intensivity = { points = { {0, 0.1},  {2, 0}, } },
--		Contrast = { points = { {0, 1},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_7"] =
{
	material_template = "damage_test",
	time = 5000,

	properties = 
	{
		filter_r	= { points = { {0, 1} } },
		filter_g	= { points = { {0, 1} } },
		filter_b	= { points = { {0, 1} } },
		Kernel = { points = { {0, 5},  {2, 0}, } },
		Intensivity = { points = { {0, 0},  {0, 0}, } },
		Offset = { points = { {0, 1},  {2, 0}, } },
--		Contrast = { points = { {0, 1},  {2, 0}, } },
	},
}
