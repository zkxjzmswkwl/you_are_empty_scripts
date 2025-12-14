----------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от ударной волны (BLAST)
----------------------------------------------------------------------

postprocesses["damage_SHPR_1"] =
{
	material_template = "damage_SHPR",
	time = 500,
               	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.55},  {2, 1} } },
		filter_b = { points = { {0, 0.55},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

                          
postprocesses["damage_SHPR_2"] =
{
	material_template = "damage_SHPR",
	time = 700,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.55},  {2, 1} } },
		filter_b = { points = { {0, 0.55},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},

}
postprocesses["damage_SHPR_3"] =
{
	material_template = "damage_SHPR",
	time = 900,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.55},  {2, 1} } },
		filter_b = { points = { {0, 0.55},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_SHPR_4"] =
{
	material_template = "damage_SHPR",
	time = 1100,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.55},  {2, 1} } },
		filter_b = { points = { {0, 0.55},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_SHPR_5"] =
{
	material_template = "damage_SHPR",
	time = 1300,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.55},  {2, 1} } },
		filter_b = { points = { {0, 0.55},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_SHPR_6"] =
{
	material_template = "damage_SHPR",
	time = 1500,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.55},  {2, 1} } },
		filter_b = { points = { {0, 0.55},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_SHPR_7"] =
{
	material_template = "damage_SHPR",
	time = 1700,

	properties = 
	{
		filter_r = { points = { {0, 0.95},  {2, 1} } }, 
		filter_g = { points = { {0, 0.55},  {2, 1} } },
		filter_b = { points = { {0, 0.55},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}