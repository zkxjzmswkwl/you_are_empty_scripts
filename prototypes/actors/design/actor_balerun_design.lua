------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Balerun - NPC балерун
------------------------------------------------------------------------

actor_balerun = {};

---------------------------------------------------------------------------------
actor_balerun.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"balerun" },
	{ "rag_doll_model",			"balerun_ragdoll"  },	

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
actor_balerun.params = {
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
actor_balerun.params.hitboxes = { 
	{name = "head", damage_k = 1.7, },
	{name = "pelvis", damage_k = 1, },
    {name = "rupperArm1", damage_k = .3, },
    {name = "rupperArm2", damage_k = .45, },
    {name = "spine", damage_k = 1, },
    {name = "spine1", damage_k = 1, },
    {name = "spine2", damage_k = 1, },
    {name = "spine1", damage_k = 1, },
    {name = "lupperArm1", damage_k = .3, },
    {name = "lupperArm2", damage_k = .45, },
    {name = "lthigh1", damage_k = .5, },
    {name = "lthigh2", damage_k = .45, },
    {name = "rthigh1", damage_k = .5, },
    {name = "rthigh2", damage_k = .45, },
};

-- параметры атаки
actor_balerun.params.attack_info = {};

actor_balerun.params.attack_info[0] = {
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
		offset_pos			= {0, 0, 1.55},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};


---------------------------------------------------------------------------------
actor_balerun.states_design = {};


--------------------
-- IDLE
--------------------
actor_balerun.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "balerun_idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "balerun_idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "balerun_idle3", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "balerun_idle4", weight = 1},};

--------------------
-- IDLE ALERT
--------------------
actor_balerun.states_design["idle_alert"] = {
			{anim = "idle1", anim_speed = 1, snd = "balerun_idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "balerun_idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "balerun_idle3", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "balerun_idle4", weight = 1},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_balerun.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "balerun_idle1", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_balerun.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_walk"},};
actor_balerun.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_walk"},};
actor_balerun.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_walk"},};
actor_balerun.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_walk"},};
--------------------
-- RUN
--------------------
actor_balerun.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_run"},};
actor_balerun.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_run"},};
actor_balerun.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_run"},};
actor_balerun.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_balerun.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "balerun_run"},};
-- начало прыжка			
actor_balerun.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "balerun_run"},};			

-- зацикленная анимация состояния падения
actor_balerun.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "balerun_run"},};

-- приземление на бегу
actor_balerun.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "balerun_run"},};
-- приземление на месте
actor_balerun.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "balerun_run"},};

----------------------------
-- ATTACK
----------------------------
actor_balerun.states_design["attack_begin"] = {
						{anim = "idle1", anim_speed = 1, snd = "balerun_idle1", weight = 1},
						{anim = "idle2", anim_speed = 1, snd = "balerun_idle2", weight = 1},
						{anim = "idle3", anim_speed = 1, snd = "balerun_idle3", weight = 1},
						{anim = "idle4", anim_speed = 1, snd = "balerun_idle4", weight = 1},}; 
actor_balerun.states_design["attack_end"] = {
						{anim = "idle4", anim_speed = 1, snd = "balerun_idle4", weight = 1},
						{anim = "idle3", anim_speed = 1, snd = "balerun_idle3", weight = 1},
						{anim = "idle2", anim_speed = 1, snd = "balerun_idle2", weight = 1},
						{anim = "idle1", anim_speed = 1, snd = "balerun_idle1", weight = 1},};
		
--------------------
-- TALK
--------------------
actor_balerun.states_design["talk"] = {
			{anim = "progon", anim_speed = 1, weight = 1, snd = "Operatciya_Balerun_Progon",  snd_params = snd_actor_attack,},
			};		
			
--------------------
-- PAIN
--------------------
actor_balerun.states_design["pain"] = {
			{anim = "pain1", anim_speed = 1, weight = 1, snd = "balerun_pain1", snd_params = snd_actor_pain},
			{anim = "pain2", anim_speed = 1, weight = 1, snd = "balerun_pain2", snd_params = snd_actor_pain},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "balerun_pain3", snd_params = snd_actor_pain},};
			
--------------------
-- DEATH
--------------------
actor_balerun.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "balerun_pain1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "balerun_pain2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "balerun_pain3", snd_params = snd_actor_death},
};
			
