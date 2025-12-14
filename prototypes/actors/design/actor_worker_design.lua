------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Worker - рабочий с молотом - "Рамштайн"
------------------------------------------------------------------------

actor_worker = {};

---------------------------------------------------------------------------------
actor_worker.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"rab" },
	{ "rag_doll_model",			"rab_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		100.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		100.0  },
	{ "run_forward_speed",		360.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
	
	{ "allow_head_turn",		true	},
	
	
	{ "material_steps",				"mat_actor_human_steps"	},
});
---------------------------------------------------------------------------------
actor_worker.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 20000,
	
	-- Скорость атаки
	attack_speed = 1.3,
};

-- настройки hitbox-ов
actor_worker.params.hitboxes = { 
	{name = "head", damage_k = 1.7, },
	{name = "pelvis", damage_k = .7, },
    {name = "rupperArm1", damage_k = .3, },
    {name = "rupperArm2", damage_k = .45, },
    {name = "spine", damage_k = .7, },
    {name = "spine3", damage_k = .7, },
    {name = "lupperArm1", damage_k = .3, },
    {name = "lupperArm2", damage_k = .45, },
    {name = "lthigh1", damage_k = .5, },
    {name = "lthigh2", damage_k = .45, },
    {name = "rthigh1", damage_k = .5, },
    {name = "rthigh2", damage_k = .45, },
};


-- множители-модификаторы на различные типы повреждений
actor_worker.damage_types_k = {
	[g_damage_type.GUNSHOT] = 1,
	[g_damage_type.FALL] = 1,
	[g_damage_type.KNOCK] = 1,
	[g_damage_type.BLAST] = 1,
	[g_damage_type.BURN] = 1,
};


-- параметры атаки
actor_worker.params.attack_info = {}

actor_worker.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	dist				= 2,
	desired_min_dist	= 0, 
	desired_max_dist	= 4, 
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 20,
	impulse				= 1,
	dispersion			= 0,
	offset_pos			= {0, 0, 1.40},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
	
	hit_material		= "mat_hit_obrez",
};

actor_worker.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_MELEE,
	real_min_dist		= 2,
	real_max_dist		= 2.5,
	dist				= 4.2,
	desired_min_dist	= 3.5, 
	desired_max_dist	= 1000,
	max_angle			= 4, 
	stop_during_attack	= 0,	
	
	damage_type			= g_damage_type.KNOCK,
	damage				= 20,
	impulse				= 2.5,
	dispersion			= 0,
	offset_pos			= {0, 0, 1.70},
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_run",
	visual_state_prefix	= "attack_run",
	
	hit_material		= "mat_hit_obrez",
};

---------------------------------------------------------------------------------
actor_worker.states_design = {};


--------------------
-- IDLE
--------------------
actor_worker.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "ramshtein_idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "ramshtein_idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "ramshtein_idle3", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "ramshtein_idle4", weight = 1},
			{anim = "idle5", anim_speed = 1, snd = "ramshtein_idle5", weight = 1},
	        {anim = "idle6", anim_speed = 1, snd = "ramshtein_idle6", weight = 1},
};
			
--------------------
-- IDLE ALERT
--------------------
actor_worker.states_design["idle_alert"] = {
			{anim = "idle1", weight = 1, snd = "ramshtein_idle1"},
			{anim = "idle2", weight = 1, snd = "ramshtein_idle2"},
			{anim = "idle4", weight = 1, snd = "ramshtein_idle4"},
			{anim = "idle5", weight = 1, snd = "ramshtein_idle5"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_worker.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "ramstein_klich", snd_params = snd_actor_alert},
};

--------------------
-- IDLE KEEP QUIET
--------------------
actor_worker.states_design["idle_keep_quiet"] = {
			{anim = "idle1", weight = 1},
			{anim = "idle2", weight = 1},
			{anim = "idle4", weight = 1},
			{anim = "idle5", weight = 1},
};
			
--------------------
-- WALK			
--------------------
actor_worker.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_walk"},};
actor_worker.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_walk"},};
actor_worker.states_design["strafe_left_walk"] = {
			{anim = "r", anim_speed = 1.3, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_walk"},};
actor_worker.states_design["strafe_right_walk"] = {
			{anim = "l", anim_speed = 1.3, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_walk"},};
--------------------
-- RUN
--------------------
actor_worker.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, weight = 5, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_run"},
            --{anim = "run_2", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_run"},
            };
actor_worker.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_run"},};
actor_worker.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_run"},};
actor_worker.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_worker.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "ramshtein_run"},};
-- начало прыжка			
actor_worker.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "ramshtein_run"},};			

-- зацикленная анимация состояния падения
actor_worker.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "ramshtein_run"},};

-- приземление на бегу
actor_worker.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "ramshtein_run"},};
-- приземление на месте
actor_worker.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "ramshtein_run"},};

----------------------------
-- ATTACK
----------------------------
actor_worker.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = actor_worker.params.attack_speed, snd = "ramshtein_attack1", snd_vol = SND_ACTOR_SHOT_VOL, snd_dist_min = 15, snd_dist_max = 37, snd_priority = 1},
			{anim = "attack2", anim_speed = actor_worker.params.attack_speed, snd = "ramshtein_attack2", snd_vol = SND_ACTOR_SHOT_VOL, snd_dist_min = 15, snd_dist_max = 37, snd_priority = 1},
};

actor_worker.states_design["attack_end"] = {
			{anim = "attack1_out", anim_speed = actor_worker.params.attack_speed,},
			{anim = "attack2_out", anim_speed = actor_worker.params.attack_speed,},
};
			
----------------------------
-- ATTACK RUN
----------------------------
actor_worker.states_design["attack_run_begin"] = {
			{anim = "run_attack", anim_speed = actor_worker.params.attack_speed, weight = 1, snd = "ramshtein_attack2", snd_vol = SND_ACTOR_SHOT_VOL, snd_dist_min = 15, snd_dist_max = 37, snd_priority = 1},
			};
			
actor_worker.states_design["attack_run_end"] = {
			{anim = "run_attack_out", anim_speed = actor_worker.params.attack_speed, weight = 1},
			};			
		
			
--------------------
-- PAIN
--------------------
actor_worker.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "ramshtein_pain1", snd_priority = 1},
			{anim = "pain2", weight = 1, snd = "ramshtein_pain2", snd_priority = 1},
			{anim = "pain3", weight = 1, snd = "ramshtein_pain3", snd_priority = 1},
			{anim = "pain4", weight = 1, snd = "ramshtein_pain4", snd_priority = 1},
			{anim = "pain5", weight = 1, snd = "ramshtein_pain5", snd_priority = 1},};
			
			
--------------------
-- DEATH
--------------------
actor_worker.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "ramshtein_death1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "ramshtein_death2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "ramshtein_death3", snd_params = snd_actor_death},
};
			
			
