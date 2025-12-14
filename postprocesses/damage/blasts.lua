----------------------------------------------------------------------
-- Постпроцессы, соответствующие повреждениям от ударной волны (BLAST)
----------------------------------------------------------------------

postprocesses["damage_BLAST_1"] =
{
	material_template = "filter_modulate",
	time = 100,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
	},
}

postprocesses["damage_BLAST_2"] =
{
	material_template = "filter_modulate",
	time = 200,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .7}, {1, 1} } },
	},
}

postprocesses["damage_BLAST_3"] =
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

postprocesses["damage_BLAST_4"] =
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

postprocesses["damage_BLAST_5"] =
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

postprocesses["damage_BLAST_6"] =
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

postprocesses["damage_BLAST_7"] =
{
	material_template = "filter_modulate",
	time = 1000,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1}, {.1, .3}, {1, 1} } },
		color_b	= { points = { {0, 1}, {.1, .3}, {1, 1} } },
	},
}