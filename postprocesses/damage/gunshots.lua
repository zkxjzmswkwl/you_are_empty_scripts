--------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от выстрелов (GUNSHOT)
--------------------------------------------------------------------

postprocesses["damage_GUNSHOT_1"] =
{
	material_template = "filter_modulate",
	time = 200,

	properties = 
	{
		-- points задается в виде (time, intensivity), loops задается в виде (time1, time2, count)
		--	some_parameter = { points = { {0, 0}, {0.5, 1}, {1, 0} }, loops = { {0.3, 0.7, 1} } },
		
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
	},
}

postprocesses["damage_GUNSHOT_2"] =
{
	material_template = "filter_modulate",
	time = 300,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
	},
}

postprocesses["damage_GUNSHOT_3"] =
{
	material_template = "filter_modulate",
	time = 500,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
	},
}

postprocesses["damage_GUNSHOT_4"] =
{
	material_template = "filter_modulate",
	time = 500,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .6}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .6}, {1, 1} } },
	},
}

postprocesses["damage_GUNSHOT_5"] =
{
	material_template = "filter_modulate",
	time = 500,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .5}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .5}, {1, 1} } },
	},
}

postprocesses["damage_GUNSHOT_6"] =
{
	material_template = "filter_modulate",
	time = 500,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .4}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .4}, {1, 1} } },
	},
}

postprocesses["damage_GUNSHOT_7"] =
{
	material_template = "filter_modulate",
	time = 500,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .3}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .3}, {1, 1} } },
	},
}