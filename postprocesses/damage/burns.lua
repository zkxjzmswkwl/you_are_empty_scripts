--------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от ожогов (BURN)
--------------------------------------------------------------------

postprocesses["damage_BURN_1"] =
{
	material_template = "damage_BURN",
	time = 200,
               	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		filter_r = { points = { {0, 1.95},  {2, 1} } }, 
		filter_g = { points = { {0, 1.05},  {2, 1} } },
		filter_b = { points = { {0, .01},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

                          
postprocesses["damage_BURN_2"] =
{
	material_template = "damage_BURN",
	time = 200,

	properties = 
	{
		filter_r = { points = { {0, 1.95},  {2, 1} } }, 
		filter_g = { points = { {0, 1.05},  {2, 1} } },
		filter_b = { points = { {0, .01},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},

}
postprocesses["damage_BURN_3"] =
{
	material_template = "damage_BURN",
	time = 200,

	properties = 
	{
		filter_r = { points = { {0, 1.95},  {2, 1} } }, 
		filter_g = { points = { {0, 1.05},  {2, 1} } },
		filter_b = { points = { {0, .01},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BURN_4"] =
{
	material_template = "damage_BURN",
	time = 200,

	properties = 
	{
       		filter_r = { points = { {0, 1.95},  {2, 1} } }, 
		filter_g = { points = { {0, 1.05},  {2, 1} } },
		filter_b = { points = { {0, .01},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BURN_5"] =
{
	material_template = "damage_BURN",
	time = 200,

	properties = 
	{
       		filter_r = { points = { {0, 1.95},  {2, 1} } }, 
		filter_g = { points = { {0, 1.05},  {2, 1} } },
		filter_b = { points = { {0, .01},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BURN_6"] =
{
	material_template = "damage_BURN",
	time = 200,

	properties = 
	{
       		filter_r = { points = { {0, 1.95},  {2, 1} } }, 
		filter_g = { points = { {0, 1.05},  {2, 1} } },
		filter_b = { points = { {0, .01},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BURN_7"] =
{
	material_template = "damage_BURN",
	time = 200,

	properties = 
	{
       		filter_r = { points = { {0, 1.95},  {2, 1} } }, 
		filter_g = { points = { {0, 1.05},  {2, 1} } },
		filter_b = { points = { {0, .01},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}