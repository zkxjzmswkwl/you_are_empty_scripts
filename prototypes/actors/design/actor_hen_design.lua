------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Hen - монстр курица
------------------------------------------------------------------------

actor_hen = {};

---------------------------------------------------------------------------------
actor_hen.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"kur" },
	{ "rag_doll_model",			"kur_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		300.0 },
	{ "walk_backward_speed",	300.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		510.0 },
	{ "run_backward_speed",		510.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			160	  },
	{ "turn_speed",				{180.0, 180.0, 180.0}  }, -- углова€ скорость поворота
	
	-- праметры зрени€
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальна€ дальность зрени€ (м)
});
---------------------------------------------------------------------------------
actor_hen.params = {
	-- поворот тела относительно головы при ходьбе пр€мо и вбок
	body_rotate_forward_strafe = 30,
	-- врем€ падени€ после которого начинает отыгрывать€ анимаци€ падени€
	falling_time = 2, 
	-- высота, выше которой включаетс€ анимаци€ падени€
	above_ground_level = 2,
	-- врем€ в течении которого персонаж должен находитс€ в состо€нии
	-- idle_alert после последней атаки
	aggresive_stance_time = 30000,
};


-- настройки hitbox-ов
actor_hen.params.hitboxes = { 
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
actor_hen.params.attack_info = {};

actor_hen.params.attack_info[0] = {
		id					= ATTACK_PRIMARY,
		type				= ATTACK_MELEE,
		dist				= 4,
		desired_min_dist	= 0,
		desired_max_dist	= 4, 
		max_angle			= 6,
		stop_during_attack	= 1,
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 20,
		impulse				= 0.8,
		dispersion			= 0,
		offset_pos			= {0, 0, 1.40},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};


actor_hen.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
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
	impulse				= 1,
	dispersion			= 0,
	offset_pos			= {0, 0, 1.40},
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_run",
	visual_state_prefix	= "attack_run",
};


---------------------------------------------------------------------------------
actor_hen.states_design = {};


--------------------
-- IDLE
--------------------
actor_hen.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1.0, snd = "kurva_idle1", weight = 1},
			{anim = "idle2", anim_speed = 1.0, snd = "kurva_idle2", weight = 1},
			{anim = "idle3", anim_speed = 1.0, snd = "kurva_idle3", weight = 1},};
--------------------
-- IDLE ALERT
--------------------
actor_hen.states_design["idle_alert"] = {
			{anim = "alert1", anim_speed = 1.0,weight = 1, snd = "kurva_alert1"},
			{anim = "alert2", anim_speed = 1.0,weight = 1, snd = "kurva_alert2"},
			{anim = "alert3", anim_speed = 1.0,weight = 1, snd = "kurva_alert3"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (ѕереход в агрессивное состо€ние)
-------------------------------------------------------------
actor_hen.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "kurva_klich", snd_params = snd_actor_alert},
};

--------------------
-- IDLE KLUV
--------------------
actor_hen.states_design["idle_kluv"] = {
			{anim = "kluv_1", anim_speed = 1, weight = 0.9, snd = ""},
			{anim = "kluv_2", anim_speed = 1, weight = 1.5, snd = ""},
			{anim = "kluv_3", anim_speed = 1, weight = 1.2, snd = ""},};
--------------------
-- WALK			
--------------------
actor_hen.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_walk"},};
actor_hen.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_walk"},};
actor_hen.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_walk"},};
actor_hen.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_walk"},};
--------------------
-- RUN
--------------------
actor_hen.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_run"},};
actor_hen.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_run"},};
actor_hen.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_run"},};
actor_hen.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительна€ фаза прыжка
actor_hen.states_design["jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "kurva_jamp1"},};
-- начало прыжка			
actor_hen.states_design["jump_begin"] = {
			{anim = "jamp2", anim_speed = 1, snd = "kurva_jamp2"},};			

-- зацикленна€ анимаци€ состо€ни€ падени€
actor_hen.states_design["fall"] = {
			{anim = "jamp3", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kurva_jamp3"},};

-- приземление на бегу
actor_hen.states_design["land_run"] = {
			{anim = "jamp9", anim_speed = 1, snd = "kurva_jamp9"},};
-- приземление на месте
actor_hen.states_design["land_stand"] = {
			{anim = "jamp4", anim_speed = 1, snd = "kurva_jamp4"},};

----------------------------
-- ATTACK
----------------------------
actor_hen.states_design["attack_begin"] = {

			{anim = "attack1", anim_speed = 1, snd = "kurva_attack1"},
			{anim = "attack2", anim_speed = 1, snd = "kurva_attack2"},	
			{anim = "attack3", anim_speed = 1, snd = "kurva_attack3"},	
			{anim = "attack4", anim_speed = 1, snd = "kurva_attack4"},	
			{anim = "attack5", anim_speed = 1, snd = "kurva_attack5"},	
			{anim = "attack6", anim_speed = 1, snd = "kurva_attack6"},};

actor_hen.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack3_out"},
			{anim = "attack4_out"},
			{anim = "attack5_out"},
			{anim = "attack6_out"},};

----------------------------
-- ATTACK RUN
----------------------------
actor_hen.states_design["attack_run_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "kurva_attack1"},};

actor_hen.states_design["attack_run_end"] = {
			{anim = "attack1_out"},};
			
--------------------
-- PAIN
--------------------
actor_hen.states_design["pain"] = {
			{anim = "pain1", anim_speed = 1, weight = 1, snd = "kurva_pain1", snd_params = snd_actor_pain},
			{anim = "pain2", anim_speed = 1, weight = 1, snd = "kurva_pain2", snd_params = snd_actor_pain},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "kurva_pain3", snd_params = snd_actor_pain},
			{anim = "pain4", anim_speed = 1, weight = 1, snd = "kurva_pain4", snd_params = snd_actor_pain},
			{anim = "pain5", anim_speed = 1, weight = 1, snd = "kurva_pain5", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_hen.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "kurva_death1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "kurva_death2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "kurva_death3", snd_params = snd_actor_death},
};					