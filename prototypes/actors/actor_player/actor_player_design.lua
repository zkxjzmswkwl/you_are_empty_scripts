------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Настройки Actor Player'а
------------------------------------------------------------------------

actor_player.guid = {0x63f177bf, 0x1358, 0x49b6, 0x8d, 0x46, 0x17, 0xae, 0x9, 0x7c, 0xc, 0xb2};

actor_player.properties_design = {
	{ "is_player_controlled",	true  },
	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.4	  },
	{ "mass",					70.0  },
	{ "max_health",				100.0 },
	{ "max_armor",				100.0 },

	{ "walk_forward_speed",		150.0 },
	{ "walk_backward_speed",	150.0 },
	{ "walk_strafe_speed",		150.0 },
	{ "run_forward_speed",		200.0 * 1},
	{ "run_backward_speed",		200.0 * 1},
	{ "run_strafe_speed",		200.0 * 1},
	{ "jump_height",			80.0 },
	{ "turn_speed",				{1700.0, 1700.0, 1700.0} }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90			},	-- угол обзора (град) 
	
	{ "material_body_default",		"mat_actor_body"	},
	{ "material_carrier_default",	"mat_actor_carrier"	},

	{ "material_steps",				"mat_actor_human_steps"	},
	{ "material_climb",				"mat_actor_human_climb"	},
	--{ "material_jump",				"mat_actor_human_jump"	},
	{ "material_land",				"mat_actor_human_land"	},
	
	{ "auto_steps",					true },
	{ "min_steps_time",				400 },
	{ "max_steps_time",				500 },
};

--[[	
		Таблица уровней повреждений. 
		
		Каждый элемент таблицы определяет уровень повреждения, получаемый актером.
	При получении повреждения, просматриваются все элементы таблицы.
	Если low <= damage_points <= high, то будет проигран постпроцесс и эффект, указанные 
	в таблице damage_visualization для данного уровня повреждения, учитывая тип повреждения.
	
	damage_visualization:
		ключ		- тип повреждения
		значение	- таблица визуализации типа повреждения
		
	таблица визуализации типа повреждения:
		pp_name		- имя постпроцесса
		effect_name	- имя эффекта
--]]
actor_player.m_damage_levels = {

	-- Уровень повреждения 1
	{
		low		= 0,
		high	= 2,
		damage_visualization = {
			[g_damage_type.FALL] = {
				pp_name		= "damage_FALL_1",
			    effect_name     = "fall1.lua",
			},
			[g_damage_type.GUNSHOT] = {
				pp_name		= "damage_GUNSHOT_1",
			},
			[g_damage_type.KNOCK] = {
				pp_name		= "damage_KNOCK_1",
			},
			[g_damage_type.BLAST] = {
				pp_name		= "damage_BLAST_1",
			},
			[g_damage_type.BURN] = {
				pp_name		= "damage_BURN_1",
			},
			[g_damage_type.SHPR] = {
				pp_name		= "damage_SHPR_1",
			},
			[g_damage_type.TEST] = {
				pp_name		= "damage_TEST_1",
			},
			[g_damage_type.BANG] = {
				pp_name		= "damage_BANG_1",
			},
			[g_damage_type.ELECTRO] = {
				pp_name		= "damage_ELECTRO_1",
			},
		},
	},
	
	-- Уровень повреждения 2
	{
		low		= 3,
		high	= 5,
		damage_visualization = {
			[g_damage_type.FALL] = {
				pp_name		= "damage_FALL_2",
				effect_name     = "fall2.lua",
			},
			[g_damage_type.GUNSHOT] = {
				pp_name		= "damage_GUNSHOT_2",
			},
			[g_damage_type.KNOCK] = {
				pp_name		= "damage_KNOCK_2",
			},
			[g_damage_type.BLAST] = {
				pp_name		= "damage_BLAST_2",
			},
			[g_damage_type.BURN] = {
				pp_name		= "damage_BURN_2",
			},
			[g_damage_type.SHPR] = {
				pp_name		= "damage_SHPR_2",
			},
			[g_damage_type.TEST] = {
				pp_name		= "damage_TEST_2",
			},
			[g_damage_type.BANG] = {
				pp_name		= "damage_BANG_2",
			},
			[g_damage_type.ELECTRO] = {
				pp_name		= "damage_ELECTRO_2",
			},
		},
	},
	
	-- Уровень повреждения 3
	{
		low		= 6,
		high	= 10,
		damage_visualization = {
			[g_damage_type.FALL] = {
				pp_name		= "damage_FALL_3",
				effect_name     = "fall3.lua",
			},
			[g_damage_type.GUNSHOT] = {
				pp_name		= "damage_GUNSHOT_3",
			},
			[g_damage_type.KNOCK] = {
				pp_name		= "damage_KNOCK_3",
			},
			[g_damage_type.BLAST] = {
				pp_name		= "damage_BLAST_3",
			},
			[g_damage_type.BURN] = {
				pp_name		= "damage_BURN_3",
			},
			[g_damage_type.SHPR] = {
				pp_name		= "damage_SHPR_3",
			},
			[g_damage_type.TEST] = {
				pp_name		= "damage_TEST_3",
			},
			[g_damage_type.BANG] = {
				pp_name		= "damage_BANG_3",
			},
			[g_damage_type.ELECTRO] = {
				pp_name		= "damage_ELECTRO_3",
			},
		},
	},
	
	-- Уровень повреждения 4
	{
		low		= 11,
		high	= 20,
		damage_visualization = {
			[g_damage_type.FALL] = {
				pp_name		= "damage_FALL_4",
				effect_name     = "fall4.lua",
			},
			[g_damage_type.GUNSHOT] = {
				pp_name		= "damage_GUNSHOT_4",
			},
			[g_damage_type.KNOCK] = {
				pp_name		= "damage_KNOCK_4",
			},
			[g_damage_type.BLAST] = {
				pp_name		= "damage_BLAST_4",
			},
			[g_damage_type.BURN] = {
				pp_name		= "damage_BURN_4",
			},
			[g_damage_type.SHPR] = {
				pp_name		= "damage_SHPR_4",
			},
			[g_damage_type.TEST] = {
				pp_name		= "damage_TEST_4",
			},
			[g_damage_type.BANG] = {
				pp_name		= "damage_BANG_4",
			},
			[g_damage_type.ELECTRO] = {
				pp_name		= "damage_ELECTRO_4",
			},
		},
	},
	
	-- Уровень повреждения 5
	{
		low		= 21,
		high	= 50,
		damage_visualization = {
			[g_damage_type.FALL] = {
				pp_name		= "damage_FALL_5",
				effect_name     = "fall5.lua",
			},
			[g_damage_type.GUNSHOT] = {
				pp_name		= "damage_GUNSHOT_5",
			},
			[g_damage_type.KNOCK] = {
				pp_name		= "damage_KNOCK_5",
			},
			[g_damage_type.BLAST] = {
				pp_name		= "damage_BLAST_5",
			},
			[g_damage_type.BURN] = {
				pp_name		= "damage_BURN_5",
			},
			[g_damage_type.SHPR] = {
				pp_name		= "damage_SHPR_5",
			},
			[g_damage_type.TEST] = {
				pp_name		= "damage_TEST_5",
			},
			[g_damage_type.BANG] = {
				pp_name		= "damage_BANG_5",
			},
			[g_damage_type.ELECTRO] = {
				pp_name		= "damage_ELECTRO_5",
			},
		},
	},
	
	-- Уровень повреждения 6
	{
		low		= 51,
		high	= 100,
		damage_visualization = {
			[g_damage_type.FALL] = {
				pp_name		= "damage_FALL_6",
				effect_name     = "fall5.lua",
			},
			[g_damage_type.GUNSHOT] = {
				pp_name		= "damage_GUNSHOT_6",
			},
			[g_damage_type.KNOCK] = {
				pp_name		= "damage_KNOCK_6",
			},
			[g_damage_type.BLAST] = {
				pp_name		= "damage_BLAST_6",
			},
			[g_damage_type.BURN] = {
				pp_name		= "damage_BURN_6",
			},
			[g_damage_type.SHPR] = {
				pp_name		= "damage_SHPR_6",
			},
			[g_damage_type.TEST] = {
				pp_name		= "damage_TEST_6",
			},
			[g_damage_type.BANG] = {
				pp_name		= "damage_BANG_6",
			},
			[g_damage_type.ELECTRO] = {
				pp_name		= "damage_ELECTRO_6",
			},
		},
	},
	
	-- Уровень повреждения 7 
	{	
		low		= 101,
		high	= nil, -- верхней границы нет
		damage_visualization = {
			[g_damage_type.FALL] = {
				pp_name		= "damage_FALL_7",
				effect_name     = "fall1.lua",
				effector_name     = "camera_hit",
			},
			[g_damage_type.GUNSHOT] = {
				pp_name		= "damage_GUNSHOT_7",
			},
			[g_damage_type.KNOCK] = {
				pp_name		= "damage_KNOCK_7",
			},
			[g_damage_type.BLAST] = {
				pp_name		= "damage_BLAST_7",
			},
			[g_damage_type.BURN] = {
				pp_name		= "damage_BURN_7",
			},
			[g_damage_type.SHPR] = {
				pp_name		= "damage_SHPR_7",
			},
			[g_damage_type.TEST] = {
				pp_name		= "damage_TEST_7",
			},
			[g_damage_type.BANG] = {
				pp_name		= "damage_BANG_7",
			},
			[g_damage_type.ELECTRO] = {
				pp_name		= "damage_ELECTRO_7",
			},
		},
	},
}

-- Вкл/выкл визуальное отображение при получении повреждений
actor_player.m_visualize_damage = true

-- регенерация hp в секунду
actor_player.m_health_regeneration = 0.0;
