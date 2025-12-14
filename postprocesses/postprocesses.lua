-----------------------------------------------------------------
postprocesses = {}

-----------------------------------------------------------------
-- Постпроцессы повреждений
include("you_are_empty\\postprocesses\\damage\\gunshots.lua")
include("you_are_empty\\postprocesses\\damage\\knocks.lua")
include("you_are_empty\\postprocesses\\damage\\falls.lua")
include("you_are_empty\\postprocesses\\damage\\blasts.lua")
include("you_are_empty\\postprocesses\\damage\\burns.lua")
include("you_are_empty\\postprocesses\\damage\\shpr.lua")
include("you_are_empty\\postprocesses\\damage\\test.lua")
include("you_are_empty\\postprocesses\\damage\\bang.lua")
include("you_are_empty\\postprocesses\\damage\\electro.lua")
-----------------------------------------------------------------
-----------------------------------------------------------------

postprocesses["test"] =
{
	material_template = "filter",
	time = 1500,
	use_game_time = true,
	
	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		-- точки задаются как пары {time, value}
		intensivity = { points = { {1, 0}, {0, 1} } },

	},
}


postprocesses["fade_out"] =
{
	material_template = "filter",
	time = 1500,

	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		intensivity = { points = { {0, 1}, {1, 0} } },

	},
}

postprocesses["fade_out_long"] =
{
	material_template = "filter",
	time = 5000,

	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		intensivity = { points = { {0, 1}, {1, 0} } },

	},
}

postprocesses["fade_in"] =
{
	material_template = "filter",
	time = 1500,

	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		intensivity = { points = { {0, 0}, {0.9, 1}, {1.5, 1}, } },

	},
}

postprocesses["fade_in_long"] =
{
	material_template = "filter",
	time = 5000,

	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		intensivity = { points = { {0, 0}, {0.3, 1}, {1, 1}, } },

	},
}

postprocesses["fade_in_out"] =
{
	material_template = "filter",
	time = 6000,

	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		intensivity = { points = { {0, 0}, {0.3, 1}, {0.7, 1}, {1, 0} } },
	},
}

postprocesses["fade_in_out_long"] =
{
	material_template = "filter",
	time = 13000,

	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		intensivity = { points = { {0, 0}, {0.3, 1}, {0.7, 1}, {1, 0} } },
	},
}

postprocesses["fade_in_white"] =
{
	material_template = "filter",
	time = 1500,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1} } },
		color_b	= { points = { {0, 1} } },
		intensivity = { points = { {0, 0}, {1, 1} } },

	},
}

postprocesses["fade_in_inf"] =
{
	material_template = "filter",
	time = 1500 * 100,

	properties = 
	{
		color_r	= { points = { {0, 0} } },
		color_g	= { points = { {0, 0} } },
		color_b	= { points = { {0, 0} } },
		intensivity = { points = { {0, 0}, {1 / 100, 1}, { 1, 1 } } },
	},
}

postprocesses["fade_in_white_inf"] =
{
	material_template = "filter",
	time = 1500 * 100,

	properties = 
	{
		color_r	= { points = { {0, 1} } },
		color_g	= { points = { {0, 1} } },
		color_b	= { points = { {0, 1} } },
		intensivity = { points = { {0, 0}, {1 / 100, 1}, { 1, 1 } } },
	},
}

postprocesses["death"] =
{
	material_template = "damage_0",
	time = 500,

	properties = 
	{
		filter_r	= { points = { {0, .5} } },
		filter_g	= { points = { {0, .5} } },
		filter_b	= { points = { {0, .5} } },
		intensivity	= { points = { {0, 0}, {0.2, 0.5}, {1, 0.3} }, loops = { {0, 1, 3} }  },
	},
}


postprocesses["add_health"] =
{
	material_template = "damage_0",
	time = 500,

	properties = 
	{
		filter_r	= { points = { {0, .2} } },
		filter_g	= { points = { {0, .2} } },
		filter_b	= { points = { {0, .3} } },
		intensivity	= { points = { {0, 0}, {0.2, 0.5}, {1, 0.3} } },
	},
}

postprocesses["add_armor"] =
{
	material_template = "damage_0",
	time = 500,

	properties = 
	{
		filter_r	= { points = { {0, .3} } },
		filter_g	= { points = { {0, .3} } },
		filter_b	= { points = { {0, .3} } },
		intensivity	= { points = { {0, 0}, {0.2, 0.5}, {1, 0.3} } },
	},
}

postprocesses["add_ammo"] =
{
	material_template = "damage_0",
	time = 500,

	properties = 
	{
		filter_r	= { points = { {0, .3} } },
		filter_g	= { points = { {0, .3} } },
		filter_b	= { points = { {0, .3} } },
		intensivity	= { points = { {0, 0}, {0.2, 0.5}, {1, 0.3} } },
	},
}

postprocesses["black_and_white"] =
{
	material_template = "damage_1",
	time = 15000,
}

postprocesses["add_cure"] =
{
	material_template = "filter",
	time = 4000,

	properties = 
	{
		filter_r	= { points = { {0, .3} } },
		filter_g	= { points = { {0, .3} } },
		filter_b	= { points = { {0, .3} } },
                contrast        = { points = { {0, .0},{0.2, 1},{1, 0}  } },
	},
}

postprocesses["add_cure2"] =
{
	material_template = "filter",
	time = 10000,

	properties = 
	{
		filter_r	= { points = { {0, .1},{0.5, .9} } },
		filter_g	= { points = { {0, .1},{0.5, .9} } },
		filter_b	= { points = { {0, .1},{0.5, .9} } },
	},
}

postprocesses["the_end_shot"] =
{
	material_template = "damage_END",
	time = 500,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}

postprocesses["the_end_medium"] =
{
	material_template = "damage_END",
	time = 1000,

	properties = 
	{
		filter_r = { points = { {0, 0.15},  {2, 1} } }, 
		filter_g = { points = { {0, 0.13},  {2, 1} } },
		filter_b = { points = { {0, 0.13},  {2, 1} } },
		blur_kernel = { points = { {0, 5},  {2, 0}, } },
	},
}
