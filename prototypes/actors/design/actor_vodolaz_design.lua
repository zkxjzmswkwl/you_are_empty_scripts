------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Vodolaz - монстр водолаз
------------------------------------------------------------------------


actor_vodolaz = {};

---------------------------------------------------------------------------------
actor_vodolaz.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"vod" },
	{ "rag_doll_model",			"vod_ragdoll"  },
	
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
	{ "jump_height",			120	  },
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
});

---------------------------------------------------------------------------------
actor_vodolaz.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 20, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 0.5,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 40000,
};

-- настройки hitbox-ов
actor_vodolaz.params.hitboxes = { 
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
actor_vodolaz.params.attack_info = {};

actor_vodolaz.params.attack_info[0] = {
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
	offset_pos			= {0, 0, 0.70},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

actor_vodolaz.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_JUMP,
	dist				= 8, 
	desired_min_dist	= 4, 
	desired_max_dist	= 1000, 
	max_angle			= 4, 
	stop_during_attack	= 0,
	
	damage_type			= g_damage_type.KNOCK,
	damage				= 20,
	impulse				= 2,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	jump_height			= 0.5,
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump",
};

---------------------------------------------------------------------------------
actor_vodolaz.states_design = {};

--------------------
-- IDLE
--------------------
actor_vodolaz.states_design["idle"] = {
			{anim = "idle1", snd = "Fireman_Idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "Fireman_Idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "Fireman_Idle3", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_vodolaz.states_design["idle_alert"] = {
			{anim = "alert1", weight = 1},
			{anim = "alert2", weight = 1},};
--------------------
-- WALK			
--------------------
actor_vodolaz.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk"},};
actor_vodolaz.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk"},};
actor_vodolaz.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk"},};
actor_vodolaz.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk"},};
--------------------
-- RUN
--------------------
actor_vodolaz.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY,--[[ anim_bone_group = "upper_model",--]] snd = "Fireman_Run"},};
actor_vodolaz.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
actor_vodolaz.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
actor_vodolaz.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_vodolaz.states_design["jump_prepare"] = {
			{anim = "jump5", anim_speed = 1.0, snd = "Fireman_Run"},};
-- начало прыжка			
actor_vodolaz.states_design["jump_begin"] = {
			{anim = "jump6", anim_speed = 1.0, snd = "Fireman_Run"},};			

-- зацикленная анимация состояния падения
actor_vodolaz.states_design["fall"] = {
			{anim = "jump3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};

-- приземление на бегу
actor_vodolaz.states_design["land_run"] = {
			{anim = "jump7", anim_speed = 1, snd = "Fireman_Run"},};
-- приземление на месте
actor_vodolaz.states_design["land_stand"] = {
			{anim = "jump4", anim_speed = 1, snd = "Fireman_Run"},};

----------------------------
-- ATTACK
----------------------------
actor_vodolaz.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "Fireman_Kick1"},
			{anim = "attack2", anim_speed = 1, snd = "Fireman_Kick2"},
			{anim = "attack3", anim_speed = 1, snd = "Fireman_Kick3"},};
actor_vodolaz.states_design["attack_end"] = {
			{anim = "attack1_out", anim_speed = 1, snd = "Fireman_Kick1"},
			{anim = "attack2_out", anim_speed = 1, snd = "Fireman_Kick2"},
			{anim = "attack3_out", anim_speed = 1, snd = "Fireman_Kick3"},};

----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_vodolaz.states_design["attack_jump_prepare"] = {
			{anim = "jump5", anim_speed = 1.0, snd = "Fireman_Run"},};
-- начало прыжка			
actor_vodolaz.states_design["attack_jump_begin"] = {
			{anim = "jump6", anim_speed = 1.0, snd = "Fireman_Run"},};			

-- зацикленная анимация состояния падения
actor_vodolaz.states_design["attack_jump_fall"] = {
			{anim = "jump3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};

-- приземление на месте
actor_vodolaz.states_design["attack_jump_land_stand"] = {
			{anim = "jump4", anim_speed = 1.0, snd = "Fireman_Run"},};

---------------------------------------------------------------------------------