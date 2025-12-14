------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Prima - монстр прима
------------------------------------------------------------------------

actor_prima = {};

---------------------------------------------------------------------------------
actor_prima.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"nurse" },
	{ "rag_doll_model",			"nurse_ragdoll"  },	

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		100.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		360.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			40.0	  },
	{ "turn_speed",				{680.0, 680.0, 680.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
});

---------------------------------------------------------------------------------
actor_prima.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 1,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 60000,
};


-- настройки hitbox-ов
actor_prima.params.hitboxes = { 
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
actor_prima.params.attack_info = {};

actor_prima.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	dist				= 2,
	desired_min_dist	= 0, 
	desired_max_dist	= 8,
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 2,
	impulse				= 0.2,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

actor_prima.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_DISTANT,
	dist				= 15, 
	desired_min_dist	= 8, 
	desired_max_dist	= 1000, 
	max_angle			= 6, 
	stop_during_attack	= 1,
	
	dispersion			= 0,
	offset_pos			= {0, 0.70, 1.70},
	
	missile						= "ammo_missile_song",
	missile_velocity			= 2000,
	missile_angular_velocity	= {0, 0, 0},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile",
};







---------------------------------------------------------------------------------
actor_prima.states_design = {};


--------------------
-- IDLE
--------------------
actor_prima.states_design["idle"] = {
			{anim = "idle2", anim_speed = 1, snd = "Medsestra_idle1", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "Medsestra_idle2", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "Medsestra_idle3", weight = 1},
			{anim = "idle5", anim_speed = 1, snd = "Medsestra_idle5", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_prima.states_design["idle_alert"] = {
			{anim = "alert1", anim_speed = 0.9, snd = "Medsestra_idle1", weight = 1},
			{anim = "alert2", anim_speed = 0.9, snd = "Medsestra_idle2", weight = 1},
			{anim = "alert1", anim_speed = 1.6, snd = "Medsestra_idle3", weight = 1},
			{anim = "alert2", anim_speed = 1.6, snd = "Medsestra_idle5", weight = 1},};
			
--------------------
-- WALK			
--------------------
actor_prima.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_walk"},};
actor_prima.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_walk"},};
actor_prima.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_jumpL"},};
actor_prima.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_jumpR"},};
--------------------
-- RUN
--------------------
actor_prima.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};
actor_prima.states_design["backward_run"] = {
			{anim = "run2", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};
actor_prima.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};
actor_prima.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_prima.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, },};
-- начало прыжка			
actor_prima.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, },};			

-- зацикленная анимация состояния падения
actor_prima.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY,},};

-- приземление на бегу
actor_prima.states_design["land_run"] = {
			{anim = "jump1", anim_speed = 1, },};
-- приземление на месте
actor_prima.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, },};




----------------------------
-- ATTACK
----------------------------
actor_prima.states_design["attack_begin"] = {

			{anim = "attack1", anim_speed = 1, snd = "Medsestra_attack1"},
			--{anim = "attack2", anim_speed = 1, snd = "Medsestra_attack2"},
			{anim = "attack3", anim_speed = 1, snd = "Medsestra_attack3"},};

actor_prima.states_design["attack_end"] = {
			{anim = "attack1_out"},
			--{anim = "attack2_out"},
			{anim = "attack3_out"},};


----------------------------
-- ATTACK MISSILE
----------------------------
actor_prima.states_design["attack_missile_begin"] = {
			{anim = "attack2", anim_speed = 1, snd = "Medsestra_attack2"},};

actor_prima.states_design["attack_missile_end"] = {
			{anim = "attack2_out"},};

