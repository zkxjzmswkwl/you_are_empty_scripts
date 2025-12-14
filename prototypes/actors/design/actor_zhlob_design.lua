------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Zhlob - монстр дорожный рабочий
------------------------------------------------------------------------

actor_zhlob = {};

---------------------------------------------------------------------------------
actor_zhlob.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"zlob" },
	{ "rag_doll_model",			"zlob_ragdoll"  },	

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		100.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		310.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			160	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)

	{ "allow_head_turn",		false	  },
});

---------------------------------------------------------------------------------
actor_zhlob.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 10000,
};


-- настройки hitbox-ов
actor_zhlob.params.hitboxes = { 
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
actor_zhlob.params.attack_info = {};

actor_zhlob.params.attack_info[0] = {
		id					= ATTACK_PRIMARY,
		type				= ATTACK_MELEE,
		dist				= 2, 
		desired_min_dist	= 0,
		desired_max_dist	= 4,
		max_angle			= 6,
		stop_during_attack	= 1, 
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 20,
		impulse				= 2,
		dispersion			= 0,
		offset_pos			= {0, 0, 1.55},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};
--[[
actor_zhlob.params.attack_info[1] = {
	type				= ATTACK_MELEE,
	real_min_dist		= 2.5,
	real_max_dist		= 2.5,
	dist				= 5,
	desired_min_dist	= 4, 
	desired_max_dist	= 1000,
	max_angle			= 4, 
	stop_during_attack	= 0,	
	
	damage_type			= g_damage_type.KNOCK,
	damage				= 20,
	impulse				= 3,
	dispersion			= 0,
	offset_pos			= {0, 0, 1.55},
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_run",
	visual_state_prefix	= "attack_run",
};
--]]
---------------------------------------------------------------------------------
actor_zhlob.states_design = {};

actor_zhlob.snd_vol = -0.3;

--------------------
-- IDLE
--------------------
actor_zhlob.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "Zlob_aydl1", weight = 6, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle2", anim_speed = 1, snd = "Zlob_aydl2", weight = 1, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle3", anim_speed = 1, snd = "Zlob_aydl3", weight = 1, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle4", anim_speed = 1, snd = "Zlob_aydl4", weight = 1, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle5", anim_speed = 1, snd = "Zlob_aydl5", weight = 3, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle6", anim_speed = 1, snd = "Zlob_aydl6", weight = 1, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle7", anim_speed = 1, snd = "Zlob_aydl7", weight = 1, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle8", anim_speed = 1, snd = "Zlob_aydl8", weight = 0.5, snd_vol = actor_zhlob.snd_vol,},
			{anim = "idle9", anim_speed = 1, snd = "Zlob_aydl9", weight = 1, snd_vol = actor_zhlob.snd_vol,},};
			
--------------------
-- IDLE ALERT
--------------------
actor_zhlob.states_design["idle_alert"] = {
			{anim = "alert_idle10", weight = 1, snd_vol = actor_zhlob.snd_vol,},
			{anim = "alert_idle11", weight = 1, snd_vol = actor_zhlob.snd_vol,},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_zhlob.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "zlob_klich1", snd_params = snd_actor_alert, snd_vol = actor_zhlob.snd_vol,},
	{anim = nil, weight = 1, snd = "zlob_klich2", snd_params = snd_actor_alert, snd_vol = actor_zhlob.snd_vol,},
	{anim = nil, weight = 1, snd = "zlob_klich3", snd_params = snd_actor_alert, snd_vol = actor_zhlob.snd_vol,},
	{anim = nil, weight = 1, snd = "zlob_klich4", snd_params = snd_actor_alert, snd_vol = actor_zhlob.snd_vol,},
	{anim = nil, weight = 1, snd = "Zlob_demidg5", snd_params = snd_actor_alert, snd_vol = actor_zhlob.snd_vol,},
};
			
--------------------
-- WALK			
--------------------
actor_zhlob.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_volk"},};
actor_zhlob.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_volk"},};
actor_zhlob.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_levo"},};
actor_zhlob.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_pravo"},};
--------------------
-- RUN
--------------------
actor_zhlob.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_RUN"},};
actor_zhlob.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_RUN"},};
actor_zhlob.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_RUN"},};
actor_zhlob.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_RUN"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_zhlob.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "Zlob_RUN"},};
-- начало прыжка			
actor_zhlob.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "Zlob_RUN"},};			

-- зацикленная анимация состояния падения
actor_zhlob.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Zlob_RUN"},};

-- приземление на бегу
actor_zhlob.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "Zlob_RUN"},};
-- приземление на месте
actor_zhlob.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "Zlob_RUN"},};

----------------------------
-- ATTACK
----------------------------
actor_zhlob.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "Zlob_udar 1", snd_params = snd_actor_attack, snd_vol = actor_zhlob.snd_vol,},
			{anim = "attack2", anim_speed = 1, snd = "Zlob_udar 2", snd_params = snd_actor_attack, snd_vol = actor_zhlob.snd_vol,},
			{anim = "attack3", anim_speed = 1, snd = "Zlob_udar 3", snd_params = snd_actor_attack, snd_vol = actor_zhlob.snd_vol,},
        	{anim = "attack1", anim_speed = 1.3, snd = "Zlob_udar 1", snd_params = snd_actor_attack, snd_vol = actor_zhlob.snd_vol,},
			{anim = "attack2", anim_speed = 1.3, snd = "Zlob_udar 2", snd_params = snd_actor_attack, snd_vol = actor_zhlob.snd_vol,},
			{anim = "attack3", anim_speed = 1.2, snd = "Zlob_udar 3", snd_params = snd_actor_attack, snd_vol = actor_zhlob.snd_vol,},}; 
actor_zhlob.states_design["attack_end"] = {
			{anim = "attack1_out",anim_speed = 1,},
			{anim = "attack2_out",anim_speed = 1,},
			{anim = "attack3_out",anim_speed = 1,},	
			{anim = "attack1_out",anim_speed = 1.3,},
			{anim = "attack2_out",anim_speed = 1.3,},
			{anim = "attack3_out",anim_speed = 1.2,},};

----------------------------
-- ATTACK RUN
----------------------------
actor_zhlob.states_design["attack_run_begin"] = {
			{anim = "attack1", anim_speed = 1, weight = 1, snd = "Zlob_udar 1", snd_params = snd_actor_attack},
			};
			
actor_zhlob.states_design["attack_run_end"] = {
			{anim = "attack1_out", anim_speed = 1, weight = 1},
			};			
			
--------------------
-- PAIN
--------------------
actor_zhlob.states_design["pain"] = {
			{anim = "pain1", anim_speed = 2, weight = .3, snd = "Zlob_demidg 1a", snd_params = snd_actor_pain, snd_vol = actor_zhlob.snd_vol,},
			{anim = "pain1", anim_speed = 2, weight = .3, snd = "Zlob_demidg 1b", snd_params = snd_actor_pain, snd_vol = actor_zhlob.snd_vol,},
			{anim = "pain1", anim_speed = 2, weight = .3, snd = "Zlob_demidg 1c", snd_params = snd_actor_pain, snd_vol = actor_zhlob.snd_vol,},
			{anim = "pain2", anim_speed = 1, weight = 1, snd = "Zlob_demidg 2", snd_params = snd_actor_pain, snd_vol = actor_zhlob.snd_vol,},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "Zlob_demidg 3", snd_params = snd_actor_pain, snd_vol = actor_zhlob.snd_vol,},
			{anim = "pain4", anim_speed = 1, weight = 1, snd = "Zlob_demidg 4", snd_params = snd_actor_pain, snd_vol = actor_zhlob.snd_vol,},};
			
--------------------
-- DEATH
--------------------
actor_zhlob.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Zlob_demidg 4" , snd_params = snd_actor_death, snd_vol = actor_zhlob.snd_vol,},
			{--[[anim = "dead2",--]] weight = 1, snd = "Zlob_demidg 2", snd_params = snd_actor_death, snd_vol = actor_zhlob.snd_vol,},
			{--[[anim = "dead3",--]] weight = 1, snd = "Zlob_demidg 1b", snd_params = snd_actor_death, snd_vol = actor_zhlob.snd_vol,},
			{--[[anim = "dead3",--]] weight = 1, snd = "Zlob_demidg 1a", snd_params = snd_actor_death, snd_vol = actor_zhlob.snd_vol,},};
			
