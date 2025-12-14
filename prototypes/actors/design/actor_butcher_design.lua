------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Butcher - монстр мясник
------------------------------------------------------------------------

actor_butcher = {};

---------------------------------------------------------------------------------
actor_butcher.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"myaso" },
	{ "rag_doll_model",			"myaso_ragdoll" },

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
	{ "jump_height",			20	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
});
---------------------------------------------------------------------------------
actor_butcher.params = {
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
actor_butcher.params.hitboxes = { 
	{name = "head", damage_k = 4, },
	{name = "pelvis", damage_k = 1, },
    {name = "spine", damage_k = 1, },
    {name = "spine3", damage_k = 1, },
    {name = "lupperArm1", damage_k = 1, },
    {name = "lupperArm2", damage_k = 1, },
    {name = "lthigh1", damage_k = 1, },
    {name = "lthigh2", damage_k = 1, },
    {name = "rthigh2", damage_k = 1, },
    {name = "rthigh1", damage_k = 1, },
};


-- параметры атаки
actor_butcher.params.attack_info = {};

actor_butcher.params.attack_info[0] = {
		id					= ATTACK_PRIMARY,
		type				= ATTACK_MELEE,
		dist				= 2,
		desired_min_dist	= 0,
		desired_max_dist	= 1000,
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


---------------------------------------------------------------------------------
actor_butcher.states_design = {};


--------------------
-- IDLE
--------------------
actor_butcher.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "Myaso_idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "Myaso_idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "Myaso_idle3", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "Myaso_idle4", weight = 1},
			{anim = "idle5", anim_speed = 1, snd = "Myaso_idle5", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_butcher.states_design["idle_alert"] = {
			{anim = "alert1", weight = 1, snd = "Myaso_alert1"},
			{anim = "alert2", weight = 1, snd = "Myaso_alert3"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_butcher.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "myaso_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_butcher.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_walk"},};
actor_butcher.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_walk"},};
actor_butcher.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_step_l"},};
actor_butcher.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_step_r"},};

--------------------
-- RUN
--------------------
actor_butcher.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_run"},};
actor_butcher.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_run"},};
actor_butcher.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_run"},};
actor_butcher.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Myaso_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_butcher.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "Myaso_run"},};
-- начало прыжка			
actor_butcher.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "Myaso_run"},};			

-- зацикленная анимация состояния падения
actor_butcher.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY},};

-- приземление на бегу
actor_butcher.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "Myaso_run"},};
-- приземление на месте
actor_butcher.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "Myaso_run"},};

----------------------------
-- ATTACK
----------------------------
actor_butcher.states_design["attack_begin"] = {

			{anim = "attack1", anim_speed = 1, snd = "Myaso_attack1"},
			{anim = "attack2", anim_speed = 1, snd = "Myaso_attack2"},	
			{anim = "attack3", anim_speed = 1, snd = "Myaso_attack3"},};

actor_butcher.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack3_out"},};
			
--------------------
-- PAIN
--------------------
actor_butcher.states_design["pain"] = {
			{anim = "pain1", anim_speed = 1, weight = 1, snd = "Myaso_pain1", snd_params = snd_actor_pain},
			{anim = "pain2", anim_speed = 1, weight = 1, snd = "Myaso_pain2", snd_params = snd_actor_pain},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "Myaso_pain3", snd_params = snd_actor_pain},
			{anim = "pain4", anim_speed = 1, weight = 1, snd = "Myaso_pain4", snd_params = snd_actor_pain},
			{anim = "pain5", anim_speed = 1, weight = 1, snd = "Myaso_pain5", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_butcher.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Myaso_smert", snd_params = snd_actor_death},
};		