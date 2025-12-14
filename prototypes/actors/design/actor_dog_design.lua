------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Dog - монстр собака
------------------------------------------------------------------------

actor_dog = {};

---------------------------------------------------------------------------------
actor_dog.properties_design  = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"dog" },
	{ "rag_doll_model",			"dog_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		360.0 },
	{ "walk_backward_speed",	180.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		450.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			24	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				70	  },	-- угол обзора (град) 
	{ "view_dist",				15	  },	-- максимальная дальность зрения (м)
	
	
	{ "turn_hands",							  0 },
	{ "allow_head_turn",				false	},
	
	-- выравнивать модель по положению нормали земли, на которой стоим
	{ "align_model_to_ground_normal",	true	  },
	{ "align_model_only_by_pitch",		true	  },
});
---------------------------------------------------------------------------------
actor_dog.params = {
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
actor_dog.params.hitboxes = { 
	{name = "head", damage_k = 2, },
	{name = "pelvis", damage_k = 1.5, },
    {name = "rupperArm1", damage_k = .3, },
    {name = "rupperArm2", damage_k = .3, },
    {name = "spine", damage_k = 1, },
    {name = "spine3", damage_k = 1.2, },
    {name = "lupperArm1", damage_k = .3, },
    {name = "lupperArm2", damage_k = .3, },
    {name = "lthigh1", damage_k = .3, },
    {name = "lthigh2", damage_k = .3, },
    {name = "rthigh1", damage_k = .3, },
    {name = "rthigh2", damage_k = .3, },
};


-- параметры атаки
actor_dog.params.attack_info = {};

actor_dog.params.attack_info[0] = {
	type				= ATTACK_MELEE,
	dist				= 2.2,
	desired_min_dist	= 0, 
	desired_max_dist	= 4, 
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 15,
	impulse				= 0.7,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

-- [[
actor_dog.params.attack_info[1] = {
	type					= ATTACK_JUMP,
	dist					= 5,
	real_min_dist			= 2,
	real_max_dist			= 2,
	desired_min_dist		= 4,
	desired_max_dist		= 1000,
	max_angle			= 4, 
	stop_during_attack	= 0,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 20,
	impulse				= 0.7,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	jump_height			= 0.5,
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump",
};
--]]
---------------------------------------------------------------------------------
actor_dog.states_design = {};

actor_dog.snd_vol = -0.3;

--------------------
-- IDLE
--------------------
actor_dog.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "Dog_idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "Dog_idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "Dog_idle3", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_dog.states_design["idle_alert"] = {
			{anim = "alert1", weight = 1, snd = "Dog_alert1"},
			{anim = "alert2", weight = 1, snd = "Dog_alert2"},
			{anim = "idle7_p3", weight = 1, snd = "Dog_idle7_p3"},
			{anim = "idle8_p3", weight = 1, snd = "Dog_idle8_p3"},
            {anim = "idle9_p3", weight = 1, snd = "Dog_idle9_p3"},
            {anim = "alert1", anim_speed = 0.8, weight = 1, snd = "Dog_alert1"},
			{anim = "alert2", anim_speed = 0.8, weight = 1, snd = "Dog_alert2"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_dog.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "dog_klich", snd_params = snd_actor_alert, snd_vol = actor_dog.snd_vol},
};

--------------------
-- WALK			
--------------------
actor_dog.states_design["forward_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
actor_dog.states_design["backward_walk"] = {
			{anim = "walk2", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
actor_dog.states_design["strafe_left_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
actor_dog.states_design["strafe_right_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};
--------------------
-- RUN
--------------------
actor_dog.states_design["forward_run"] = {
			{anim = "run2", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};
actor_dog.states_design["backward_run"] = {
			{anim = "run2", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};
actor_dog.states_design["strafe_left_run"] = {
			{anim = "run2", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};
actor_dog.states_design["strafe_right_run"] = {
			{anim = "run2", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run2"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_dog.states_design["jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "Dog_run2"},};
-- начало прыжка			
actor_dog.states_design["jump_begin"] = {
			{anim = "jamp2", anim_speed = 1, snd = "Dog_run2"},};			

-- зацикленная анимация состояния падения
actor_dog.states_design["fall"] = {
			{anim = "jamp3", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Dog_run"},};

-- приземление на бегу
actor_dog.states_design["land_run"] = {
			{anim = "jamp5", anim_speed = 1, snd = "Dog_run2"},};
-- приземление на месте
actor_dog.states_design["land_stand"] = {
			{anim = "jamp4", anim_speed = 1, snd = "Dog_run2"},};

----------------------------
-- ATTACK
----------------------------
actor_dog.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "Dog_attack1", snd_params = snd_actor_attack, snd_vol = actor_dog.snd_vol},
			{anim = "attack2", anim_speed = 1, snd = "Dog_attack2", snd_params = snd_actor_attack, snd_vol = actor_dog.snd_vol},
            {anim = "attack3", anim_speed = 1, snd = "Dog_attack3", snd_params = snd_actor_attack, snd_vol = actor_dog.snd_vol},};

actor_dog.states_design["attack_end"] = {
			{anim = "attack1_out", anim_speed = 1,},
			{anim = "attack2_out", anim_speed = 1,},
            {anim = "attack3_out", anim_speed = 0.7,},};
                              
----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_dog.states_design["attack_jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "Dog_run2"},};
-- начало прыжка			
actor_dog.states_design["attack_jump_begin"] = {
			{anim = "jamp2", anim_speed = 1.0, snd = "Dog_run2"},};			

-- зацикленная анимация состояния падения
actor_dog.states_design["attack_jump_fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY },};

-- приземление на месте
actor_dog.states_design["attack_jump_land_stand"] = {
			{anim = "jamp4", anim_speed = 1.3, snd = "Dog_attack2", snd_params = snd_actor_attack},};

--[[
actor_dog.states_design["attack_jump_end"] = {
			{anim = "jamp4", anim_speed = 1.3, snd = "Dog_attack2"},};
		--]]

--------------------
-- CUSTOM IDLE
--------------------
actor_dog.states_design["custom_idle_eat"] = {
			{anim = "idle4_p2", anim_speed = 1, snd = "Dog_idle4_p2", weight = 1},
			{anim = "idle5_p2", anim_speed = 1, snd = "Dog_idle5_p2", weight = 1},
			{anim = "idle6_p2", anim_speed = 1, snd = "Dog_idle6_p2", weight = 1},};
			
--------------------
-- PAIN
--------------------
actor_dog.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "Dog_pain1", snd_params = snd_actor_pain},
			{anim = "pain2", weight = 1, snd = "Dog_pain2", snd_params = snd_actor_pain},
			{anim = "pain3", weight = 1, snd = "Dog_pain3", snd_params = snd_actor_pain},
			{anim = "pain1", weight = 1, snd = "Dog_pain4", snd_params = snd_actor_pain},
			{anim = "pain2", weight = 1, snd = "Dog_pain5", snd_params = snd_actor_pain},
			{anim = "pain3", weight = 1, snd = "Dog_pain6", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_dog.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "dog_death1", snd_params = snd_actor_death, snd_vol = actor_dog.snd_vol},
			{--[[anim = "dead2",--]] weight = 1, snd = "dog_death2", snd_params = snd_actor_death, snd_vol = actor_dog.snd_vol},
			{--[[anim = "dead3",--]] weight = 1, snd = "dog_death3", snd_params = snd_actor_death, snd_vol = actor_dog.snd_vol},
};