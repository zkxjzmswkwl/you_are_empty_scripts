------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Ded - дед с дробовиком
------------------------------------------------------------------------

actor_ded = {};

---------------------------------------------------------------------------------
actor_ded.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"ded" },
	{ "rag_doll_model",			"ded1_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		150.0 },
	{ "walk_backward_speed",	150.0 },
	{ "walk_strafe_speed",		80.0  },
	{ "run_forward_speed",		230.0 },
	{ "run_backward_speed",		200.0 },
	{ "run_strafe_speed",		80.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				20	  },	-- максимальная дальность зрения (м)
	
    { "turn_hands",				3 },	--// 0 - none, 1 - right, 2 - left, 3 - both
	{ "allow_head_turn",		true	},
	
	{ "ignore_insuperable_danger", 	false   }, -- реагировать на гранаты
});
---------------------------------------------------------------------------------
actor_ded.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 2000,
	-- кол-во патронов в обойме
	clip_size			= 2,
	
	
	-- расстояние отступления
	retreat_dist = 0*5,
	-- расстояние преследования
	chase_dist = 3,
	-- расстояние стрейфа
	dodge_dist = 0*4,
	-- время стрейфа в одну сторону
	dodge_time = 0*3000,
};

-- настройки hitbox-ов
actor_ded.params.hitboxes = { 
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

-- параметры атаки
actor_ded.params.attack_info = {};

-- стрельба с места
actor_ded.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_DISTANT,
	
	real_min_dist		= 5,
	real_max_dist		= 20,
	
	dist				= 15,
	desired_min_dist	= 0, 
	desired_max_dist	= 5, 
	max_angle			= 6, 
	stop_during_attack	= 1,
	
	priority			= 1,
		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 6,
	impulse				= 0.3,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	bullets_in_shot		= 4, -- кол-во дробинок в выстреле
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_ded.lua"}, 
						  },
	-- Эффект, трейса пули. 
	trace_bullet_effect = "pfx_shot_trace.lua",
					  
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot",
	visual_state_prefix	= "attack",
};

-- стрельба на бегу
actor_ded.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_DISTANT,
	
	real_min_dist		= 5,
	real_max_dist		= 20,

	dist				= 15,
	desired_min_dist	= 7, 
	desired_max_dist	= 1000, 
	max_angle			= 6, 
	stop_during_attack	= 0,
		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 6,
	impulse				= 0.3,
	dispersion			= 25,
	
	
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
		
	clip_size			= 2, -- кол-во патронов в обойме
	bullets_in_shot		= 4, -- кол-во дробинок в выстреле
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_ded.lua"}, 
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  

	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_shot_run",
	visual_state_prefix	= "attack_run",						  
};

-- стрельба из-за угла слева
actor_ded.params.attack_info[2] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_DISTANT,
	
	real_min_dist		= 5,
	real_max_dist		= 20,
	
	dist				= 15,
	desired_min_dist	= 0, 
	desired_max_dist	= 37, 
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 4,
	impulse				= 0.3,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	clip_size			= 2, -- кол-во патронов в обойме
	bullets_in_shot		= 4, -- кол-во дробинок в выстреле
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_ded.lua"}, 
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot",
	visual_state_prefix	= "attack_corner_left",
	
	not_allowed			= true;
	allow_blind_attack	= true;
};

-- стрельба из-за угла справа
actor_ded.params.attack_info[3] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_DISTANT,
	
	real_min_dist		= 5,
	real_max_dist		= 20,
	
	dist				= 15,
	desired_min_dist	= 0, 
	desired_max_dist	= 37, 
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 4,
	impulse				= 0.3,
	dispersion			= 25,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.37}, -- не используется, если указан 'shoot_point_tag'
	
	clip_size			= 2, -- кол-во патронов в обойме
	bullets_in_shot		= 4, -- кол-во дробинок в выстреле
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_ded.lua"}, 
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
						  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot",
	visual_state_prefix	= "attack_corner_right",
	
	not_allowed			= true;
	allow_blind_attack	= true;
};

--[[
-- атака - дед кричит и ругается в сторону врага
actor_ded.params.attack_info[4] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	
	dist				= 15,
	desired_min_dist	= 10, 
	desired_max_dist	= 1000, 
	max_angle			= 6, 
	stop_during_attack	= 1,

	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_anim",
	visual_state_prefix	= "attack_taunt",
	
	not_allowed			= true;
	--allow_blind_attack	= true;
};
--]]


actor_ded.snd_vol = -0.3;

---------------------------------------------------------------------------------
actor_ded.states_design = {};


--------------------
-- IDLE
--------------------
actor_ded.states_design["idle"] = {
			{anim = "idle2", anim_speed = 1, snd = "Ded_idle2", weight = 1, snd_vol = actor_ded.snd_vol},
			{anim = "idle3", anim_speed = 1, snd = "Ded_idle3", weight = 1, snd_vol = actor_ded.snd_vol},
			{anim = "idle4", anim_speed = 1, snd = "Ded_idle4", weight = 1, snd_vol = actor_ded.snd_vol},};
			
--------------------
-- IDLE ALERT
--------------------
actor_ded.states_design["idle_alert"] = {
			{anim = "idle5", weight = 1, snd = "Ded_idle5", snd_vol = actor_ded.snd_vol},
			};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_ded.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "ded_klich", snd_params = snd_actor_alert, snd_vol = actor_ded.snd_vol,},
	{anim = nil, weight = 1, snd = "ded_klich2", snd_params = snd_actor_alert, snd_vol = actor_ded.snd_vol,},
	{anim = nil, weight = 1, snd = "ded_klich3", snd_params = snd_actor_alert, snd_vol = actor_ded.snd_vol,},
};


--------------------
-- WALK			
--------------------
actor_ded.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_walk"},};
actor_ded.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_walk"},};
actor_ded.states_design["strafe_left_walk"] = {
			{anim = "l_walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_l_walk"},};
actor_ded.states_design["strafe_right_walk"] = {
			{anim = "r_walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_r_walk"},};
			
--------------------
-- RUN
--------------------
actor_ded.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};
actor_ded.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};
actor_ded.states_design["strafe_left_run"] = {
			{anim = "l_walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_l_walk"},};
			--{anim = "l", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};
actor_ded.states_design["strafe_right_run"] = {
			--{anim = "r", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};
			{anim = "r_walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_r_walk"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_ded.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "Ded_run"},};
-- начало прыжка			
actor_ded.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "Ded_run"},};			

-- зацикленная анимация состояния падения
actor_ded.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};

-- приземление на бегу
actor_ded.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "Ded_run"},};
-- приземление на месте
actor_ded.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "Ded_run"},};

----------------------------
-- ATTACK
----------------------------
actor_ded.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "Ded_attack1", snd_params = snd_actor_shot},
			{anim = "attack2", anim_speed = 1, snd = "Ded_attack2", snd_params = snd_actor_shot},
			{anim = "attack1", anim_speed = 1, snd = "Ded_attack3", snd_params = snd_actor_shot},};

actor_ded.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack1_out"},};
			
----------------------------
-- ATTACK RUN
----------------------------
actor_ded.states_design["attack_run_begin"] = {
			{anim = "run_attack", anim_speed = 1, weight = 1, anim_bone_group = TORSO_BONE_GROUP},
			};
			
actor_ded.states_design["attack_run_end"] = {
			{anim = "run_attack_out", anim_speed = 1, weight = 1,  anim_bone_group = TORSO_BONE_GROUP, snd = "Ded_attack1", snd_params = snd_actor_shot, },
			{anim = "run_attack_out", anim_speed = 1, weight = 1,  anim_bone_group = TORSO_BONE_GROUP, snd = "Ded_attack2", snd_params = snd_actor_shot, },
			{anim = "run_attack_out", anim_speed = 1, weight = 1,  anim_bone_group = TORSO_BONE_GROUP, snd = "Ded_attack3", snd_params = snd_actor_shot, },
			};
			
----------------------------
-- ATTACK CORNER
----------------------------
actor_ded.states_design["attack_corner_left_begin"] = {
			{anim = "ugol_l", anim_speed = 1, weight = 1},
			};
			
actor_ded.states_design["attack_corner_left_end"] = {
			{anim = "ugol_l_out", anim_speed = 1, weight = 1, snd = "Ded_attack1", snd_params = snd_actor_shot, },
			};
actor_ded.states_design["attack_corner_right_begin"] = {
			{anim = "ugol_r", anim_speed = 1, weight = 1},
			};
			
actor_ded.states_design["attack_corner_right_end"] = {
			{anim = "ugol_r_out", anim_speed = 1, weight = 1, snd = "Ded_attack1", snd_params = snd_actor_shot, },
			};
			
----------------------------
-- RELOAD
----------------------------
actor_ded.states_design["reload"] = {
			{anim = "reload2", anim_speed = 1.5, snd = "Ded_reload1_attack", snd_params = snd_actor_reload},};
			
actor_ded.states_design["reload_on_knee"] = {
			{anim = "reload5", anim_speed = 1.6, snd = "Ded_reload1_attack", snd_params = snd_actor_reload},};
			
			
--------------------
-- ATTACK TAUNT
--------------------
actor_ded.states_design["attack_taunt"] = {
			{anim = "ugol_l_out", anim_speed = 1, weight = 1, snd = "Ded_attack1"},};
--------------------
-- CUSTOM IDLE - NOSE
--------------------
actor_ded.states_design["idle_nose"] = {
			{anim = "idle2", anim_speed = 1, snd = "Ded_idle2", weight = 1, snd_params = snd_actor_alert},
			{anim = "idle3", anim_speed = 1, snd = "Ded_idle3", weight = 1, snd_params = snd_actor_alert},};

--------------------
-- PAIN
--------------------
actor_ded.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "Ded_pain1", snd_params = snd_actor_pain},
			{anim = "pain2", weight = 1, snd = "Ded_pain2", snd_params = snd_actor_pain},
			{anim = "pain3", weight = 1, snd = "Ded_pain3", snd_params = snd_actor_pain},
            {anim = "pain4", weight = 1, snd = "Ded_pain4", snd_params = snd_actor_pain},
            {anim = "pain5", weight = 1, snd = "Ded_pain5", snd_params = snd_actor_pain},
};

--------------------
-- DEATH
--------------------
actor_ded.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Ded_death", snd_params = snd_actor_death, snd_vol = actor_ded.snd_vol},
			{--[[anim = "dead2",--]] weight = 1, snd = "Ded_Death1", snd_params = snd_actor_death, snd_vol = actor_ded.snd_vol},
			{--[[anim = "dead3",--]] weight = 1, snd = "Ded_Death2", snd_params = snd_actor_death, snd_vol = actor_ded.snd_vol},};