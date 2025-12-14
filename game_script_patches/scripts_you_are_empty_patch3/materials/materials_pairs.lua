------------------------------------------------------------------------------------
-- список пар материалов (материал_1, материал_2, взаимодействие)
------------------------------------------------------------------------------------
materials_pairs = 
{
	-- пары оружие-no_material
	{ "mat_hit_spanner",				"no_material",			"inter_spanner_beton"			},
	{ "mat_hit_mauzer",				"no_material",			"inter_mauzer_beton"			},
	{ "mat_hit_obrez",				"no_material",			"inter_obrez_beton"				},
	{ "mat_hit_ppsh",				"no_material",			"inter_ppsh_beton"				},

	-- пары оружие-flares
	{ "mat_hit_spanner",				"mat_flares",			"inter_mauzer_flares"			},
	{ "mat_hit_mauzer",				"mat_flares",			"inter_mauzer_flares"			},
	{ "mat_hit_obrez",				"mat_flares",			"inter_mauzer_flares"				},
	{ "mat_hit_ppsh",				"mat_flares",			"inter_mauzer_flares"				},

	-- пары оружие-бетон
	{ "mat_hit_spanner",				"mat_beton",			"inter_spanner_beton"			},
	{ "mat_hit_mauzer",				"mat_beton",			"inter_mauzer_beton"			},
	{ "mat_hit_obrez",				"mat_beton",			"inter_obrez_beton"				},
	{ "mat_hit_ppsh",				"mat_beton",			"inter_ppsh_beton"				},

	-- пары оружие-stone
	{ "mat_hit_spanner",				"mat_stone",			"inter_spanner_stone"			},
	{ "mat_hit_mauzer",				"mat_stone",			"inter_mauzer_stone"			},
	{ "mat_hit_obrez",				"mat_stone",			"inter_mauzer_stone"				},
	{ "mat_hit_ppsh",				"mat_stone",			"inter_mauzer_stone"				},

	-- пары оружие-tile
	{ "mat_hit_spanner",				"mat_tile",			"inter_spanner_tile"			},
	{ "mat_hit_mauzer",				"mat_tile",			"inter_mauzer_tile"			},
	{ "mat_hit_obrez",				"mat_tile",			"inter_mauzer_tile"				},
	{ "mat_hit_ppsh",				"mat_tile",			"inter_mauzer_tile"				},

	-- пары оружие-stucco
	{ "mat_hit_spanner",				"mat_stucco",			"inter_spanner_beton"			},
	{ "mat_hit_mauzer",				"mat_stucco",			"inter_mauzer_beton"			},
	{ "mat_hit_obrez",				"mat_stucco",			"inter_mauzer_beton"				},
	{ "mat_hit_ppsh",				"mat_stucco",			"inter_mauzer_beton"				},

	-- пары оружие-ground
	{ "mat_hit_spanner",				"mat_ground",			"inter_spanner_ground"			},
	{ "mat_hit_mauzer",				"mat_ground",			"inter_mauzer_ground"			},
	{ "mat_hit_obrez",				"mat_ground",			"inter_mauzer_ground"				},
	{ "mat_hit_ppsh",				"mat_ground",			"inter_mauzer_ground"				},

	-- пары оружие-sand
	{ "mat_hit_spanner",				"mat_sand",			"inter_spanner_sand"			},
	{ "mat_hit_mauzer",				"mat_sand",			"inter_mauzer_sand"			},
	{ "mat_hit_obrez",				"mat_sand",			"inter_mauzer_sand"				},
	{ "mat_hit_ppsh",				"mat_sand",			"inter_mauzer_sand"				},

	-- пары оружие-zerno
	{ "mat_hit_spanner",				"mat_zerno",			"inter_spanner_zerno"			},
	{ "mat_hit_mauzer",				"mat_zerno",			"inter_mauzer_zerno"			},
	{ "mat_hit_obrez",				"mat_zerno",			"inter_mauzer_zerno"				},
	{ "mat_hit_ppsh",				"mat_zerno",			"inter_mauzer_zerno"				},

	-- пары оружие-water
	{ "mat_hit_spanner",				"mat_water",			"inter_spanner_water"			},
	{ "mat_hit_mauzer",				"mat_water",			"inter_mauzer_water"			},
	{ "mat_hit_obrez",				"mat_water",			"inter_mauzer_water"				},
	{ "mat_hit_ppsh",				"mat_water",			"inter_mauzer_water"				},

	-- пары оружие-metal
	{ "mat_hit_spanner",				"mat_metal",		"inter_spanner_metal"		},
	{ "mat_hit_mauzer",				"mat_metal",		"inter_mauzer_metal"		},
	{ "mat_hit_obrez",				"mat_metal",		"inter_mauzer_metal"		},
	{ "mat_hit_ppsh",				"mat_metal",		"inter_mauzer_metal"		},

	-- пары оружие-metal_thin
	{ "mat_hit_spanner",				"mat_metal_thin",		"inter_spanner_metal_thin"		},
	{ "mat_hit_mauzer",				"mat_metal_thin",		"inter_mauzer_metal_thin"		},
	{ "mat_hit_obrez",				"mat_metal_thin",		"inter_mauzer_metal_thin"		},
	{ "mat_hit_ppsh",				"mat_metal_thin",		"inter_mauzer_metal_thin"		},

	-- пары оружие-metal_bucket
	{ "mat_hit_spanner",				"mat_metal_bucket",		"inter_spanner_metal_bucket"		},
	{ "mat_hit_mauzer",				"mat_metal_bucket",		"inter_mauzer_metal_bucket"		},
	{ "mat_hit_obrez",				"mat_metal_bucket",		"inter_mauzer_metal_bucket"		},
	{ "mat_hit_ppsh",				"mat_metal_bucket",		"inter_mauzer_metal_bucket"		},

	-- пары оружие-vedro
	{ "mat_hit_spanner",				"mat_vedro",		"inter_spanner_metal_bucket"		},
	{ "mat_hit_mauzer",				"mat_vedro",		"inter_mauzer_metal_bucket"		},
	{ "mat_hit_obrez",				"mat_vedro",		"inter_mauzer_metal_bucket"		},
	{ "mat_hit_ppsh",				"mat_vedro",		"inter_mauzer_metal_bucket"		},

	-- пары оружие-metal_bidon
	{ "mat_hit_spanner",				"mat_metal_bidon",		"inter_spanner_metal_barrel"		},
	{ "mat_hit_mauzer",				"mat_metal_bidon",		"inter_mauzer_metal_bidon"		},
	{ "mat_hit_obrez",				"mat_metal_bidon",		"inter_mauzer_metal_bidon"		},
	{ "mat_hit_ppsh",				"mat_metal_bidon",		"inter_mauzer_metal_bidon"		},

	-- пары оружие-metal_barrel
	{ "mat_hit_spanner",				"mat_metal_barrel",		"inter_spanner_metal_barrel"		},
	{ "mat_hit_mauzer",				"mat_metal_barrel",		"inter_mauzer_metal_barrel"		},
	{ "mat_hit_obrez",				"mat_metal_barrel",		"inter_mauzer_metal_barrel"		},
	{ "mat_hit_ppsh",				"mat_metal_barrel",		"inter_mauzer_metal_barrel"		},

	-- пары оружие-wood
	{ "mat_hit_spanner",				"mat_wood",			"inter_spanner_wood_box_big"		},
	{ "mat_hit_mauzer",				"mat_wood",			"inter_mauzer_wood_box_big"		},
	{ "mat_hit_obrez",				"mat_wood",			"inter_mauzer_wood_box_big"		},
	{ "mat_hit_ppsh",				"mat_wood",			"inter_mauzer_wood_box_big"		},

	-- пары оружие-wood_box_big
	{ "mat_hit_spanner",				"mat_wood_box_big",		"inter_spanner_wood_box_big"		},
	{ "mat_hit_mauzer",				"mat_wood_box_big",		"inter_mauzer_wood_box_big"		},
	{ "mat_hit_obrez",				"mat_wood_box_big",		"inter_mauzer_wood_box_big"		},
	{ "mat_hit_ppsh",				"mat_wood_box_big",		"inter_mauzer_wood_box_big"		},

	-- пары оружие-wood_box_small
	{ "mat_hit_spanner",				"mat_wood_box_small",		"inter_spanner_wood_box_small"	},
	{ "mat_hit_mauzer",				"mat_wood_box_small",		"inter_mauzer_wood_box_small"	},
	{ "mat_hit_obrez",				"mat_wood_box_small",		"inter_mauzer_wood_box_small"	},
	{ "mat_hit_ppsh",				"mat_wood_box_small",		"inter_mauzer_wood_box_small"	},

	-- пары оружие-taburet
	{ "mat_hit_spanner",				"mat_taburet",			"inter_mauzer_taburet"		},
	{ "mat_hit_mauzer",				"mat_taburet",			"inter_mauzer_taburet"		},
	{ "mat_hit_obrez",				"mat_taburet",			"inter_mauzer_taburet"		},
	{ "mat_hit_ppsh",				"mat_taburet",			"inter_mauzer_taburet"		},

	-- пары оружие-kreslo
	{ "mat_hit_spanner",				"mat_kreslo",			"inter_mauzer_kreslo"		},
	{ "mat_hit_mauzer",				"mat_kreslo",			"inter_mauzer_kreslo"		},
	{ "mat_hit_obrez",				"mat_kreslo",			"inter_mauzer_kreslo"		},
	{ "mat_hit_ppsh",				"mat_kreslo",			"inter_mauzer_kreslo"		},

	-- пары оружие-piano
	{ "mat_hit_spanner",				"mat_piano",		"inter_mauzer_piano"},
	{ "mat_hit_mauzer",				"mat_piano",		"inter_mauzer_piano"},
	{ "mat_hit_obrez",				"mat_piano",		"inter_mauzer_piano"},
	{ "mat_hit_ppsh",				"mat_piano",		"inter_mauzer_piano"},

	-- пары оружие-rubber
	{ "mat_hit_spanner",				"mat_rubber",			"inter_mauzer_rubber"		},
	{ "mat_hit_mauzer",				"mat_rubber",			"inter_mauzer_rubber"		},
	{ "mat_hit_obrez",				"mat_rubber",			"inter_mauzer_rubber"		},
	{ "mat_hit_ppsh",				"mat_rubber",			"inter_mauzer_rubber"		},

	-- пары оружие-paper
	{ "mat_hit_spanner",				"mat_paper",			"inter_mauzer_paper"			},
	{ "mat_hit_mauzer",				"mat_paper",			"inter_mauzer_paper"			},
	{ "mat_hit_obrez",				"mat_paper",			"inter_mauzer_paper"				},
	{ "mat_hit_ppsh",				"mat_paper",			"inter_mauzer_paper"				},

	-- пары оружие-живое тело
	{ "mat_hit_spanner",				"mat_actor_body",		"inter_spanner_body"		},
	{ "mat_hit_mauzer",				"mat_actor_body",		"inter_mauzer_body"			},
	{ "mat_hit_obrez",				"mat_actor_body",		"inter_obrez_body"			},
	{ "mat_hit_ppsh",				"mat_actor_body",		"inter_ppsh_body"			},

	-- пары grenade-world
	{ "mat_grenade",				"mat_wood",		"inter_grenade_wood"		},
	{ "mat_grenade",				"mat_ground",		"inter_grenade_ground"		},
	{ "mat_grenade",				"mat_metal",		"inter_grenade_metal"		},
	{ "mat_grenade",				"mat_metal_thin",		"inter_grenade_metal_thin"		},
	{ "mat_grenade",				"mat_carpet",		"inter_grenade_carpet"		},
	{ "mat_grenade",				"mat_stone",		"inter_grenade_stone"		},

	{ "mat_hit_spanner",				"mat_actor_carrier",	"inter_spanner_body"		},
	{ "mat_hit_mauzer",				"mat_actor_carrier",	"inter_mauzer_body"			},
	{ "mat_hit_obrez",				"mat_actor_carrier",	"inter_obrez_body"			},
	{ "mat_hit_ppsh",				"mat_actor_carrier",	"inter_ppsh_body"			},
	{ "mat_metal_luk",				"mat_actor_carrier",	"inter_luk_body"			},
	
	{ "mat_hit_spanner",				"mat_protivogaz_legs",	"inter_spanner_body"		},
	{ "mat_hit_mauzer",				"mat_protivogaz_legs",	"inter_mauzer_body"			},
	{ "mat_hit_obrez",				"mat_protivogaz_legs",	"inter_obrez_body"			},
	{ "mat_hit_ppsh",				"mat_protivogaz_legs",	"inter_ppsh_body"			},
	{ "mat_metal_luk",				"mat_protivogaz_legs",	"inter_luk_body"			},

	-- пары актер-бетон
	{ "mat_actor_carrier",			"no_material",			"mat_actor_carrier_beton"	},
	{ "mat_actor_carrier",			"mat_beton",			"mat_actor_carrier_beton"	},
	{ "mat_actor_carrier",			"mat_wood",				"mat_actor_carrier_wood"	},
	{ "mat_actor_carrier",			"mat_graviy",			"mat_actor_carrier_graviy"	},
	{ "mat_actor_carrier",			"mat_luja",				"mat_actor_carrier_luja"	},
	{ "mat_actor_carrier",			"mat_metal",			"mat_actor_carrier_metal"	},
	{ "mat_actor_carrier",			"mat_trava",			"mat_actor_carrier_trava"	},
	{ "mat_actor_carrier",			"mat_metal_slider",		"mat_actor_carrier_metal_slider"},
	{ "mat_actor_carrier",			"mat_stone",			"mat_actor_carrier_stone"},
	{ "mat_actor_carrier",			"mat_water",			"mat_actor_carrier_luja"},
	
	-- steps
	{ "mat_actor_human_steps",		"no_material",			"steps_beton"				},
	{ "mat_actor_human_steps",		"mat_main",				"steps_main"				},
	{ "mat_actor_human_steps",		"mat_beton",			"steps_beton"				},
	{ "mat_actor_human_steps",		"mat_wood",				"steps_wood"				},
	{ "mat_actor_human_steps",		"mat_graviy",			"steps_graviy"				},
	{ "mat_actor_human_steps",		"mat_water",			"steps_water"				},
	{ "mat_actor_human_steps",		"mat_metal",			"steps_metal"				},
	{ "mat_actor_human_steps",		"mat_metal_thin",		"steps_metal_thin"			},
	{ "mat_actor_human_steps",		"mat_trava",			"steps_trava"				},
	{ "mat_actor_human_steps",		"mat_tile",				"steps_beton"				},
	{ "mat_actor_human_steps",		"mat_carpet",			"steps_carpet"				},
	{ "mat_actor_human_steps",		"mat_ground",			"steps_main"				},
	{ "mat_actor_human_steps",		"mat_sand",				"steps_sand"				},
	{ "mat_actor_human_steps",		"mat_stone",			"steps_stone"				},
	{ "mat_actor_human_steps",		"mat_konveer",			"steps_beton"				},

	-- climb
	{ "mat_actor_human_climb",		"mat_metal_ladder",		"climb_metal_ladder"		},

	-- jump
	{ "mat_actor_human_jump",		"no_material",			"jump_main"					},
	{ "mat_actor_human_jump",		"mat_main",				"jump_main"					},
	{ "mat_actor_human_jump",		"mat_beton",			"jump_main"					},
	{ "mat_actor_human_jump",		"mat_wood",				"jump_main"					},
	{ "mat_actor_human_jump",		"mat_graviy",			"jump_main"					},
	{ "mat_actor_human_jump",		"mat_luja",				"jump_main"					},
	{ "mat_actor_human_jump",		"mat_metal",			"jump_main"					},
	{ "mat_actor_human_jump",		"mat_trava",			"jump_main"					},
	{ "mat_actor_human_jump",		"mat_tile",				"jump_main"					},
	{ "mat_actor_human_jump",		"mat_carpet",			"jump_main"					},
	{ "mat_actor_human_jump",		"mat_stone",			"jump_main"					},
	{ "mat_actor_human_jump",		"mat_konveer",			"jump_main"					},

	-- land
	{ "mat_actor_human_land",		"no_material",			"land_beton"				},
	{ "mat_actor_human_land",		"mat_main",				"land_main"					},
	{ "mat_actor_human_land",		"mat_beton",			"land_beton"				},
	{ "mat_actor_human_land",		"mat_wood",				"land_wood"					},
	{ "mat_actor_human_land",		"mat_graviy",			"land_graviy"				},
	{ "mat_actor_human_land",		"mat_luja",				"land_luja"					},
	{ "mat_actor_human_land",		"mat_metal",			"land_metal"				},
	{ "mat_actor_human_land",		"mat_metal_thin",			"land_metal_thin"				},
	{ "mat_actor_human_land",		"mat_trava",			"land_trava"				},
	{ "mat_actor_human_land",		"mat_tile",				"land_beton"				},
	{ "mat_actor_human_land",		"mat_carpet",			"land_carpet"				},
	{ "mat_actor_human_land",		"mat_stone",			"land_beton"				},
	{ "mat_actor_human_land",		"mat_konveer",			"land_beton"				},

---------------------------
-- Custom materials
---------------------------

	-- пары оружие-fence
	{ "mat_hit_spanner",			"mat_fence",		"inter_mauzer_fence"	},
	{ "mat_hit_mauzer",				"mat_fence",		"inter_mauzer_fence"	},
	{ "mat_hit_obrez",				"mat_fence",		"inter_mauzer_fence"	},
	{ "mat_hit_ppsh",				"mat_fence",		"inter_mauzer_fence"	},

	-- пары оружие-vehicle
	{ "mat_hit_spanner",				"mat_vehicle",		"inter_spanner_vehicle"	},
	{ "mat_hit_mauzer",				"mat_vehicle",		"inter_mauzer_vehicle"	},
	{ "mat_hit_obrez",				"mat_vehicle",		"inter_mauzer_vehicle"	},
	{ "mat_hit_ppsh",				"mat_vehicle",		"inter_mauzer_vehicle"	},

	-- пары оружие-chaynik
	{ "mat_hit_spanner",				"mat_chaynik",		"inter_spanner_chaynik"	},
	{ "mat_hit_mauzer",				"mat_chaynik",		"inter_mauzer_chaynik"	},
	{ "mat_hit_obrez",				"mat_chaynik",		"inter_mauzer_chaynik"	},
	{ "mat_hit_ppsh",				"mat_chaynik",		"inter_mauzer_chaynik"	},

	-- пары оружие-palma
	{ "mat_hit_spanner",			"mat_palma",		"inter_mauzer_palma"	},
	{ "mat_hit_mauzer",				"mat_palma",		"inter_mauzer_palma"	},
	{ "mat_hit_obrez",				"mat_palma",		"inter_mauzer_palma"	},
	{ "mat_hit_ppsh",				"mat_palma",		"inter_mauzer_palma"	},

	-- пары оружие-katalka/kolyaska
	{ "mat_hit_spanner",				"mat_katalka",		"inter_spanner_katalka"	},
	{ "mat_hit_mauzer",				"mat_katalka",		"inter_mauzer_katalka"	},
	{ "mat_hit_obrez",				"mat_katalka",		"inter_mauzer_katalka"	},
	{ "mat_hit_ppsh",				"mat_katalka",		"inter_mauzer_katalka"	},

	{ "mat_hit_spanner",				"mat_kolyaska",		"inter_spanner_katalka"	},
	{ "mat_hit_mauzer",				"mat_kolyaska",		"inter_mauzer_katalka"	},
	{ "mat_hit_obrez",				"mat_kolyaska",		"inter_mauzer_katalka"	},
	{ "mat_hit_ppsh",				"mat_kolyaska",		"inter_mauzer_katalka"	},

	-- пары оружие-phone
	{ "mat_hit_spanner",			"mat_phone",		"inter_mauzer_phone"	},
	{ "mat_hit_mauzer",				"mat_phone",		"inter_mauzer_phone"	},
	{ "mat_hit_obrez",				"mat_phone",		"inter_mauzer_phone"	},
	{ "mat_hit_ppsh",				"mat_phone",		"inter_mauzer_phone"	},

	-- пары оружие-glass
	{ "mat_hit_spanner",				"mat_glass",		"inter_spanner_glass"		},
	{ "mat_hit_mauzer",				"mat_glass",		"inter_mauzer_glass"		},
	{ "mat_hit_obrez",				"mat_glass",		"inter_mauzer_glass"		},
	{ "mat_hit_ppsh",				"mat_glass",		"inter_mauzer_glass"		},

	-- пары оружие-firestuff
	{ "mat_hit_spanner",				"mat_firestuff",	"inter_spanner_metal"	},
	{ "mat_hit_mauzer",				"mat_firestuff",	"inter_mauzer_metal"	},
	{ "mat_hit_obrez",				"mat_firestuff",	"inter_mauzer_metal"	},
	{ "mat_hit_ppsh",				"mat_firestuff",	"inter_mauzer_metal"	},

	-- пары оружие-urna
	{ "mat_hit_spanner",				"mat_urna",	"inter_spanner_metal_bucket"	},
	{ "mat_hit_mauzer",				"mat_urna",	"inter_mauzer_metal_bucket"	},
	{ "mat_hit_obrez",				"mat_urna",	"inter_mauzer_metal_bucket"	},
	{ "mat_hit_ppsh",				"mat_urna",	"inter_mauzer_metal_bucket"	},	

	-- Vehicle to vehicle pair
	{ "mat_vehicle",				"mat_vehicle",		"inter_vehicle_self"		},

	-- actor_body
	{ "mat_actor_body",				"no_material",		"inter_body_beton"			},
	{ "mat_actor_body",				"mat_beton",		"inter_body_beton"			},
	{ "mat_actor_body",				"mat_stone",		"inter_body_beton"			},
	{ "mat_actor_body",				"mat_wood",			"inter_body_beton"			},
	{ "mat_actor_body",				"mat_glass",		"inter_body_beton"			},
	{ "mat_actor_body",				"mat_metal",		"inter_body_beton"			},
	{ "mat_actor_body",				"mat_tile",			"inter_body_beton"			},
	{ "mat_actor_body",				"mat_carpet",		"inter_body_beton"			},

-- tests
	{ "mat_stone",					"mat_beton",		"inter_stone_beton"			},
	{ "mat_metal_barrel",			"mat_beton",		"inter_metal_barrel_beton"	},

	{ "mat_wood",					"mat_beton",		"inter_box_beton"		},
	{ "mat_protivogaz_legs",		"mat_beton",		"inter_protivogaz_legs_beton"		},

	-- пары оружие-konveer
	{ "mat_hit_spanner",				"mat_konveer",		"inter_mauzer_konveer"	},
	{ "mat_hit_mauzer",				"mat_konveer",		"inter_mauzer_konveer"	},
	{ "mat_hit_obrez",				"mat_konveer",		"inter_mauzer_konveer"	},
	{ "mat_hit_ppsh",				"mat_konveer",		"inter_mauzer_konveer"	},
}
