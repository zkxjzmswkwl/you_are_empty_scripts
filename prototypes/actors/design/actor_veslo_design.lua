------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Veslo - девушка с веслом
------------------------------------------------------------------------

actor_veslo = {};

---------------------------------------------------------------------------------
actor_veslo.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"veslo" },
	{ "rag_doll_model",			"veslo_ragdoll" },
	{ "material_body_default",		"mat_beton"	},

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
actor_veslo.params = {
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
actor_veslo.params.hitboxes = { 
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
actor_veslo.params.attack_info = {};

actor_veslo.params.attack_info[0] = {
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
-- [[
actor_veslo.params.attack_info[1] = {
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
	impulse				= 3,
	dispersion			= 0,
	offset_pos			= {0, 0, 1.40},
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_run",
	visual_state_prefix	= "attack_run",
};
--]]

actor_veslo.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_JUMP,
	dist				= 5,
	real_min_dist		= 3,
	real_max_dist		= 3,
	desired_min_dist	= 4, 
	desired_max_dist	= 1000, 
	max_angle			= 4, 
	stop_during_attack	= 0,
	
	damage_type			= g_damage_type.KNOCK,	
	damage				= 20,
	impulse				= 2,
	dispersion			= 0,
	offset_pos			= {0.70, 0, 1.70},
	
	jump_height			= 0.5,
	
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump",
};

---------------------------------------------------------------------------------
actor_veslo.states_design = {};

--------------------
-- IDLE
--------------------
actor_veslo.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "Medsestra_idle1", weight = 1},
};
			
--------------------
-- IDLE ALERT
--------------------
actor_veslo.states_design["idle_alert"] = {
			{anim = "idle1", weight = 1, snd = "Medsestra_idle2"},
			{anim = "idle2", weight = 1, snd = "Medsestra_idle3"},};
			
-------------------------------------------------------------
-- TRANSITION TO IDLE ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_veslo.states_design["transition_to_alert"] = {
			{anim = "perehodp1_alert", weight = 1, snd = "Ded_pain3"},
			{anim = "perehodp2_alert", weight = 1, snd = "Ded_pain3"},
			{anim = "perehodp3_alert", weight = 1, snd = "Ded_pain3"},
};
			
--------------------
-- PAIN
--------------------
actor_veslo.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "Ded_pain1"},
			{anim = "pain2", weight = 1, snd = "Ded_pain2"},
			{anim = "pain3", weight = 1, snd = "Ded_pain3"},
};

--------------------
-- WALK			
--------------------
actor_veslo.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_walk"},};
actor_veslo.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_walk"},};
actor_veslo.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_jumpL"},};
actor_veslo.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_jumpR"},};

--------------------
-- RUN
--------------------
actor_veslo.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};
actor_veslo.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};
actor_veslo.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};
actor_veslo.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Medsestra_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_veslo.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "Medsestra_run"},};
-- начало прыжка			
actor_veslo.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "Medsestra_run"},};			

-- зацикленная анимация состояния падения
actor_veslo.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY},};

-- приземление на бегу
actor_veslo.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "Medsestra_run"},};
-- приземление на месте
actor_veslo.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "Medsestra_run"},};

----------------------------
-- ATTACK
----------------------------
actor_veslo.states_design["attack_begin"] = {
--			{anim = "attack1", anim_speed = 1, snd = "Medsestra_attack1"},
			{anim = "attack2", anim_speed = 1, snd = "Medsestra_attack2"},	
			{anim = "attack3", anim_speed = 1, snd = "Medsestra_attack3"},
--			{anim = "attack4", anim_speed = 1, snd = "Medsestra_attack4"},
--			{anim = "attack5", anim_speed = 1, snd = "Medsestra_attack5"},
};

actor_veslo.states_design["attack_end"] = {
--			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack3_out"},
--			{anim = "attack4_out"},
--			{anim = "attack5_out"},
};

----------------------------
-- ATTACK RUN
----------------------------
actor_veslo.states_design["attack_run_begin"] = {
			{anim = "run_udar", anim_speed = 1, snd = "Medsestra_attack1"},
};

actor_veslo.states_design["attack_run_end"] = {
			{anim = "run_udar", anim_speed = 1, snd = "Medsestra_attack1"},
};

----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_veslo.states_design["attack_jump_prepare"] = {
			{anim = "jamp_run", anim_speed = 1.0, snd = "Fireman_Run"},
			{anim = "jamp_run1", anim_speed = 1.0, snd = "Fireman_Run"},
};
-- начало прыжка			
actor_veslo.states_design["attack_jump_begin"] = {
			{anim = "jamp_stey", anim_speed = 1.0, snd = "Fireman_Damage4"},
			{anim = "jamp_stey1", anim_speed = 1.0, snd = "Fireman_Damage4"},
};			

-- зацикленная анимация состояния падения
actor_veslo.states_design["attack_jump_fall"] = {
			{anim = "jamp_stey_attack", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY },
			{anim = "jamp_stey_attack1", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY },
};

-- приземление на месте
actor_veslo.states_design["attack_jump_land_stand"] = {
			{anim = "jamp_run_attack", anim_speed = 1.3, snd = "Fireman_Kick1"},
			{anim = "jamp_run_attack1", anim_speed = 1.3, snd = "Fireman_Kick1"},
};
---------------------------------------------------------------------------------