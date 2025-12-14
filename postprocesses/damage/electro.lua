---------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от электричества (ELECTRO)
---------------------------------------------------------------
postprocesses["damage_ELECTRO_1"] =
{
	material_template = "damage_ELECTRO",
	time = 200,
               	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		filter_r = { points = { {0, 1.15},  {2, 1} } }, 
		filter_g = { points = { {0, 1.15},  {2, 1} } },
		filter_b = { points = { {0, 1.95},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

                          
postprocesses["damage_ELECTRO_2"] =
{
	material_template = "damage_ELECTRO",
	time = 300,

	properties = 
	{
		filter_r = { points = { {0, 1.15},  {2, 1} } }, 
		filter_g = { points = { {0, 1.15},  {2, 1} } },
		filter_b = { points = { {0, 1.95},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},

}
postprocesses["damage_ELECTRO_3"] =
{
	material_template = "damage_ELECTRO",
	time = 400,

	properties = 
	{
		filter_r = { points = { {0, 1.15},  {2, 1} } }, 
		filter_g = { points = { {0, 1.15},  {2, 1} } },
		filter_b = { points = { {0, 1.95},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_ELECTRO_4"] =
{
	material_template = "damage_ELECTRO",
	time = 500,

	properties = 
	{
		filter_r = { points = { {0, 1.15},  {2, 1} } }, 
		filter_g = { points = { {0, 1.15},  {2, 1} } },
		filter_b = { points = { {0, 1.95},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_ELECTRO_5"] =
{
	material_template = "damage_ELECTRO",
	time = 600,

	properties = 
	{
		filter_r = { points = { {0, 1.15},  {2, 1} } }, 
		filter_g = { points = { {0, 1.15},  {2, 1} } },
		filter_b = { points = { {0, 1.95},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_ELECTRO_6"] =
{
	material_template = "damage_ELECTRO",
	time = 700,

	properties = 
	{
		filter_r = { points = { {0, 1.15},  {2, 1} } }, 
		filter_g = { points = { {0, 1.15},  {2, 1} } },
		filter_b = { points = { {0, 1.95},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["damage_ELECTRO_7"] =
{
	material_template = "damage_ELECTRO",
	time = 800,

	properties = 
	{
		filter_r = { points = { {0, 1.15},  {2, 1} } }, 
		filter_g = { points = { {0, 1.15},  {2, 1} } },
		filter_b = { points = { {0, 1.95},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}