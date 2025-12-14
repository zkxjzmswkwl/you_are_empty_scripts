--------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от выстрелов (BANG)
--------------------------------------------------------------------

postprocesses["damage_BANG_1"] =
{
	material_template = "damage_BANG",
	time = 500,
               	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

                          
postprocesses["damage_BANG_2"] =
{
	material_template = "damage_BANG",
	time = 800,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},

}
postprocesses["damage_BANG_3"] =
{
	material_template = "damage_BANG",
	time = 1100,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BANG_4"] =
{
	material_template = "damage_BANG",
	time = 1400,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BANG_5"] =
{
	material_template = "damage_BANG",
	time = 1700,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BANG_6"] =
{
	material_template = "damage_BANG",
	time = 2000,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_BANG_7"] =
{
	material_template = "damage_BANG",
	time = 2300,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}