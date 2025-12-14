------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Pig - монстр поросенок
------------------------------------------------------------------------

actor_pig = {};

---------------------------------------------------------------------------------
actor_pig.properties_design  = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"svin" },
	{ "rag_doll_model",			"svin_ragdoll" },

	{ "stay_height",			1.0  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					2.0 },

	{ "walk_forward_speed",		360.0 },
	{ "walk_backward_speed",	180.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		450.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			60	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				70	  },	-- угол обзора (град) 
	{ "view_dist",				15	  },	-- максимальная дальность зрения (м)
});
---------------------------------------------------------------------------------
actor_pig.params = {
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
actor_pig.params.hitboxes = { 
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
actor_pig.params.attack_info = {};

actor_pig.params.attack_info[0] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_JUMP,
	dist				= 5,
	real_min_dist		= 2,
	real_max_dist		= 2,
	desired_min_dist	= 4,
	desired_max_dist	= 1000,
	max_angle			= 4, 
	stop_during_attack	= 0,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 2,
	impulse				= 0.1,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	jump_height			= 0.5,
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump",
};

---------------------------------------------------------------------------------
actor_pig.states_design = {};


--------------------
-- IDLE
--------------------
actor_pig.states_design["idle"] = 
		{
			{anim = "idle", anim_speed = 1, snd = "Dog_idle1", weight = 1},
		};
		
--------------------
-- IDLE ALERT
--------------------
actor_pig.states_design["idle_alert"] = 
		{
			{anim = "idle", weight = 1, snd = "Dog_alert1"},
		};
--------------------
-- WALK			
--------------------
actor_pig.states_design["forward_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
actor_pig.states_design["backward_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
actor_pig.states_design["strafe_left_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
actor_pig.states_design["strafe_right_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
--------------------
-- RUN
--------------------
actor_pig.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};
actor_pig.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};
actor_pig.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};
actor_pig.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_pig.states_design["jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "Dog_run2"},};
-- начало прыжка			
actor_pig.states_design["jump_begin"] = {
			{anim = "jamp2", anim_speed = 1, snd = "Dog_run2"},};			

-- зацикленная анимация состояния падения
actor_pig.states_design["fall"] = {
			{anim = "jamp3", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};

-- приземление на бегу
actor_pig.states_design["land_run"] = {
			{anim = "jamp4", anim_speed = 1, snd = "Dog_run2"},};
-- приземление на месте
actor_pig.states_design["land_stand"] = {
			{anim = "jamp4", anim_speed = 1, snd = "Dog_run2"},};

----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_pig.states_design["attack_jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "Dog_run2"},};
-- начало прыжка			
actor_pig.states_design["attack_jump_begin"] = {
			{anim = "jamp2", anim_speed = 1.0, snd = "Dog_run2"},};			

-- зацикленная анимация состояния падения
actor_pig.states_design["attack_jump_fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY },};

-- приземление на месте
actor_pig.states_design["attack_jump_land_stand"] = {
			{anim = "jamp4", anim_speed = 1.3, snd = "Dog_attack2"},};

---------------------------------------------------------------------------------                        
			