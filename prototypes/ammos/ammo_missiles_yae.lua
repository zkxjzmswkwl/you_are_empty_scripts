------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Метательные предметы и гранаты
------------------------------------------------------------------------

-------------------------------------------
-- шприц
-------------------------------------------
ammo_missile_squirt, sv_ammo_missile_squirt, cl_ammo_missile_squirt = create_ammo_missile(
					{0x9fc74420, 0x80a1, 0x4b43, 0x89, 0xcc, 0xb5, 0xa3, 0x4a, 0x81, 0x83, 0xcc},
					"pyro",
					{{"damage",							10},
					 {"damage_type",					g_damage_type.SHPR},
					 {"mass",							1},
					 {"is_explosive",					true},
					 {"is_explode_on_static_impact",	true},
					 {"is_explode_on_alive_impact",		false},
					 {"explode_effect_name",			"pfx_hit_shpric.lua"},
					 {"explode_damage",					0},
					 {"explode_radius",					0.1},
					 {"explode_impulse",				0},
					 {"explode_time",					4000},
					 });
					 
-------------------------------------------
-- fireball
-------------------------------------------
ammo_missile_fireball, sv_ammo_missile_fireball, cl_ammo_missile_fireball = create_ammo_missile(
					{0xaaea9354, 0x807e, 0x4547, 0xac, 0x42, 0x76, 0xab, 0x9a, 0xd1, 0xa0, 0xa8},
					"fireboll",
					{{"damage",							0},
					 {"explode_damage_type",			g_damage_type.ELECTRO},
					 {"mass",							1},
					 {"is_stickable",					false},
					 {"is_explosive",					true},
					 {"is_explode_on_static_impact",	true},
					 {"is_explode_on_alive_impact",		true},
					 {"cast_shadows",					false},
					 {"explode_effect_name",			"pfx_electro_fireball_expl.lua"},
					 {"explode_radius",					4},
					 {"explode_damage",					3.5},					 
					 {"explode_impulse",				0.3},
					 {"explode_time",					4000},
					 {"light_enable",					true},
					 {"light_radius",					200},
					 {"light_color",					{0, 0, 1}},
					 {"effector",					"camera_electro_expl"},
					 {"attached_effect",				"pfx_electro_fireball.lua"},
					 }); 
					 
-------------------------------------------
-- канализационный люк
-------------------------------------------
ammo_missile_disk, sv_ammo_missile_disk, cl_ammo_missile_disk = create_ammo_missile(
					{0x760d687c, 0x290d, 0x4886, 0xb9, 0x6a, 0xb1, 0x78, 0x55, 0xd9, 0xd2, 0xc2},
					"phy_luk",
					{{"damage",							10},
					 {"damage_type",					g_damage_type.KNOCK},
					 {"material_default",					"mat_metal_luk"},
					 {"mass",							10.0},
					 {"is_explosive",					false},
					 {"is_explode_on_static_impact",	false},
					 {"is_explode_on_alive_impact",		false},
					 {"explode_effect_name",			"hit_sparks01.lua"},
					 {"explode_radius",					4},
					 {"explode_impulse",				0.3},
					 {"explode_time",					4000},
					 });
					 
-------------------------------------------
-- граната
-------------------------------------------
ammo_missile_grenade, sv_ammo_missile_grenade, cl_ammo_missile_grenade = create_ammo_missile(
					{0x76674a3, 0x3cf, 0x4162, 0x8b, 0x1, 0x2b, 0x42, 0x5e, 0xec, 0xfa, 0xa1},
					"wpn_granaten_LOD",
					{{"damage",							0},
					 {"explode_damage_type",			g_damage_type.BANG},
					 {"material_default",				"mat_grenade"},
					 {"mass",							5},
					 {"is_explosive",					true},
					 {"is_explode_on_static_impact",	false},
					 {"is_explode_on_alive_impact",		false},
					 {"explode_effect_name",			"pfx_expl_grenade.lua"},
					 {"explode_radius",					5},
					 {"explode_damage",					25},
					 {"explode_impulse",					.3},
					 {"explode_time",					3700},
					 });
					 
-------------------------------------------
-- коктейль молотова
-------------------------------------------
ammo_missile_bottle, sv_ammo_missile_bottle, cl_ammo_missile_bottle = create_ammo_missile(
					{0xb87c3c31, 0x52fe, 0x47ad, 0xba, 0x9f, 0x27, 0x76, 0x46, 0x49, 0x61, 0xbc},
					"molotbotle",
					{{"damage",							0},
					 {"damage_type",					g_damage_type.BURN},
					 {"mass",							2},
					 {"is_explosive",					true},
					 {"is_explode_on_static_impact",	true},
					 {"is_explode_on_alive_impact",		false},
					 {"explode_effect_name",			"pfx_expl_bottle.lua"},
					 {"explode_radius",					5},
					 {"explode_damage",					150},
					 {"explode_impulse",				2.5},
					 {"explode_time",					7000},
					 {"attached_effect",				"pfx_burning_bottle.lua"},
					 });
					 
-------------------------------------------
-- коктейль молотова, которым бросаются боты.
-------------------------------------------
ammo_missile_bottle_bot, sv_ammo_missile_bottle_bot, cl_ammo_missile_bottle_bot = create_ammo_missile(
					{0x4d9f990c, 0x70bc, 0x4099, 0x96, 0xaa, 0x37, 0xc2, 0x67, 0x2, 0xa0, 0xcc},
					"molotbotle",
					{{"damage",							5},
					 {"explode_damage_type",					g_damage_type.BURN},
					 {"mass",							2},
					 {"is_explosive",					true},
					 {"is_explode_on_static_impact",	true},
					 {"is_explode_on_alive_impact",		false},
					 {"explode_effect_name",			"pfx_expl_bottle.lua"},
					 {"explode_radius",					3.5},
					 {"explode_damage",					15},
					 {"explode_impulse",				.1},
					 {"explode_time",					7000},
					 {"attached_effect",				"pfx_burning_bottle.lua"},
					 });
					 
-------------------------------------------
-- плевки гомноеда
-------------------------------------------
ammo_missile_spit, sv_ammo_missile_spit, cl_ammo_missile_spit = create_ammo_missile(
					{0xf58bf614, 0xf837, 0x4377, 0xa6, 0xa8, 0x67, 0x2d, 0x43, 0x18, 0xc, 0xf1},
					"fireboll",
					{{"damage",							0},
					 {"damage_type",					g_damage_type.BURN},
					 {"mass",							1},
					 {"is_visible",						false},
					 {"is_explosive",					true},
					 {"is_explode_on_static_impact",	true},
					 {"is_explode_on_alive_impact",		true},
					 {"effector",						"camera_gomno_expl"},
					 {"explode_effect_name",			"pfx_gomnoed_spit_expl.lua"},
					 {"explode_radius",					4},
					 {"explode_damage",					5},
					 {"explode_time",					1000},
 					 {"explode_impulse",				0.4},
					 {"attached_effect",				"pfx_gomnoed_spit.lua"},
					 });

-------------------------------------------
-- Песня примы
-------------------------------------------
ammo_missile_song, sv_ammo_missile_song, cl_ammo_missile_song = create_ammo_missile(
					{0x191c7ff9, 0xe88e, 0x44e5, 0x9f, 0x79, 0x44, 0x18, 0x6d, 0x40, 0xa1, 0x7c},
					"wpn_granaten_LOD",
					{{"damage",							0},
					 {"damage_type",					g_damage_type.GUNSHOT},
					 {"mass",							5},
					 {"is_explosive",					true},
					 {"is_explode_on_static_impact",	false},
					 {"is_explode_on_alive_impact",		false},
					 {"explode_effect_name",			"pfx_expl_grenade.lua"},
					 {"explode_radius",					7},
					 {"explode_damage",					80},
					 {"explode_impulse",				1},
					 {"explode_time",					2700},
					 });
					 