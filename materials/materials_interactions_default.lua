
-- настройки оружия по умолчанию
materials_interactions_infos.inter_spanner_default = {
	effects = { 
		{ name = "hit_spanner.lua", n_range = { 0, 1 } },
	},
}
	
materials_interactions_infos.inter_mauzer_default = {
	effects = { 
		{ name = "hit_beton_mauzer.lua", n_range = { 0, 1 } },
	},
}
	
materials_interactions_infos.inter_obrez_default = {
	effects = { 
		{ name = "hit_beton_shotgun.lua", n_range = { 0, 1 } },
	},
}
	
materials_interactions_infos.inter_ppsh_default = {
	effects = { 
		{ name = "hit_beton_machinegun.lua", n_range = { 0, 1 } },
	},
}

-- настройки для различных материалов по умолчанию
materials_interactions_infos.inter_main = {
	contact = {
		friction	= 0.5,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_beton = {
	contact = {
		friction	= 0.8,
		bounce		= 0.2,
		erp			= 0.9,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_flares = {
	contact = {
		friction	= 0.7,
		bounce		= 0.0,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}
materials_interactions_infos.inter_tile = {
	contact = {
		friction	= 0.73,
		bounce		= 0.1,
		erp			= 0.9,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_stucco = {
	contact = {
		friction	= 0.8,
		bounce		= 0.1,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_stone = {
	contact = {
		friction	= .8,
		bounce		= 0.2,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_carpet = {
	contact = {
		friction	= 1,
		bounce		= 0,
		erp			= 0.3,
		cfm			= 0.0001,
	},
}

materials_interactions_infos.inter_keramics = {
	contact = {
		friction	= .5,
		bounce		= 0.2,
		erp			= 0.7,
		cfm			= 0.000001,
		},
	effects = { 
		{ name = "coll_keramics.lua", n_range = { 0.15, 1 } },
		},
}

materials_interactions_infos.inter_ground = {
	contact = {
		friction	= .8,
		bounce		= 0.2,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_sand = {
	contact = {
		friction	= .2,
		bounce		= 0.0,
		erp			= 0.1,
		cfm			= 0.0001,
	},
}

materials_interactions_infos.inter_zerno = {
	contact = {
		friction	= .2,
		bounce		= 0.0,
		erp			= 0.1,
		cfm			= 0.0001,
	},
}

materials_interactions_infos.inter_wood = {
	contact = {
		friction	= 0.4,
		bounce		= 0.0,
		erp			= 0.4,
		cfm			= 0.00001,
	},
	effects = { 
		{ name = "coll_wood.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_glass = {
	contact = {
		friction	= 0.3,
		bounce		= 0.0,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_water = {
	contact = {
		friction	= 0.3,
		bounce		= 0.0,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_graviy = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_luja = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_metal = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.7,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_metal.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_metal_thin = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.7,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_metal_thin.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_metal_barrel = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.7,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_metal_barrel.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_metal_serp = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.7,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_metal_serp.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_rubber = {
	contact = {
		friction	= 2,
		bounce		= 0.9,
		erp			= 0.3,
		cfm			= 0.00001,
	},
}

materials_interactions_infos.inter_fence = {
	contact = {
		friction	= 1,
		bounce		= 0.5,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_palma = {
	contact = {
		friction	= 1,
		bounce		= 0.05,
		erp			= 0.7,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_palma.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_trava = {
	contact = {
		friction	= .7,
		bounce		= 0.0,
		erp			= 0.7,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_actor_human = {
	contact = {
		friction	= 0.1,
		bounce		= 0.0,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_actor.lua", n_range = { 0.25, 1 } },
	},
}

materials_interactions_infos.inter_barrier = {
	contact = {
		friction	= -10,
		bounce		= 0.0,
		erp			= 0.9,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_metal_ladder = {
	contact = {
		friction	= -10,
		bounce		= 0.0,
		erp			= 0.9,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_paper = {
	contact = {
		friction	= 0.8,
		bounce		= 0.2,
		erp			= 0.9,
		cfm			= 0.000001,
	},
}
--------------------------------
-- Custom materials
--------------------------------

materials_interactions_infos.inter_metal_slider = {
	contact = {
		friction	= -10.5,
		bounce		= 0.0,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
}

materials_interactions_infos.inter_chaynik = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_chaynik.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_firestuff = {
	contact = {
		friction	= .5,
		bounce		= 0.2,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_firestuff.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_taburet = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_taburet.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_phone = {
	contact = {
		friction	= 1,
		bounce		= 0.2,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_phone.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_kreslo = {
	contact = {
		friction	= 1,
		bounce		= 0.2,
		erp			= 0.5,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_kreslo.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_urna = {
	contact = {
		friction	= 1,
		bounce		= 0.37,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_urna.lua", n_range = { 0.03, 1 } },
	},
}

materials_interactions_infos.inter_wood_barrel = {
	contact = {
		friction	= 1,
		bounce		= 0.1,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_wood_barrel.lua", t_range = { 0.01, 1 } },
	},
}

materials_interactions_infos.inter_metal_luk = {
	contact = {
		friction	= 1,
		bounce		= 0.5,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_metal_luk.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_metal_bidon = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_metal_bidon.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_katalka = {
	contact = {
		friction	= 1,
		bounce		= 0.1,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_katalka.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_kolyaska = {
	contact = {
		friction	= 1,
		bounce		= 0.1,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_kolyaska.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_vehicle = {
	contact = {
		friction	= 3,
		bounce		= 0.1,
		erp			= 0.3,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_vehicle.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_canister = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_canister.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_metal_bucket = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_metal_bucket.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_rat_body = {
	contact = {
		friction	= 1,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.000001,
	},
	effects = { 
		{ name = "coll_rat_body.lua", n_range = { 0.15, 1 } },
	},
}

materials_interactions_infos.inter_grenade = {
	contact = {
		friction	= .5,
		bounce		= 0.3,
		erp			= 0.9,
		cfm			= 0.00000001,
	},
	effects = { 
		{ name = "coll_grenade_default.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.inter_konveer = {
	contact = {
		friction	= 0.8,
		bounce		= 0.2,
		erp			= 0.9,
		cfm			= 0.000001,
	},
}
