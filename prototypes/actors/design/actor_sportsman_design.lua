------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Sportsman - монстр спортсмен
------------------------------------------------------------------------

actor_sportsman = {};

---------------------------------------------------------------------------------
actor_sportsman.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"sport"},
	{ "rag_doll_model",			"sportsmen_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			1.0	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		120.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		340.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
});
---------------------------------------------------------------------------------
actor_sportsman.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 20000,
};


-- настройки hitbox-ов
actor_sportsman.params.hitboxes = { 
	{name = "head", damage_k = 0.35, },
	{name = "pelvis", damage_k = .1, },
    {name = "rupperArm1", damage_k = .1, },
    {name = "rupperArm2", damage_k = .1, },
    {name = "spine", damage_k = .3, },
    {name = "spine3", damage_k = .3, },
    {name = "lupperArm1", damage_k = .1, },
    {name = "lupperArm2", damage_k = .1, },
    {name = "lthigh1", damage_k = .1, },
    {name = "lthigh2", damage_k = .1, },
    {name = "rthigh1", damage_k = .1, },
    {name = "rthigh2", damage_k = .1, },
};

-- параметры атаки
actor_sportsman.params.attack_info = {};

actor_sportsman.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	dist				= 3,
	desired_min_dist	= 0, 
	desired_max_dist	= 8,
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 20,
	impulse				= 2,
	dispersion			= 0,
	offset_pos			= {0, 0, 1.30},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

actor_sportsman.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_DISTANT,
	dist				= 15,
	desired_min_dist	= 8, 
	desired_max_dist	= 1000, 
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	dispersion			= 0,
	offset_pos			= {0, 2.30, 1.70},
	
	missile						= "ammo_missile_disk",
	missile_velocity			= 2000,
	missile_angular_velocity	= {15, 15, 15},
	
	pause_between_attacks = 3000, -- пауза между атаками такого типа
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile",
};

---------------------------------------------------------------------------------
actor_sportsman.states_design = {};


--------------------
-- IDLE
--------------------
actor_sportsman.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "SportsMan_aidl1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "SportsMan_aidl 2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "SportsMan_aidl 3", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "SportsMan_aidl 4", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_sportsman.states_design["idle_alert"] = {
			{anim = "idle1", weight = 1, snd = "SportsMan_atak_aidl1"},
			{anim = "idle2", weight = 1, snd = "SportsMan_atak_aidl2"},
			{anim = "idle3", weight = 1, snd = "SportsMan_atak_aidl1"},
			{anim = "idle4", weight = 1, snd = "SportsMan_atak_aidl2"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_sportsman.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "sportsman_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_sportsman.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_volk"},};
actor_sportsman.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_volk"},};
actor_sportsman.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_volk L"},};
actor_sportsman.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_volk R"},};
--------------------
-- RUN
--------------------
actor_sportsman.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_ran"},};
actor_sportsman.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_ran"},};
actor_sportsman.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_ran"},};
actor_sportsman.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_ran"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_sportsman.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "SportsMan_ran"},};
-- начало прыжка			
actor_sportsman.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "SportsMan_ran"},};			

-- зацикленная анимация состояния падения
actor_sportsman.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "SportsMan_ran"},};

-- приземление на бегу
actor_sportsman.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "SportsMan_ran"},};
-- приземление на месте
actor_sportsman.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "SportsMan_ran"},};

----------------------------
-- ATTACK
----------------------------
actor_sportsman.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "SportsMan_atak 1"},
			{anim = "attack2", anim_speed = 1, snd = "SportsMan_atak 2"},	
			{anim = "attack3", anim_speed = 1, snd = "SportsMan_atak 3"},};
actor_sportsman.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack3_out"},};
			
----------------------------
-- ATTACK MISSILE
----------------------------
actor_sportsman.states_design["attack_missile_begin"] = {
			{anim = "attack4", anim_speed = 1, snd = "SportsMan_brosok1"},
			{anim = "attack6", anim_speed = 1, snd = "SportsMan_brosok1"},};

actor_sportsman.states_design["attack_missile_end"] = {
			{anim = "attack4_out"},
			{anim = "attack6_out"},};
			
--------------------
-- PAIN
--------------------
actor_sportsman.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "SportsMan_demidg 1", snd_priority = 1},
			{anim = "pain2", weight = 1, snd = "SportsMan_demidg 2", snd_priority = 1},
			{anim = "pain3", weight = 1, snd = "SportsMan_demidg3", snd_priority = 1},
};
			
			
--------------------
-- DEATH
--------------------
actor_sportsman.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "SportsMan_deth 1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "SportsMan_deth 2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "SportsMan_deth 3", snd_params = snd_actor_death},
};
			
						