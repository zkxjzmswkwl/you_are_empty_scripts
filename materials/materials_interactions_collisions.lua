-----------------------------------------------
-- таблица данных о взаимодействиях материалов
-----------------------------------------------

materials_interactions_infos.inter_stone_beton = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
	effects = { 
		--{ name = "hit_beton.lua",	n_range = { 0.05,	0.1	} },
	},
}

materials_interactions_infos.inter_metal_barrel_beton = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
	effects = { 
		--{ name = "hit_metal_barrel_beton.lua",	n_range = { 0.05,	1	} },
	},
}
materials_interactions_infos.inter_box_beton = {
	contact = {
		friction	= 0.5,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
	effects = { 
		--{ name = "hit_box_beton.lua",	n_range = { 0.05,	1	} },
	},
}

materials_interactions_infos.inter_test_example = {
	contact = {
		friction	= 0.5,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
	effects = { 
		-- name = имя эффекта
		-- n_range = минимальный и максимальный пороги интенсивности взаимодействия по нормали
		-- t_range = минимальный и максимальный пороги интенсивности взаимодействия по касательной
		{ name = "soft_effect",		n_range = { 0.05,	0.1	} },
		{ name = "normal_effect",	n_range = { 0.1,	0.5	} },
		{ name = "strong_effect",	n_range = { 0.5,	1		} },

		{ name = "tangent_effect",	t_range = { 0.5,	1		} },
	},
}

materials_interactions_infos.inter_body_beton = {
	contact = {
		friction	= 0.5,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.00001,
	},
	effects = { 
		{ name = "coll_body_beton_light.lua",	n_range = { 0.01,	0.1	} },
		{ name = "coll_body_beton_med.lua",		n_range = { 0.1,	0.7		} },
		{ name = "coll_body_beton_hard.lua",	n_range = { 0.6,	1.0		} },

--		{ name = "coll_body_beton_tangent.lua",		t_range = { 0.3,	1.0	} },
--		{ name = "coll_body_beton_hard.lua",		t_range = { 0.5,	1.0	} },
	},
}
--[[
materials_interactions_infos.inter_box_beton = {
	effects = { 
		{ name = "hit_box_beton.lua",		n_range = { 0.05,	0.1	} },
	},
}
--]]



materials_interactions_infos.inter_vehicle_self = {
	contact = {
		friction	= 0.0,
		bounce		= 0.0,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
}


materials_interactions_infos.inter_grenade_wood = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_grenade_wood.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_grenade_ground = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_grenade_ground.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_grenade_metal = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_grenade_metal.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_grenade_metal_thin = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_grenade_metal_thin.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_grenade_carpet = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_grenade_carpet.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_grenade_stone = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_grenade_stone.lua", n_range = { 0.05, 1 } },
	},
}