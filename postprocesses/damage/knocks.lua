---------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от ударов (KNOCK)
---------------------------------------------------------------
postprocesses["damage_KNOCK_1"] =
{
	material_template = "damage_KNOCKS",
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

                          
postprocesses["damage_KNOCK_2"] =
{
	material_template = "damage_KNOCKS",
	time = 250,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},

}
postprocesses["damage_KNOCK_3"] =
{
	material_template = "damage_KNOCKS",
	time = 300,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_KNOCK_4"] =
{
	material_template = "damage_KNOCKS",
	time = 350,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_KNOCK_5"] =
{
	material_template = "damage_KNOCKS",
	time = 400,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_KNOCK_6"] =
{
	material_template = "damage_KNOCKS",
	time = 450,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_KNOCK_7"] =
{
	material_template = "damage_KNOCKS",
	time = 500,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.35},  {2, 1} } },
		filter_b = { points = { {0, 0.35},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}