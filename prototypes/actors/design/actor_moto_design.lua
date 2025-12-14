------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev, Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Moto - солдат в мотоциклетных очках
------------------------------------------------------------------------

actor_moto = {};

---------------------------------------------------------------------------------
actor_moto.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"moto" },
	{ "rag_doll_model",			"moto_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		150.0 },
	{ "walk_backward_speed",	150.0 },
	{ "walk_strafe_speed",		90.0  },
	{ "run_forward_speed",		340.0 },
	{ "run_backward_speed",		280.0 },
	{ "run_strafe_speed",		240.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{700.0, 700.0, 700.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90		},	-- угол обзора (град) 
	{ "view_dist",				170		},	-- максимальная дальность зрения (м)
	
    { "turn_hands",				3       },	--// 0 - none, 1 - right, 2 - left, 3 - both
	{ "allow_head_turn",		true    },
	
	{ "ignore_insuperable_danger", 	false   }, -- реагировать на гранаты
	
	{ "material_steps",	 "mat_actor_human_steps"	},
	
	{ "vision_fade_in_time",			0 },
    { "vision_fade_out_time",			0 },
});
---------------------------------------------------------------------------------
actor_moto.params = {
	-- варианты моделек
	--model_variants = {"pepe" , "pepe", "pepe"};

	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 2000,
	
	-- Количество выстрелов в очереди.
	burst_size			= 5,--= 15,
	-- кол-во патронов в обойме
	clip_size			= 20,--= 71,
	
	-- расстояние отступления
	retreat_dist = 14,
	-- расстояние преследования
	chase_dist = 7,
	-- расстояние стрейфа
	dodge_dist = 5,
	-- время стрейфа в одну сторону
	dodge_time = 1000,
	
	-- состояния в которых будут звучать шаги
	states_with_step_callbacks = {"forward_walk", "backward_walk", 
								"strafe_left_walk", "strafe_right_walk",
								"forward_run", "backward_run", 
								"strafe_left_run", "strafe_right_run"},
};

------------------------------------
actor_moto.config_states = {
};

actor_moto.config_states["sit"] = {
	["idle"] = "idle_sit",
	["idle_alert"] = "idle_sit",
	["reload"] = "reload_sit",
	["pain"] = "pain_sit",
};

actor_moto.config_states["reload_sit"] = {
	["reload"] = "reload_sit",
};
------------------------------------

-- настройки hitbox-ов
actor_moto.params.hitboxes = { 
	{name = "head", damage_k = 1.45, },
	{name = "pelvis", damage_k = .8, },
    {name = "rupperArm1", damage_k = .25, },
    {name = "rupperArm2", damage_k = .35, },
    {name = "spine", damage_k = .8, },
    {name = "spine2", damage_k = .8, },
    {name = "lupperArm1", damage_k = .25, },
    {name = "lupperArm2", damage_k = .35, },
    {name = "lthigh1", damage_k = .4, },
    {name = "lthigh2", damage_k = .35, },
    {name = "rthigh1", damage_k = .4, },
    {name = "rthigh2", damage_k = .35, },
};

-- параметры атаки
actor_moto.params.attack_info = {};


-- Атака на бегу
actor_moto.params.attack_info[0] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 100,
	dist				= 30,
	
	desired_min_dist	= 6, 
	desired_max_dist	= 50, 
	max_angle			= 6, 
	
	stop_during_attack	= 0,
	turn_body_to_enemy	= 1,
	
	priority = 1, 
		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 5,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
	
	--pause_between_attacks = 2000, -- пауза между атаками такого типа
		
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_run",
};

-- Атака стоя , будет использоваться только в якорях с block_movement = true
actor_moto.params.attack_info[1] = {
	type				= ATTACK_DISTANT,
	
	real_min_dist		= 5,
	real_max_dist		= 100,
	dist				= 30,
	
	desired_min_dist	= 6, 
	desired_max_dist	= 170, 
	
	max_angle			= 6, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	priority = 0, 
			
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 8,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"]	= {"pfx_shot_soldier.lua"},
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack",

};


-- [[

-- Бросок гранаты
actor_moto.params.attack_info[2] = {
	type				= ATTACK_DISTANT,
	dist				= 15,
	
	desired_min_dist	= 7, 
	desired_max_dist	= 15,  
	
	critical_min_dist	= 6,	
	
	max_angle			= 25, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	priority			= 2, 
	
	
	dispersion			= 0,
	offset_pos			= {-0.3, 1.1, 1.70},
	
	missile						= "ammo_missile_grenade",
	missile_velocity			= 1000,
	missile_angular_velocity	= {0, 10, 0},
	
	
	pause_between_attacks = 10000, -- пауза между атаками такого типа
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile",
};

-- ближняя атака
actor_moto.params.attack_info["melee"] = {
		type				= ATTACK_MELEE,
		dist				= 2, 
		real_min_dist		= 1.2, 
		real_max_dist		= 2.2, 
		desired_min_dist	= 0,
		desired_max_dist	= 3, 
		max_angle			= 6,
		
		stop_during_attack	= 1,
		turn_body_to_enemy	= 1,
		
		priority = 3, 
		pause_between_attacks = 4000, -- пауза между атаками такого типа
		
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 25,
		impulse				= 1,
		dispersion			= 0,
		offset_pos			= {0, 0, 0.70},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack_melee",
};


-------------------------------------------
-- атаки для якорей
-------------------------------------------

-- атака стоя , будет использоваться только в якорях, с visual_config = "sit"
actor_moto.params.attack_info["from_cover"] = {
	type				= ATTACK_DISTANT,
	
	real_min_dist		= 5,
	real_max_dist		= 100,
	dist				= 30,
	
	desired_min_dist	= 6, 
	desired_max_dist	= 170, 
	
	max_angle			= 6, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	priority = 0, 
	
	burst_size = 10,			-- количество выстрелов в очереди для данной атаки
	burst_size_random_add = 5,  -- к количеству добавляем случайно еще (от 0 до N)
	
	pause_between_attacks	= 4000, 			-- пауза между атаками такого типа
	pause_between_attacks_random_add = 3000,	-- к паузе добавляем случайно время (от 0 до X)

			
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 8,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"]	= {"pfx_shot_soldier.lua"},
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack",

};


-- атака сидя
actor_moto.params.attack_info["sit"] = {
	type				= ATTACK_DISTANT,
	
	real_min_dist		= 5,
	real_max_dist		= 100,
	dist				= 30,
	
	desired_min_dist	= 6, 
	desired_max_dist	= 170, 
	
	max_angle			= 6, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	priority = 0, 
			
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 8,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"]	= {"pfx_shot_soldier.lua"},
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_sit",
};


-- стрельба из-за угла слева
actor_moto.params.attack_info[3] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 150,
	dist				= 50,
	desired_min_dist	= 0, 
	desired_max_dist	= 170, 
	max_angle			= 6, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	pause_between_attacks	= 4000, 			-- пауза между атаками такого типа
	pause_between_attacks_random_add = 3000,	-- к паузе добавляем случайно время (от 0 до X)
	
	burst_size_random_add = 5,  -- к количеству  выстрелов в очереди добавляем случайно еще (от 0 до N)

		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 8.5,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
	
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_corner_left",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};

-- стрельба из-за угла справа
actor_moto.params.attack_info[4] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 150,
	dist				= 50,
	desired_min_dist	= 0, 
	desired_max_dist	= 170, 
	max_angle			= 6, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	
	pause_between_attacks	= 4000, 			-- пауза между атаками такого типа
	pause_between_attacks_random_add = 3000,	-- к паузе добавляем случайно время (от 0 до X)
	
	burst_size_random_add = 5,  -- к количеству  выстрелов в очереди добавляем случайно еще (от 0 до N)

			
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 8.5,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
	
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_corner_right",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};

-- бросок гранаты слева
actor_moto.params.attack_info[5] = {
	type				= ATTACK_DISTANT,
	dist				= 15,
	desired_min_dist	= 7, 
	desired_max_dist	= 15,  
	max_angle			= 25, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	dispersion			= 0,
	offset_pos			= {1, 1, 1.70},
	
	missile						= "ammo_missile_grenade",
	missile_velocity			= 1000,
	missile_angular_velocity	= {0, 10, 0},
	
	pause_between_attacks = 6000, -- пауза между атаками такого типа
	pause_between_attacks_random_add = 4000,	-- к паузе добавляем случайно время (от 0 до X)

	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile_corner_left",

	not_allowed			= true,
	allow_blind_attack	= true,
};

-- бросок гранаты справа
actor_moto.params.attack_info[6] = {
	type				= ATTACK_DISTANT,
	dist				= 15,
	desired_min_dist	= 7, 
	desired_max_dist	= 15,  
	max_angle			= 25, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	dispersion			= 0,
	offset_pos			= {-1, 1, 1.70},
	
	missile						= "ammo_missile_grenade",
	missile_velocity			= 1000,
	missile_angular_velocity	= {0, 10, 0},
	
	pause_between_attacks = 6000, -- пауза между атаками такого типа
	pause_between_attacks_random_add = 4000,	-- к паузе добавляем случайно время (от 0 до X)

	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile_corner_right",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};




---------------------------------------------------------------------------------
-- состояние тела
actor_moto.params.body_states_transistions = {};
actor_moto.params.body_states_transistions[NORMAL_BODY_STATE] = {};
actor_moto.params.body_states_transistions[SIT_BODY_STATE] = {};
actor_moto.params.body_states_transistions[LEFT_SLOPE_BODY_STATE] = {};
actor_moto.params.body_states_transistions[RIGHT_SLOPE_BODY_STATE] = {};

actor_moto.params.body_states_transistions[NORMAL_BODY_STATE][SIT_BODY_STATE] = "transition_stay_to_sit";
actor_moto.params.body_states_transistions[SIT_BODY_STATE][NORMAL_BODY_STATE] = "transition_sit_to_stay";
actor_moto.params.body_states_transistions[NORMAL_BODY_STATE][LEFT_SLOPE_BODY_STATE] = "slope_corner_left_begin";
actor_moto.params.body_states_transistions[LEFT_SLOPE_BODY_STATE][NORMAL_BODY_STATE] = "slope_corner_left_end";
actor_moto.params.body_states_transistions[NORMAL_BODY_STATE][RIGHT_SLOPE_BODY_STATE] = "slope_corner_right_begin";
actor_moto.params.body_states_transistions[RIGHT_SLOPE_BODY_STATE][NORMAL_BODY_STATE] = "slope_corner_right_end";

actor_moto.states_design = {};

--------------------
-- IDLE
--------------------
actor_moto.states_design["idle"] = {
			{anim = "idle1_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common},
			{anim = "idle2_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common},
			{anim = "idle3_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common},
			};
			
			

--------------------
-- IDLE ALERT
--------------------
actor_moto.states_design["idle_alert"] = {
			{anim = "idle4_p1", weight = 1, snd = " ", snd_params = snd_actor_common},
			{anim = "idle5_p1", weight = 1, snd = " ", snd_params = snd_actor_common},
			{anim = "alert_p1", weight = 1, snd = " ", snd_params = snd_actor_common},
			};
			
-------------------------------------------------------------
-- TRANSITION TO IDLE ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_moto.states_design["transition_to_alert"] = {
			{weight = 1, snd = "moto_alert1", snd_params = snd_actor_alert},
			{weight = 1, snd = "moto_alert2", snd_params = snd_actor_alert},
			{weight = 1, snd = "moto_alert3", snd_params = snd_actor_alert},
			{weight = 1, snd = "moto_alert4", snd_params = snd_actor_alert},
			{weight = 1, snd = "moto_alert5", snd_params = snd_actor_alert},
			{weight = 1, snd = "moto_alert6", snd_params = snd_actor_alert},
			{weight = 1, snd = "moto_alert7", snd_params = snd_actor_alert},
};

			
--------------------
-- PAIN
--------------------
actor_moto.states_design["pain"] = {
			{anim = "pain1_p1", weight = 1, snd = "moto_pain1", snd_params = snd_actor_pain},
			{anim = "pain2_p1", weight = 1, snd = "moto_pain2", snd_params = snd_actor_pain},
			{anim = "pain3_p1", weight = 1, snd = "moto_pain3", snd_params = snd_actor_pain},
	                {anim = "pain4_p1", weight = 1, snd = "moto_pain4", snd_params = snd_actor_pain},
 	                {anim = "pain5_p1", weight = 1, snd = "moto_pain5", snd_params = snd_actor_pain},
	                {anim = "pain5_p1", weight = 1, snd = "moto_pain6", snd_params = snd_actor_pain},
};
			
--------------------
-- WALK			
--------------------
actor_moto.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common, weight = 50},
};

actor_moto.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common},};
actor_moto.states_design["strafe_left_walk"] = {
			{anim = "run_l", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common},};
actor_moto.states_design["strafe_right_walk"] = {
			{anim = "run_r", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common},};
--------------------
-- RUN
--------------------
actor_moto.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common, weight = 50},
};
actor_moto.states_design["backward_run"] = {
			{anim = "run_back", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common},};
actor_moto.states_design["strafe_left_run"] = {
			{anim = "l", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common},};
actor_moto.states_design["strafe_right_run"] = {
			{anim = "r", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_moto.states_design["jump_prepare"] = {
			{anim = "jamp6", anim_speed = 1.0, snd = " ", snd_params = snd_actor_common},};
-- начало прыжка			
actor_moto.states_design["jump_begin"] = {
			{anim = "jamp7", anim_speed = 1.0, snd = " ", snd_params = snd_actor_common},};			

-- зацикленная анимация состояния падения
actor_moto.states_design["fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = " ", snd_params = snd_actor_common},};

-- приземление на бегу
actor_moto.states_design["land_run"] = {
			{anim = "jamp_4run", anim_speed = 1, snd = " ", snd_params = snd_actor_common},};
-- приземление на месте
actor_moto.states_design["land_stand"] = {
			{anim = "jamp5", anim_speed = 1, snd = " ", snd_params = snd_actor_common},};
			
----------------------------
-- ATTACK
----------------------------
actor_moto.states_design["attack_begin"] = {
			{snd = "moto_attack1", snd_params = snd_actor_alert},
			{snd = "moto_attack2", snd_params = snd_actor_alert},
			{snd = "moto_attack3", snd_params = snd_actor_alert},
			{snd = "moto_attack4", snd_params = snd_actor_alert},
			{snd = "moto_attack5", snd_params = snd_actor_alert},
			{snd = "moto_attack6", snd_params = snd_actor_alert},
			{snd = "moto_attack7", snd_params = snd_actor_alert},
			{snd = "moto_attack8", snd_params = snd_actor_alert},
			{snd = "moto_attack9", snd_params = snd_actor_alert},
			{snd = "moto_attack10", snd_params = snd_actor_alert},
};

actor_moto.states_design["attack_shooting"] = {
			{anim = "attack1_p1", anim_speed = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot},
			{anim = "attack1_p1", anim_speed = 1, snd = "ppsha_fire2", snd_params = snd_actor_shot},
			{anim = "attack1_p1", anim_speed = 1, snd = "ppsha_fire3", snd_params = snd_actor_shot},
			{anim = "attack1_p1", anim_speed = 1, snd = "ppsha_fire4", snd_params = snd_actor_shot},
};

----------------------------
-- ATTACK RUN
----------------------------
actor_moto.states_design["attack_run_begin"] = actor_moto.states_design["attack_begin"];
			
actor_moto.states_design["attack_run_shooting"] = {
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot, weight = 1},
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "ppsha_fire2", snd_params = snd_actor_shot, weight = 1},
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "ppsha_fire3", snd_params = snd_actor_shot, weight = 1},
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "ppsha_fire4", snd_params = snd_actor_shot, weight = 1},
};
			
--actor_moto.states_design["attack_run_end"] = {
--			{anim = "run_attack", anim_speed = 1, weight = 1},
--};


		
----------------------------
-- ATTACK MISSILE
----------------------------
actor_moto.states_design["attack_missile_begin"] = {
			{anim = "granata_p1", anim_speed = 1, snd = "moto_granata_p1", snd_params = snd_actor_shot},
			{anim = "granata_p1", anim_speed = 1, snd = "moto_granata_p1", snd_params = snd_actor_shot},
			{anim = "granata_p1", anim_speed = 1, snd = "moto_granata_p1", snd_params = snd_actor_shot},
			{anim = "granata_p1", anim_speed = 1, snd = "moto_granata_p1", snd_params = snd_actor_shot},
			{anim = "granata_p1", anim_speed = 1, snd = "moto_granata_p1", snd_params = snd_actor_shot},
};

actor_moto.states_design["attack_missile_end"] = {
			{anim = "granata_p1_out", snd = "moto_attack3", snd_params = snd_actor_attack},
			{anim = "granata_p1_out", snd = "moto_attack4", snd_params = snd_actor_attack},
			{anim = "granata_p1_out", weight = 1},
};

----------------------------
-- ATTACK CORNER LEFT
----------------------------
actor_moto.states_design["slope_corner_left_begin"] = {
			{anim = "ugol_l1", anim_speed = 1, weight = 1},
			};
actor_moto.states_design["slope_corner_left_end"] = {
			{anim = "ugol_l3_out", anim_speed = 1, weight = 1},
			};
	
			
actor_moto.states_design["attack_corner_left_shooting"] = {
			body_state = LEFT_SLOPE_BODY_STATE,
			snd_params = snd_actor_shot, 
			--anim_blend_in_time = 400, 
			--anim_blend_out_time = 400,
			{anim = "ugol_l2_1", anim_speed = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot},
			{anim = "ugol_l2_2", anim_speed = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot},
			{anim = "ugol_l2_3", anim_speed = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot},
			};
						


----------------------------
-- ATTACK CORNER RIGHT
----------------------------		
actor_moto.states_design["slope_corner_right_begin"] = {
			{anim = "ugol_r1", anim_speed = 1, weight = 1},
			};
actor_moto.states_design["slope_corner_right_end"] = {
			{anim = "ugol_r3_out", anim_speed = 1, weight = 1},
			};			
			
actor_moto.states_design["attack_corner_right_shooting"] = {
			body_state = RIGHT_SLOPE_BODY_STATE,
			snd_params = snd_actor_shot, 
			--anim_blend_in_time = 400, 
			--anim_blend_out_time = 400,
			{anim = "ugol_r2_1", anim_speed = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot},
			{anim = "ugol_r2_2", anim_speed = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot},
			{anim = "ugol_r2_3", anim_speed = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot},
			};
			
							
----------------------------
-- ATTACK MISSILE CORNER
----------------------------
actor_moto.states_design["attack_missile_corner_left_begin"] = {
			{anim = "ugol_l_granata", anim_speed = 1, snd = "moto_ugol_l_granata", snd_params = snd_actor_attack},
};

actor_moto.states_design["attack_missile_corner_left_end"] = {
			{anim = "ugol_l_granata_out"},};
			
actor_moto.states_design["attack_missile_corner_right_begin"] = {
			{anim = "ugol_R_granata", anim_speed = 1, snd = "moto_ugol_R_granata", snd_params = snd_actor_attack},
};

actor_moto.states_design["attack_missile_corner_right_end"] = {
			{anim = "ugol_R_granata_out"},};

			
----------------------------
-- ATTACK MELEE
----------------------------			
actor_moto.states_design["attack_melee_begin"] = {
			{anim = "attack11_udar1_p1", anim_speed = 1, snd = "moto_attack11_udar1_p1", snd_params = snd_actor_attack},
			{anim = "attack14_udar2_p1", anim_speed = 1, snd = "moto_attack14_udar2_p1", snd_params = snd_actor_attack},
			};

actor_moto.states_design["attack_melee_end"] = {
			{anim = "attack11_udar1_p1_out", anim_speed = 1,},
			{anim = "attack14_udar2_p1_out", anim_speed = 1,},
			};
						
----------------------------
-- RELOAD
----------------------------
actor_moto.states_design["reload"] = {
			primary_bone_group = TORSO_BONE_GROUP,
			{anim = "reload_p1", anim_speed = 1.5, snd = "Ded_reload1_attack", snd_params = snd_actor_common},
};
			
--------------------------------------------------------
-- Переходы из стоячего положения в сидячее и обратно
--------------------------------------------------------
actor_moto.states_design["transition_stay_to_sit"] = {
			{anim = "perehod_p1_p2", anim_speed = 1.5, snd = "Ded_reload1_attack", snd_params = snd_actor_common},};
actor_moto.states_design["transition_sit_to_stay"] = {
			{anim = "perehod_p2_p1", anim_speed = 1.5, snd = "Ded_reload1_attack", snd_params = snd_actor_common},};

		
--------------------
-- IDLE CONVOY
--------------------

actor_moto.states_design["idle_convoy_left"] = {
			{anim = "idle1_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common, weight = 4},
			{anim = "idle_konvoy1", snd = "moto_attack7", snd_params = snd_actor_common, weight = 1},
			{anim = "idle2_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common, weight = 4},
			{anim = "idle_konvoy2", snd = "moto_attack2", snd_params = snd_actor_common, weight = 1},
			{anim = "idle1_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common, weight = 4},
			{anim = "idle_konvoy1", snd = "moto_attack1", snd_params = snd_actor_common, weight = 1},
			{anim = "idle2_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common, weight = 4},
			{anim = "idle_konvoy2", snd = "moto_alert3", snd_params = snd_actor_common, weight = 1},
			};			
			
actor_moto.states_design["idle_convoy_right"] = {
			{anim = "idle1_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common, weight = 4},
			{anim = "idle_konvoy4", snd = "moto_attack7", snd_params = snd_actor_common, weight = 1},
			{anim = "idle1_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common, weight = 4},
			{anim = "idle_konvoy4", snd = "moto_attack2", snd_params = snd_actor_common, weight = 1},
			{anim = "idle1_p1", anim_speed = 1, snd = " ", weight = 1, snd_params = snd_actor_common, weight = 4},
			{anim = "idle_konvoy4", snd = "moto_alert3", snd_params = snd_actor_common, weight = 1},
		};

----------------------------
-- DEATH
----------------------------
actor_moto.states_design["death"] = {
			{snd = "moto_death1", snd_params = snd_actor_death},
			{snd = "moto_death2", snd_params = snd_actor_death},
			{snd = "moto_death3", snd_params = snd_actor_death},
			{snd = "moto_death4", snd_params = snd_actor_death},
};

			
	

-----------------------------------------------------------------------------
-- SITTING STATE
-----------------------------------------------------------------------------

--------------------
-- IDLE SIT
-------------------
actor_moto.states_design["idle_sit"] = {
			body_state = SIT_BODY_STATE,
			{anim = "idle_sit", anim_speed = 0.1, snd = " ", snd_params = snd_actor_common},
			};


----------------------------
-- ATTACK SIT
----------------------------
actor_moto.states_design["attack_sit_shooting"] = {
			body_state = SIT_BODY_STATE,
			{anim = "attack6_p2", anim_speed = 1, weight = 1, snd = "ppsha_fire1", snd_params = snd_actor_shot, weight = 1},
			{anim = "attack6_p2", anim_speed = 1, weight = 1, snd = "ppsha_fire2", snd_params = snd_actor_shot, weight = 1},
			{anim = "attack6_p2", anim_speed = 1, weight = 1, snd = "ppsha_fire3", snd_params = snd_actor_shot, weight = 1},
			{anim = "attack6_p2", anim_speed = 1, weight = 1, snd = "ppsha_fire4", snd_params = snd_actor_shot, weight = 1},
			};
			
--------------------
-- PAIN SIT
--------------------
actor_moto.states_design["pain_sit"] = {
			body_state = SIT_BODY_STATE,
			{anim = "pain6_p2", weight = 1, snd = " ", snd_params = snd_actor_pain},
			{anim = "pain7_p2", weight = 1, snd = " ", snd_params = snd_actor_pain},
			{anim = "pain8_p2", weight = 1, snd = " ", snd_params = snd_actor_pain},
            };
            
----------------------------
-- RELOAD SIT
----------------------------
actor_moto.states_design["reload_sit"] = {
			block_movement = true,
			body_state = SIT_BODY_STATE,
			{anim = "reload_p2", anim_speed = 1.7, snd = "Ded_reload1_attack", snd_params = snd_actor_common},
			};