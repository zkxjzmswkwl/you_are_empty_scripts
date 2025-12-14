------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Nail - 
------------------------------------------------------------------------

actor_nail = {};

---------------------------------------------------------------------------------
actor_nail.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"ril" },
	{ "rag_doll_model",			"ril_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		150.0 },
	{ "walk_backward_speed",	150.0 },
	{ "walk_strafe_speed",		80.0  },
	{ "run_forward_speed",		230.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{700.0, 700.0, 700.0}  }, -- угловая скорость поворота

	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				20	  },	-- максимальная дальность зрения (м)
	
	{ "ignore_insuperable_danger", 	false   }, -- реагировать на гранаты
});
---------------------------------------------------------------------------------
actor_nail.params = {

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
	burst_size			= 5, 
	-- кол-во патронов в обойме
	clip_size			= 20, 
	
	-- расстояние отступления
	retreat_dist = 9,
	-- расстояние преследования
	chase_dist = 5,
	-- расстояние стрейфа
	dodge_dist = 7,
	-- время стрейфа в одну сторону
	dodge_time = 2000,
};

-- настройки hitbox-ов
actor_nail.params.hitboxes = { 
	{name = "head", damage_k = 1.7, },
	{name = "pelvis", damage_k = 1, },
    {name = "rupperArm1", damage_k = .3, },
    {name = "rupperArm2", damage_k = .45, },
    {name = "spine", damage_k = 1, },
    {name = "spine3", damage_k = 1, },
    {name = "lupperArm1", damage_k = .3, },
    {name = "lupperArm2", damage_k = .45, },
    {name = "lthigh1", damage_k = .5, },
    {name = "lthigh2", damage_k = .45, },
    {name = "rthigh1", damage_k = .5, },
    {name = "rthigh2", damage_k = .45, },
};


------------------------------------
-- состояние тела
actor_nail.params.body_states_transistions = {};
actor_nail.params.body_states_transistions[NORMAL_BODY_STATE] = {};
actor_nail.params.body_states_transistions[SIT_BODY_STATE] = {};
actor_nail.params.body_states_transistions[LEFT_SLOPE_BODY_STATE] = {};
actor_nail.params.body_states_transistions[RIGHT_SLOPE_BODY_STATE] = {};

actor_nail.params.body_states_transistions[NORMAL_BODY_STATE][SIT_BODY_STATE] = "transition_stay_to_sit";
actor_nail.params.body_states_transistions[SIT_BODY_STATE][NORMAL_BODY_STATE] = "transition_sit_to_stay";
actor_nail.params.body_states_transistions[NORMAL_BODY_STATE][LEFT_SLOPE_BODY_STATE] = "slope_corner_left_begin";
actor_nail.params.body_states_transistions[LEFT_SLOPE_BODY_STATE][NORMAL_BODY_STATE] = "slope_corner_left_end";
actor_nail.params.body_states_transistions[NORMAL_BODY_STATE][RIGHT_SLOPE_BODY_STATE] = "slope_corner_right_begin";
actor_nail.params.body_states_transistions[RIGHT_SLOPE_BODY_STATE][NORMAL_BODY_STATE] = "slope_corner_right_end";

------------------------------------
actor_nail.config_states = {
};

actor_nail.config_states["sit"] = {
	["idle"] = "idle_sit",
	["idle_alert"] = "idle_sit",
	["reload"] = "reload_sit",
	["pain"] = "pain_sit",
};

actor_nail.config_states["reload_sit"] = {
	["reload"] = "reload_sit",
};
------------------------------------


-- параметры атаки
actor_nail.params.attack_info = {};


-- Атака на бегу
actor_nail.params.attack_info[0] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 100,
	
	dist				= 30,
	
	desired_min_dist	= 6, 
	desired_max_dist	= 50, 
	max_angle			= 6, 
	
	stop_during_attack	= 0,
	turn_body_to_enemy	= 1,
	
	priority			= 1,
		
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

-- Атака стоя
actor_nail.params.attack_info[1] = {
	type				= ATTACK_DISTANT,

	real_min_dist		= 5,
	real_max_dist		= 50,
	dist				= 30,
	desired_min_dist	= 0, 
	desired_max_dist	= 70, 
	max_angle			= 6, 

	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	burst_size_random_add = 5,  -- к количеству добавляем случайно еще (от 0 до N)

	
	priority			= 0,
		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 5,
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
actor_nail.params.attack_info[2] = {
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
	offset_pos			= {-0.3, 1.3, 1.70},
	
	missile						= "ammo_missile_grenade",
	missile_velocity			= 1000,
	missile_angular_velocity	= {0, 10, 0},
	
	pause_between_attacks = 10000, -- пауза между атаками такого типа
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile",
};

-- стрельба из-за угла слева
actor_nail.params.attack_info[3] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 50,
	dist				= 50,
	desired_min_dist	= 0, 
	desired_max_dist	= 70, 
	max_angle			= 6, 

	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,	
	
	pause_between_attacks	= 3000, 			-- пауза между атаками такого типа
	pause_between_attacks_random_add = 2000,	-- к паузе добавляем случайно время (от 0 до X)

		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 5,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
-- [[	
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
--]]
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_corner_left",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};

-- стрельба из-за угла справа
actor_nail.params.attack_info[4] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 50,
	dist				= 50,
	desired_min_dist	= 0, 
	desired_max_dist	= 70, 
	max_angle			= 6, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,
	
	burst_size_random_add = 5,  -- к количеству добавляем случайно еще (от 0 до N)
	
	pause_between_attacks	= 3000, 			-- пауза между атаками такого типа
	pause_between_attacks_random_add = 2000,	-- к паузе добавляем случайно время (от 0 до X)

		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 5,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
-- [[	
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
--]]
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_corner_right",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};

-- бросок гранаты слева
actor_nail.params.attack_info[5] = {
	type				= ATTACK_DISTANT,
	dist				= 15,
	desired_min_dist	= 7, 
	desired_max_dist	= 30,  
	max_angle			= 25, 
	stop_during_attack	= 1,
	
	dispersion			= 0,
	offset_pos			= {1, 1.5, 1.70},
	
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
actor_nail.params.attack_info[6] = {
	type				= ATTACK_DISTANT,
	dist				= 15,
	desired_min_dist	= 7, 
	desired_max_dist	= 30,  
	max_angle			= 25, 
	
	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,	
	
	dispersion			= 0,
	offset_pos			= {-1.3, 1.5, 1.70},
	
	missile						= "ammo_missile_grenade",
	missile_velocity			= 1000,
	missile_angular_velocity	= {0, 10, 0},
	
	pause_between_attacks = 6000, -- пауза между атаками такого типа
	pause_between_attacks_random_add = 4000, -- к паузе добавляем случайно время (от 0 до X)

	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile_corner_right",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};

-- ближняя атака
actor_nail.params.attack_info["melee"] = {
		type				= ATTACK_MELEE,
		dist				= 2, 
		real_min_dist		= 1.2, 
		real_max_dist		= 2.2, 
		desired_min_dist	= 0,
		desired_max_dist	= 3, 
		max_angle			= 6,
		
		stop_during_attack	= 1,
		turn_body_to_enemy	= 1,
		
		priority			= 3,
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 25,
		impulse				= 1,
		dispersion			= 0,
		offset_pos			= {0, 0, 0.70},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack_melee",
};


-- стрельба сидя
actor_nail.params.attack_info["sit"] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 50,
	dist				= 50,
	desired_min_dist	= 0, 
	desired_max_dist	= 70, 
	max_angle			= 6, 

	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,	
	
	burst_size_random_add = 5,  -- к количеству добавляем случайно еще (от 0 до N)
	
	--pause_between_attacks	= 3000, 			-- пауза между атаками такого типа
	--pause_between_attacks_random_add = 2000,	-- к паузе добавляем случайно время (от 0 до X)

		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 5,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
-- [[	
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
--]]
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_sit",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};

-- стрельба из-за укрытия
actor_nail.params.attack_info["from_cover"] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 5,
	real_max_dist		= 50,
	dist				= 50,
	desired_min_dist	= 0, 
	desired_max_dist	= 70, 
	max_angle			= 6, 

	stop_during_attack	= 1,
	turn_body_to_enemy	= 1,	
	
	burst_size_random_add = 5,  -- к количеству добавляем случайно еще (от 0 до N)
	
	pause_between_attacks	= 5000, 			-- пауза между атаками такого типа
	pause_between_attacks_random_add = 3000,	-- к паузе добавляем случайно время (от 0 до X)

		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 5,
	impulse				= 0.5,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 1,
-- [[	
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
--]]
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack",
	
	not_allowed			= true,
	allow_blind_attack	= true,
};

---------------------------------------------------------------------------------
actor_nail.states_design = {};

--------------------
-- IDLE
--------------------
actor_nail.states_design["idle"] = {
			{anim = "idle1_p1", anim_speed = 1, snd = "Organ_idle1_p1", weight = 1},
			{anim = "idle2_p1", anim_speed = 1, snd = "Organ_idle1_p2", weight = 1},
			{anim = "idle3_p1", anim_speed = 1, snd = "Organ_idle1_p3", weight = 1},
			};
			
			

--------------------
-- IDLE ALERT
--------------------
actor_nail.states_design["idle_alert"] = {
			{anim = "idle4_p1", weight = 1, snd = "Organ_idle1_p4"},
			{anim = "idle5_p1", weight = 1, snd = "Organ_idle5"},
			{anim = "alert_p1", weight = 1, snd = "Organ_idle5"},
			};
			
-------------------------------------------------------------
-- TRANSITION TO IDLE ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_nail.states_design["transition_to_alert"] = {
			{weight = 1, snd = "fireman_klich", snd_params = snd_actor_alert},
			};

			
--------------------
-- PAIN
--------------------
actor_nail.states_design["pain"] = {
			{anim = "pain1_p1", weight = 1, snd = "Organ_pain1", snd_params = snd_actor_pain},
			{anim = "pain2_p1", weight = 1, snd = "Organ_pain2", snd_params = snd_actor_pain},
			{anim = "pain3_p1", weight = 1, snd = "Organ_pain3", snd_params = snd_actor_pain},
            {anim = "pain4_p1", weight = 1, snd = "Organ_pain1", snd_params = snd_actor_pain},
            {anim = "pain5_p1", weight = 1, snd = "Organ_pain2", snd_params = snd_actor_pain},
            };
			
--------------------
-- WALK			
--------------------
actor_nail.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_walk"},};
actor_nail.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_walk"},};
actor_nail.states_design["strafe_left_walk"] = {
			{anim = "run_l", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_walk"},};
actor_nail.states_design["strafe_right_walk"] = {
			{anim = "run_r", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_walk"},};
--------------------
-- RUN
--------------------
actor_nail.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_run"},};
actor_nail.states_design["backward_run"] = {
			{anim = "run_back", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_run"},};
actor_nail.states_design["strafe_left_run"] = {
			{anim = "run_l", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_run"},};
actor_nail.states_design["strafe_right_run"] = {
			{anim = "run_r", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_nail.states_design["jump_prepare"] = {
			{anim = "jamp6", anim_speed = 1.0, snd = "Organ_run"},};
-- начало прыжка			
actor_nail.states_design["jump_begin"] = {
			{anim = "jamp7", anim_speed = 1.0, snd = "Organ_run"},};			

-- зацикленная анимация состояния падения
actor_nail.states_design["fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_run"},};

-- приземление на бегу
actor_nail.states_design["land_run"] = {
			{anim = "jamp_4run", anim_speed = 1, snd = "Organ_run"},};
-- приземление на месте
actor_nail.states_design["land_stand"] = {
			{anim = "jamp5", anim_speed = 1, snd = "Organ_run"},};
			
----------------------------
-- ATTACK
----------------------------
actor_nail.states_design["attack_shooting"] = {
			{anim = "attack1_p1", anim_speed = 1, snd = "nailgun_fire1", snd_params = snd_actor_shot},
			{anim = "attack2_p1", anim_speed = 1, snd = "nailgun_fire2", snd_params = snd_actor_shot},
			{anim = "attack3_p1", anim_speed = 1, snd = "nailgun_fire3", snd_params = snd_actor_shot},
			{anim = "attack4_p1", anim_speed = 1, snd = "nailgun_fire4", snd_params = snd_actor_shot},
			{anim = "attack5_p1", anim_speed = 1, snd = "nailgun_fire1", snd_params = snd_actor_shot},
			{anim = "attack1_p1", anim_speed = 1, snd = "nailgun_fire2", snd_params = snd_actor_shot},
};

----------------------------
-- ATTACK RUN
----------------------------
actor_nail.states_design["attack_run_shooting"] = {
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "nailgun_fire1", snd_params = snd_actor_shot},
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "nailgun_fire2", snd_params = snd_actor_shot},
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "nailgun_fire3", snd_params = snd_actor_shot},
			{anim = "run_attack2", anim_speed = 1, weight = 1, snd = "nailgun_fire4", snd_params = snd_actor_shot},
};
			
----------------------------
-- ATTACK MISSILE
----------------------------
actor_nail.states_design["attack_missile_begin"] = {
			{anim = "granata_p1", anim_speed = 1, snd = "SportsMan_atak 2", snd_params = snd_actor_attack},};

actor_nail.states_design["attack_missile_end"] = {
			{anim = "granata_p1_out"},};

----------------------------
-- ATTACK CORNER LEFT
----------------------------
actor_nail.states_design["slope_corner_left_begin"] = {
			{anim = "ugol_l1", anim_speed = 1, weight = 1},
			};
			
actor_nail.states_design["slope_corner_left_end"] = {
			{anim = "ugol_l3_out", anim_speed = 1, weight = 1},
			};

actor_nail.states_design["attack_corner_left_shooting"] = {
			body_state = LEFT_SLOPE_BODY_STATE,
			{anim = "ugol_l2_1", anim_speed = 1, snd = "nailgun_fire1", snd_params = snd_actor_shot},
			{anim = "ugol_l2_2", anim_speed = 1, snd = "nailgun_fire2", snd_params = snd_actor_shot},
			{anim = "ugol_l2_3", anim_speed = 1, snd = "nailgun_fire3", snd_params = snd_actor_shot},
			};
						

----------------------------
-- ATTACK CORNER RIGHT
----------------------------
actor_nail.states_design["slope_corner_right_begin"] = {
			{anim = "ugol_r1", anim_speed = 1, weight = 1},
			};
actor_nail.states_design["slope_corner_right_end"] = {
			{anim = "ugol_r3_out", anim_speed = 1, weight = 1},
			};			
			
actor_nail.states_design["attack_corner_right_shooting"] = {
			body_state = RIGHT_SLOPE_BODY_STATE,
			{anim = "ugol_r2_1", anim_speed = 1, snd = "nailgun_fire1", snd_params = snd_actor_shot},
			{anim = "ugol_r2_2", anim_speed = 1, snd = "nailgun_fire2", snd_params = snd_actor_shot},
			{anim = "ugol_r2_3", anim_speed = 1, snd = "nailgun_fire3", snd_params = snd_actor_shot},
			};


						
----------------------------
-- ATTACK MISSILE CORNER
----------------------------
actor_nail.states_design["attack_missile_corner_left_begin"] = {
			{anim = "ugol_l_granata", anim_speed = 1, snd = "SportsMan_atak 2", snd_params = snd_actor_attack},};

actor_nail.states_design["attack_missile_corner_left_end"] = {
			{anim = "ugol_l_granata_out"},};
			
actor_nail.states_design["attack_missile_corner_right_begin"] = {
			{anim = "ugol_R_granata", anim_speed = 1, snd = "SportsMan_atak 2", snd_params = snd_actor_attack},};

actor_nail.states_design["attack_missile_corner_right_end"] = {
			{anim = "ugol_R_granata_out"},};

----------------------------
-- RELOAD
----------------------------
actor_nail.states_design["reload"] = {
			{anim = "reload_p1", anim_speed = 1.5, snd = "nailgun_reload"},};	
			
--------------------------------------------------------
-- Переходы из стоячего положения в сидячее и обратно
--------------------------------------------------------
actor_nail.states_design["transition_stay_to_sit"] = {
			{anim = "perehod_p1_p2", anim_speed = 1.5, snd = "nailgun_reload"},};
actor_nail.states_design["transition_sit_to_stay"] = {
			{anim = "perehod_p2_p1", anim_speed = 1.5, snd = "nailgun_reload"},};

--------------------
-- IDLE SIT
--------------------

actor_nail.states_design["idle_sit"] = {
			body_state = SIT_BODY_STATE,
			{anim = "reload_p2", anim_speed = 0.01, snd = "Organ_idle5"},
			};
			
      
--------------------
-- PAIN SIT
--------------------
actor_nail.states_design["pain_sit"] = {
			body_state = SIT_BODY_STATE,
			{anim = "pain6_p2", weight = 1, snd = "Organ_pain1"},
			{anim = "pain7_p2", weight = 1, snd = "Organ_pain2"},
			{anim = "pain8_p2", weight = 1, snd = "Organ_pain3"},
            };
            
----------------------------
-- RELOAD SIT
----------------------------
actor_nail.states_design["reload_sit"] = {
			body_state = SIT_BODY_STATE,
			{anim = "reload_p2", anim_speed = 1.5, snd = "nailgun_reload"},
			};	
			
----------------------------
-- ATTACK SIT
----------------------------
actor_nail.states_design["attack_sit_shooting"] = {
			body_state = SIT_BODY_STATE,
			{anim = "attack6_p2", anim_speed = 1, weight = 1, snd = "nailgun_fire1", snd_params = snd_actor_shot, weight = 1},
			{anim = "attack6_p2", anim_speed = 1, weight = 1, snd = "nailgun_fire2", snd_params = snd_actor_shot, weight = 1},
			{anim = "attack6_p2", anim_speed = 1, weight = 1, snd = "nailgun_fire3", snd_params = snd_actor_shot, weight = 1},
			};
			
			
----------------------------
-- ATTACK MELEE
----------------------------			
actor_nail.states_design["attack_melee_begin"] = {
			{anim = "attack11_udar1_p1", anim_speed = 1, snd = "Fireman_Kick1", snd_params = snd_actor_attack},
			{anim = "attack14_udar2_p1", anim_speed = 1, snd = "Fireman_Kick2", snd_params = snd_actor_attack},
			};

actor_nail.states_design["attack_melee_end"] = {
			{anim = "attack11_udar1_p1_out", anim_speed = 1,},
			{anim = "attack14_udar2_p1_out", anim_speed = 1,},
			};
			


----------------------------
-- DEATH
----------------------------
actor_nail.states_design["death"] = {
			{snd = "Organ_dead1", snd_params = snd_actor_death},
};
