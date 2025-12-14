-- взаимодействие актера с бетоном
materials_interactions_infos.mat_actor_carrier_beton = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "test_effect.lua", t_range = { 0.001, 1 } },
	},
}

materials_interactions_infos.mat_actor_carrier_wood = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "steps_wood.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.mat_actor_carrier_graviy = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "steps_graviy.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.mat_actor_carrier_luja = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "steps_luja.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.mat_actor_carrier_metal = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "steps_metal.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.mat_actor_carrier_metal_thin = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "steps_metal_thin.lua", n_range = { 0.05, 1 } },
	},
}

materials_interactions_infos.mat_actor_carrier_trava = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "steps_trava.lua", n_range = { 0.05, 1 } },
	},
}

----------------------
--Custom materials
----------------------

materials_interactions_infos.mat_actor_carrier_metal_slider = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.inter_protivogaz_legs_beton= {
	contact = {
		friction	= 0.0,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},
}

materials_interactions_infos.mat_actor_carrier_stone = {
	contact = {
		friction	= 1,
		bounce		= 0.0,
		erp			= 0.3,
		cfm			= 0.000001,
	},

	effects = { 
		--{ name = "steps_stone.lua", n_range = { 0.05, 1 } },
	},
}