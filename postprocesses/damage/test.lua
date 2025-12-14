--------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от выстрелов (TEST)
--------------------------------------------------------------------
postprocesses["damage_TEST_1"] =
{
	material_template = "damage_TEST",
	time = 100,

	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		color_r	= { points = { {0, .15},  {1, 1} } },
		color_g	= { points = { {0, .15}, {1, 1} } },
		color_b	= { points = { {0, .9},  {1, 1} } },
	},
}

postprocesses["damage_TEST_2"] =
{
	material_template = "damage_TEST",
	time = 100,

	properties = 
	{
		color_r	= { points = { {0, .15},  {1, 1} } },
		color_g	= { points = { {0, .15}, {1, 1} } },
		color_b	= { points = { {0, .9},  {1, 1} } },
	},
}

postprocesses["damage_TEST_3"] =
{
	material_template = "damage_TEST",
	time = 100,

	properties = 
	{
		color_r	= { points = { {0, .15},  {1, 1} } },
		color_g	= { points = { {0, .15}, {1, 1} } },
		color_b	= { points = { {0, .9},  {1, 1} } },
	},
}

postprocesses["damage_TEST_4"] =
{
	material_template = "damage_TEST",
	time = 100,

	properties = 
	{
		color_r	= { points = { {0, .15},  {1, 1} } },
		color_g	= { points = { {0, .15}, {1, 1} } },
		color_b	= { points = { {0, .9},  {1, 1} } },
	},
}

postprocesses["damage_TEST_5"] =
{
	material_template = "damage_TEST",
	time = 100,

	properties = 
	{
		color_r	= { points = { {0, .15},  {1, 1} } },
		color_g	= { points = { {0, .15}, {1, 1} } },
		color_b	= { points = { {0, .9},  {1, 1} } },
	},
}

postprocesses["damage_TEST_6"] =
{
	material_template = "damage_TEST",
	time = 100,

	properties = 
	{
		color_r	= { points = { {0, .15},  {1, 1} } },
		color_g	= { points = { {0, .15}, {1, 1} } },
		color_b	= { points = { {0, .9},  {1, 1} } },
	},
}

postprocesses["damage_TEST_7"] =
{
	material_template = "damage_TEST",
	time = 100,

	properties = 
	{
		color_r	= { points = { {0, .15},  {1, 1} } },
		color_g	= { points = { {0, .15}, {1, 1} } },
		color_b	= { points = { {0, .9},  {1, 1} } },
	},
}