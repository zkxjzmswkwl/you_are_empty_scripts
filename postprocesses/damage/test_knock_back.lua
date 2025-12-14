--------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от выстрелов (GUNSHOT)
--------------------------------------------------------------------

postprocesses["damage_TEST_1"] =
{
	material_template = "damage_TEST",
	time = 200,
               	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

                          
postprocesses["damage_TEST_2"] =
{
	material_template = "damage_TEST",
	time = 250,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},

}
postprocesses["damage_TEST_3"] =
{
	material_template = "damage_TEST",
	time = 300,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_4"] =
{
	material_template = "damage_TEST",
	time = 350,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_5"] =
{
	material_template = "damage_TEST",
	time = 400,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_6"] =
{
	material_template = "damage_TEST",
	time = 450,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_TEST_7"] =
{
	material_template = "damage_TEST",
	time = 500,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}