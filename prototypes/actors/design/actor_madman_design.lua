------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Madman - монстр псих.больной
------------------------------------------------------------------------

actor_madman = {};

---------------------------------------------------------------------------------
actor_madman.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"madman" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		100.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		250.0 },
	{ "run_backward_speed",		220.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			50	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	{ "rag_doll_model",			"psih_ragdoll"  },
});
---------------------------------------------------------------------------------
actor_madman.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 1,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 30000,
};


-- настройки hitbox-ов
actor_madman.params.hitboxes = { 
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
actor_madman.params.attack_info = {};

actor_madman.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	dist				= 2,
	desired_min_dist	= 0, 
	desired_max_dist	= 3,
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 7,
	impulse				= .9,
	dispersion			= 0,
	offset_pos			= {0, 0, 1.30},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

actor_madman.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_MELEE,
	real_min_dist		= 1,
	real_max_dist		= 3,
	dist				= 5,
	desired_min_dist	= 7, 
	desired_max_dist	= 1000, 
	max_angle			= 4, 
	stop_during_attack	= 0,
	
	damage_type			= g_damage_type.KNOCK,
	damage				= 7,
	impulse				= .9,
	dispersion			= 2.5,
	offset_pos			= {0, 0, 1.30},
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_run",
	visual_state_prefix	= "attack_head",
};

---------------------------------------------------------------------------------
actor_madman.states_design = {};


--------------------
-- IDLE
--------------------
actor_madman.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "Psih_Idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "Psih_Idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "Psih_Idle3", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_madman.states_design["idle_alert"] = {
			{anim = "alert1",anim_speed = 0.7, weight = 1, snd = "Psih_Kolbasivo1"},
			{anim = "alert2",anim_speed = 0.7, weight = 1, snd = "Psih_Kolbasivo2"},
			{anim = "alert1",anim_speed = 1, weight = 1, snd = "Psih_Kolbasivo1"},
			{anim = "alert2",anim_speed = 1, weight = 1, snd = "Psih_Kolbasivo2"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_madman.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "psih_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_madman.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Walk"},};
actor_madman.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Walk"},};
actor_madman.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Walk"},};
actor_madman.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Walk"},};
--------------------
-- RUN
--------------------
actor_madman.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Run"},};
actor_madman.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Run"},};
actor_madman.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Run"},};
actor_madman.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_madman.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "Psih_Run"},};
-- начало прыжка			
actor_madman.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "Psih_Run"},};			

-- зацикленная анимация состояния падения
actor_madman.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Psih_Run"},};

-- приземление на бегу
actor_madman.states_design["land_run"] = {
			{anim = "run2", anim_speed = 1, snd = "Psih_Run"},};
-- приземление на месте
actor_madman.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "Psih_Run"},};

----------------------------
-- ATTACK
----------------------------
actor_madman.states_design["attack_begin"] = {

			{anim = "attack1", anim_speed = 1, snd = "Psih_Kick1", snd_params = snd_actor_attack},
			{anim = "attack2", anim_speed = 1, snd = "Psih_Kick2", snd_params = snd_actor_attack},
			{anim = "attack4", anim_speed = 1, snd = "Psih_Kick4", snd_params = snd_actor_attack},};

actor_madman.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack4_out"},};
			
			
----------------------------
-- ATTACK HEAD
----------------------------
actor_madman.states_design["attack_head_begin"] = {
			{anim = "attack_head", anim_speed = 1, snd = "Psih_KickHead", snd_params = snd_actor_attack},};
actor_madman.states_design["attack_head_end"] = {
			{anim = "attack_head_out"},};
	
--------------------
-- PAIN
--------------------
actor_madman.states_design["pain"] = {
			{anim = "pain1", anim_speed = 1, weight = 1, snd = "Psih_Damage1", snd_params = snd_actor_pain},
			{anim = "pain2", anim_speed = 1, weight = 1, snd = "Psih_Damage2", snd_params = snd_actor_pain},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "Psih_Damage3", snd_params = snd_actor_pain},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "Psih_Damage4", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_madman.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Psih_Damage5", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "Psih_Damage4", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "Psih_Damage7", snd_params = snd_actor_death},
};
			