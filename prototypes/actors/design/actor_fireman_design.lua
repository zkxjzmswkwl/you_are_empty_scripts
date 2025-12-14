------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Fireman - монстр пожарник, настройки анимаций и звуков
------------------------------------------------------------------------

actor_fireman = {};

---------------------------------------------------------------------------------
actor_fireman.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"fireman" },
	{ "rag_doll_model",			"fireman_ragdoll"  },
	
	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		200.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		330.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			40	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	-------------------------------
	-- настройки сенсоров осязания
	-------------------------------
	-- FOV зрения
	{ "view_fov",					70 },
	-- макс. дистанция зрения 
	{ "view_dist",					25 },	
	-- порог слышимости звука
	-- минимальная громкость звука (0 - слышит все, до >1 - не слышит ничего),
	-- на которую срабатывает сенсор слуха
	--{ "sensor_sound_threshold",		0  },	
	-- параметры повреждения
	-- мин. размер хита и импульса чувствительные для сенсора повреждения
	{ "sensor_damage_hit_threshold",	 0  },
    { "sensor_damage_impulse_threshold", 0  },
    -- сенсор столкновения (вкл/выкл)
    { "sensor_collision",		true    },
    { "allow_head_turn",		true	},
    
	{ "ignore_insuperable_danger", 	false   }, -- реагировать на гранаты
});

---------------------------------------------------------------------------------
actor_fireman.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 200, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 1.0,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 40000,
	
	-- Скорость атаки
	attack_speed = 1.3
};


-- настройки hitbox-ов
actor_fireman.params.hitboxes = { 
	{name = "head", damage_k = 1.5, },
	{name = "pelvis", damage_k = .7, },
    {name = "rupperArm1", damage_k = .3, },
    {name = "rupperArm2", damage_k = .45, },
    {name = "spine", damage_k = .7, },
    {name = "spine3", damage_k = .7, },
    {name = "lupperArm1", damage_k = .3, },
    {name = "lupperArm2", damage_k = .45, },
    {name = "lthigh1", damage_k = .5, },
    {name = "lthigh2", damage_k = .45, },
    {name = "rthigh1", damage_k = .5, },
    {name = "rthigh2", damage_k = .45, },
    {name = "gan", damage_k = .0, },
};

-- ragdolls. Параметр damage БЕЗ учета damage_k из таблицы hitboxes
-- Параметр ragdoll - это группа из скрипта .RDS
-- Если ни одна запись в таблице не удовлетворяет то
-- спавнится группа default, если такой группы нет
-- спавнятся все регдолы описанные в скрипте .RDS
actor_fireman.params.odd_ragdolls = {
	{ hitbox = "head", damage = 100, ragdoll = "no_head" };
};


-- параметры атаки
actor_fireman.params.attack_info = {};

actor_fireman.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	dist				= 2,
	desired_min_dist	= 0, 
	desired_max_dist	= 4, 
	max_angle			= 6, 
	stop_during_attack	= 1,
	
	damage_type			= g_damage_type.KNOCK,	
	damage				= 20,
	impulse				= 1.0,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

actor_fireman.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_JUMP,
	dist				= 5,
	real_min_dist		= 3,
	real_max_dist		= 3,
	desired_min_dist	= 4, 
	desired_max_dist	= 1000, 
	max_angle			= 4, 
	stop_during_attack	= 0,
	
	damage_type			= g_damage_type.KNOCK,	
	damage				= 25,
	impulse				= 1,
	dispersion			= 0,
	offset_pos			= {0.70, 0, 1.70},
	
	jump_height			= 0.5,
	
	
	pause_between_attacks = 4000,
	
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump",
};

---------------------------------------------------------------------------------
actor_fireman.states_design = {};

--------------------
-- IDLE
--------------------
actor_fireman.states_design["idle"] = {
			{anim = "idle1", snd = "Fireman_Idle1", weight = 1, snd_params = snd_actor_common},
			{anim = "idle2", anim_speed = 1, snd = "Fireman_Idle2", weight = 1, snd_params = snd_actor_common},
			{anim = "idle3", anim_speed = 1, snd = "Fireman_Idle3", weight = 1, snd_params = snd_actor_common},
			{anim = "idle4", anim_speed = 1, snd = "Fireman_Idle4", weight = 1, snd_params = snd_actor_common},};
			
--------------------
-- IDLE ALERT
--------------------
actor_fireman.states_design["idle_alert"] = {
			{anim = "alert1", snd = "Fireman_AgresIdle1", weight = 1, snd_params = snd_actor_common},
			{anim = "alert2", snd = "Fireman_AgresIdle3", weight = 1, snd_params = snd_actor_common},
			{anim = "damaged_idle1", weight = 4, snd_params = snd_actor_common},
			{anim = "damaged_idle2", weight = 4, snd_params = snd_actor_common},
   			{anim = "alert1", anim_speed = 0.8, snd = "Fireman_AgresIdle1", weight = 1, snd_params = snd_actor_common},
			{anim = "alert2", anim_speed = 0.8, snd = "Fireman_AgresIdle3", weight = 1, snd_params = snd_actor_common},
			{anim = "damaged_idle1", anim_speed = 0.6, weight = 4, snd_params = snd_actor_common},
			{anim = "damaged_idle2", anim_speed = 0.6, weight = 4, snd_params = snd_actor_common},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_fireman.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "fireman_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- PAIN
--------------------
actor_fireman.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "Fireman_Damage1", snd_params = snd_actor_pain},
			{anim = "pain2", weight = 1, snd = "Fireman_Damage2", snd_params = snd_actor_pain},
			{anim = "pain3", weight = 1, snd = "Fireman_Damage3", snd_params = snd_actor_pain},
			{anim = "pain4", weight = 1, snd = "Fireman_Damage4", snd_params = snd_actor_pain},};

--------------------
-- DEATH
--------------------
actor_fireman.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Fireman_Dead1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "Fireman_Dead2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "Fireman_Dead3", snd_params = snd_actor_death},};

--------------------
-- WALK			
--------------------
actor_fireman.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk",  snd_params = snd_actor_steps_run},};
actor_fireman.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk",  snd_params = snd_actor_steps_run},};
actor_fireman.states_design["strafe_left_walk"] = {
			{anim = "step_l", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_StepLeft",  snd_params = snd_actor_steps_run},};
actor_fireman.states_design["strafe_right_walk"] = {
			{anim = "step_r", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_StepRight",  snd_params = snd_actor_steps_run},};
--------------------
-- RUN
--------------------
actor_fireman.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run",  snd_params = snd_actor_steps_run},};
actor_fireman.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run",  snd_params = snd_actor_steps_run},};
actor_fireman.states_design["strafe_left_run"] = {
			{anim = "step_l", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run",  snd_params = snd_actor_steps_run},};
actor_fireman.states_design["strafe_right_run"] = {
			{anim = "step_r", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run",  snd_params = snd_actor_steps_run},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_fireman.states_design["jump_prepare"] = {
			{anim = "jamp_a1", anim_speed = 1.0, snd = "Fireman_Run"},};
-- начало прыжка			
actor_fireman.states_design["jump_begin"] = {
			{anim = "jamp_a2", anim_speed = 1.0, snd = "Fireman_Run"},};			

-- зацикленная анимация состояния падения
actor_fireman.states_design["fall"] = {
			{anim = "jamp_a3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY,},};

-- приземление на бегу
actor_fireman.states_design["land_run"] = {
			{anim = "jamp_run", anim_speed = 1, },};
-- приземление на месте
actor_fireman.states_design["land_stand"] = {
			{anim = "jamp_stey", anim_speed = 1,},};

----------------------------
-- ATTACK
----------------------------
actor_fireman.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = actor_fireman.params.attack_speed, snd = "Fireman_Kick1", snd_params = snd_actor_attack},
			{anim = "attack2", anim_speed = actor_fireman.params.attack_speed, snd = "Fireman_Kick2", snd_params = snd_actor_attack},
			{anim = "attack3", anim_speed = actor_fireman.params.attack_speed, snd = "Fireman_Kick3", snd_params = snd_actor_attack},
			{anim = "attack1", anim_speed = actor_fireman.params.attack_speed, snd = "Fireman_Kick1", snd_params = snd_actor_attack},
			{anim = "attack2", anim_speed = actor_fireman.params.attack_speed, snd = "Fireman_Kick2", snd_params = snd_actor_attack},
			{anim = "attack3", anim_speed = actor_fireman.params.attack_speed, snd = "Fireman_Kick3", snd_params = snd_actor_attack},};
actor_fireman.states_design["attack_end"] = {
			{anim = "attack1_out", anim_speed = actor_fireman.params.attack_speed},
			{anim = "attack2_out", anim_speed = actor_fireman.params.attack_speed},
			{anim = "attack3_out", anim_speed = actor_fireman.params.attack_speed},
			{anim = "attack1_out", anim_speed = actor_fireman.params.attack_speed},
			{anim = "attack2_out", anim_speed = actor_fireman.params.attack_speed},
			{anim = "attack3_out", anim_speed = actor_fireman.params.attack_speed},};
----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_fireman.states_design["attack_jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "Fireman_Run"},};
-- начало прыжка			
actor_fireman.states_design["attack_jump_begin"] = {
			{anim = "jamp2", anim_speed = 1.0, snd = "Fireman_Kick1", snd_params = snd_actor_attack},};

-- зацикленная анимация состояния падения
actor_fireman.states_design["attack_jump_fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY },};

-- приземление на месте
actor_fireman.states_design["attack_jump_land_stand"] = {
			{anim = "jamp4", anim_speed = 1.3, },};
---------------------------------------------------------------------------------