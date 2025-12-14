------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Pig Parent - монстр свиноматка
------------------------------------------------------------------------

actor_pig_parent = {};

---------------------------------------------------------------------------------
actor_pig_parent.properties_design  = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"svinina" },
	{ "rag_doll_model",			"svinina_ragdoll" },

	{ "stay_height",			1.0  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.7	  },

	{ "mass",					1000.0 },

	{ "walk_forward_speed",		180.0 },
	{ "walk_backward_speed",	90.0 },
	{ "walk_strafe_speed",		25.0  },
	{ "run_forward_speed",		180.0 },
	{ "run_backward_speed",		90.0 },
	{ "run_strafe_speed",		25.0 },
	{ "jump_height",			60	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				70	  },	-- угол обзора (град) 
	{ "view_dist",				15	  },	-- максимальная дальность зрения (м)
});
---------------------------------------------------------------------------------
actor_pig_parent.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 40000,
};

-- настройки hitbox-ов
actor_pig_parent.params.hitboxes = { 
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
actor_pig_parent.params.attack_info = {};

-- Рожает поросенка
actor_pig_parent.params.attack_info[0] = {
		id						= ATTACK_PRIMARY,
		type					= ATTACK_DISTANT,
		dist					= 5,
		desired_min_dist		= 0,
		desired_max_dist		= 1000,
		max_angle				= 25,
		stop_during_attack		= 1, 
		
		offset_pos				= {0.5, 0, 0},
		
		--pause_between_attacks	= 5000, -- пауза между атаками такого типа
		
		allowed_bhv				= {BHV_STAND, BHV_WALK},
		fsm_state				= "attack",
		visual_state_prefix		= "attack",
};
--[[
-- Атака-заглушка. Ничего не делает. Нужна для того чтобы выдержать паузу
-- после рождения поросенка.
actor_pig_parent.params.attack_info[1] = {
		id						= ATTACK_SECONDARY,
		type					= ATTACK_DISTANT,
		dist					= 15,
		desired_min_dist		= 100,
		desired_max_dist		= 1000,
		max_angle				= 6,
		stop_during_attack		= 1, 
		
		allowed_bhv				= {BHV_STAND, BHV_WALK},
		fsm_state				= "attack_anim",
		visual_state_prefix		= "idle_alert",
};
--]]

---------------------------------------------------------------------------------
actor_pig_parent.states_design = {};


--------------------
-- IDLE
--------------------
actor_pig_parent.states_design["idle"] = 
		{
			{anim = "alert", anim_speed = 1, snd = "Myaso_idle1", weight = 7},
			
			{anim = "attack1_spawn", anim_speed = 1, snd = "gomnoed_pain4_p1"},
			{anim = "attack2_spawn", anim_speed = 1, snd = "gomnoed_pain2_p1"},
			{anim = "attack3_spawn", anim_speed = 1, snd = "gomnoed_pain1_p1"},
			{anim = "attack4_spawn", anim_speed = 1, snd = "gomnoed_pain3_p1"},
		};
		
--------------------
-- IDLE ALERT
--------------------
actor_pig_parent.states_design["idle_alert"] = 
		{
			{anim = "alert", weight = 1, snd = "gomnoed_atak_2_p1"},
		};
		
		
--------------------
-- DEATH
--------------------
actor_pig_parent.states_design["death"] = {
			{anim = "attack1_spawn", weight = 1, snd = "gomnoed_pain4_p1", snd_vol = SND_ACTOR_SHOT_VOL, snd_dist_min = SND_ACTOR_SHOT_MIN_DIST, snd_dist_max = SND_ACTOR_SHOT_MAX_DIST},
			};
		
--------------------
-- PAIN
--------------------
--[[
actor_pig_parent.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "Fireman_Damage1"},
			{anim = "pain2", weight = 1, snd = "Fireman_Damage2"},
			};
--]]			
--------------------
-- WALK			
--------------------
actor_pig_parent.states_design["forward_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};
actor_pig_parent.states_design["backward_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};
actor_pig_parent.states_design["strafe_left_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};
actor_pig_parent.states_design["strafe_right_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};
--------------------
-- RUN
--------------------
actor_pig_parent.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};
actor_pig_parent.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};
actor_pig_parent.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};
actor_pig_parent.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_pig_parent.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0 },};
-- начало прыжка			
actor_pig_parent.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1 },};			

-- зацикленная анимация состояния падения
actor_pig_parent.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY },};

-- приземление на бегу
actor_pig_parent.states_design["land_run"] = {
			{anim = "run", anim_speed = 1 },};
-- приземление на месте
actor_pig_parent.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1 },};

----------------------------
-- ATTACK
----------------------------
actor_pig_parent.states_design["attack_begin"] = {
			{anim = "attack1_spawn", anim_speed = 1, snd = "Myaso_attack1"},
			{anim = "attack2_spawn", anim_speed = 1, snd = "Myaso_attack1"},
			{anim = "attack3_spawn", anim_speed = 1, snd = "Myaso_attack1"},
			{anim = "attack4_spawn", anim_speed = 1, snd = "Myaso_attack1"},
			};

actor_pig_parent.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack3_out"},
			{anim = "attack4_out"},
			};

---------------------------------------------------------------------------------                        
			