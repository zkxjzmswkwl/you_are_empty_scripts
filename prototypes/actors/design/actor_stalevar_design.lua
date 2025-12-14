------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Stalevar - монстр сталевар
------------------------------------------------------------------------

actor_stalevar = {};

---------------------------------------------------------------------------------
actor_stalevar.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"stal" },
	{ "rag_doll_model",			"stal_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		150.0 },
	{ "walk_backward_speed",		150.0 },
	{ "walk_strafe_speed",		80.0  },
	{ "run_forward_speed",		350.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			30	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
});
---------------------------------------------------------------------------------
actor_stalevar.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 2000,
};


-- настройки hitbox-ов
actor_stalevar.params.hitboxes = { 
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
actor_stalevar.params.attack_info = {};

actor_stalevar.params.attack_info[0] = {
		type				= ATTACK_MELEE,
		dist				= 2,
		desired_min_dist	= 0,
		desired_max_dist	= 3, 
		max_angle			= 6,
		stop_during_attack		= 1,
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 25,
		impulse				= 1.2,
		dispersion			= 0,
		offset_pos			= {0, 0, 1.40},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};

actor_stalevar.params.attack_info[1] = {
		type				= ATTACK_MELEE,
		
		real_min_dist		= 2.5,
		real_max_dist		= 2.5,
		
		dist				= 5,
		desired_min_dist	= 3, 
		desired_max_dist	= 1000, 
		max_angle			= 4,
		stop_during_attack	= 0,
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 25,
		impulse				= 1.2,
		dispersion			= 0,
		offset_pos			= {0, 0, 1.70},
		
		pause_between_attacks = 2000, -- пауза между атаками такого типа
		
		allowed_bhv			= {BHV_WALK},
		fsm_state			= "attack_run",
		visual_state_prefix	= "attack_run",
};



---------------------------------------------------------------------------------
actor_stalevar.states_design = {};


--------------------
-- IDLE
--------------------
actor_stalevar.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "Stalevar_aydl1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "Stalevar_aydl2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "Stalevar_aydl3", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "Stalevar_aydl4", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_stalevar.states_design["idle_alert"] = {
			{anim = "idle1", weight = 1, snd = "Stalevar_aydl1"},
			{anim = "idle2", weight = 1, snd = "Stalevar_aydl2"},
			{anim = "idle3", weight = 1, snd = "Stalevar_aydl3"},
			{anim = "idle4", weight = 1, snd = "Stalevar_aydl4"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_stalevar.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "stalevar_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_stalevar.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_volk"},};
actor_stalevar.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_volk"},};
actor_stalevar.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_left"},};
actor_stalevar.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_rayt"},};
--------------------
-- RUN
--------------------
actor_stalevar.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_ran"},};
actor_stalevar.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_ran"},};
actor_stalevar.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_ran"},};
actor_stalevar.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_ran"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_stalevar.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "Stalevar_ran"},};
-- начало прыжка			
actor_stalevar.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "Stalevar_ran"},};			

-- зацикленная анимация состояния падения
actor_stalevar.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Stalevar_ran"},};

-- приземление на бегу
actor_stalevar.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "Stalevar_ran"},};
-- приземление на месте
actor_stalevar.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "Stalevar_ran"},};

----------------------------
-- ATTACK
----------------------------
actor_stalevar.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "Stalevar_udar1", snd_params = snd_actor_attack},
			{anim = "attack2", anim_speed = 1, snd = "Stalevar_udar2", snd_params = snd_actor_attack},
			{anim = "attack3", anim_speed = 1, snd = "Stalevar_udar3", snd_params = snd_actor_attack},
			{anim = "attack1", anim_speed = 1.3, snd = "Stalevar_udar1", snd_params = snd_actor_attack},
			{anim = "attack2", anim_speed = 1.3, snd = "Stalevar_udar2", snd_params = snd_actor_attack},
			{anim = "attack3", anim_speed = 1.3, snd = "Stalevar_udar3", snd_params = snd_actor_attack},	};

actor_stalevar.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack3_out"},
			{anim = "attack1_out", anim_speed = 1.3,},
			{anim = "attack2_out", anim_speed = 1.3,},
			{anim = "attack3_out", anim_speed = 1.3,},};
                        
----------------------------
-- ATTACK RUN
----------------------------
actor_stalevar.states_design["attack_run_begin"] = {
			{anim = "attack_run", anim_speed = 1, weight = 1, snd = "Stalevar_udar3", snd_params = snd_actor_attack},
			};
			
actor_stalevar.states_design["attack_run_end"] = {
			{anim = "attack_run_out", anim_speed = 1, weight = 1},
			};			                        

----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_stalevar.states_design["attack_jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "Stalevar_udar1"},};
-- начало прыжка			
actor_stalevar.states_design["attack_jump_begin"] = {
			{anim = "jamp2", anim_speed = 1.0, snd = "Stalevar_udar2"},};			

-- зацикленная анимация состояния падения
actor_stalevar.states_design["attack_jump_fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY },};

-- приземление на месте
actor_stalevar.states_design["attack_jump_land_stand"] = {
			{anim = "jamp4_attack", anim_speed = 1.3, snd = "Stalevar_udar1"},};
--------------------
-- PAIN
--------------------
actor_stalevar.states_design["pain"] = {
			{anim = "pain1", anim_speed = 1, weight = 1, snd = "Stalevar_demidg1", snd_params = snd_actor_pain},
			{anim = "pain2", anim_speed = 1, weight = 1, snd = "Stalevar_demidg2", snd_params = snd_actor_pain},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "Stalevar_demidg3", snd_params = snd_actor_pain},
			{anim = "pain4", anim_speed = 1, weight = 1, snd = "Stalevar_demidg4", snd_params = snd_actor_pain},
			{anim = "pain5", anim_speed = 1, weight = 1, snd = "Stalevar_demidg5", snd_params = snd_actor_pain},};
			
--------------------
-- DEATH
--------------------
actor_stalevar.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Stalevar_smert1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "Stalevar_smert2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "Stalevar_smert3", snd_params = snd_actor_death},};