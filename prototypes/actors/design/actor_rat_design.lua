------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Rat - монстр крыса
------------------------------------------------------------------------

actor_rat = {};

---------------------------------------------------------------------------------
actor_rat.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"rat" },
	--{ "rag_doll_model",			"rat_ragdoll" },

	{ "stay_height",			0.7  },
	{ "sit_height",				0.7   },
  	{ "body_radius",			0.5	  },

	{ "mass",					2.0 },

	{ "walk_forward_speed",		200.0 },
	{ "walk_backward_speed",	200.0 },
	{ "walk_strafe_speed",		100.0  },
	{ "run_forward_speed",		410.0 },
	{ "run_backward_speed",		410.0 },
	{ "run_strafe_speed",		310.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
	
	-- выравнивать модель по положению нормали земли, на которой стоим
	{ "align_model_to_ground_normal",	true	  },
	-- не колидится с другими актерами
	{ "collide_with_carriers",			false	  },
});
---------------------------------------------------------------------------------
actor_rat.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 20000,
		
	-- настройки для взрыва регдола, после смерти - 
	-- разлета кусков после сильного повреждения
	death_explosion_impulse_threshold = 0;
	death_explosion_damage_threshold = 0;
	-- настроки для взрыва регдола
	death_explosion_effect = "Rat_Blood.lua";
	death_explosion_model_name = "rat";
	death_explosion_debris_model = "rat_debris";
	death_explosion_debris_scattering = 200000;
};

-- настройки hitbox-ов
actor_rat.params.hitboxes = { 
	{name = "Head",		damage_k = 4, },
	{name = "Spine2",	damage_k = 4, },
	{name = "Pelvis",	damage_k = 4, },
    {name = "Tail",		damage_k = 1, },
    {name = "Tail2",	damage_k = 1, },
};


-- параметры атаки
actor_rat.params.attack_info = {};

actor_rat.params.attack_info[0] = {
		id					= ATTACK_PRIMARY,
		type				= ATTACK_MELEE,
		dist				= 2,
		desired_min_dist	= 0,
		desired_max_dist	= 4,
		max_angle			= 6,
		stop_during_attack	= 1, 
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 5,
		impulse				= 0,
		dispersion			= 0,
		offset_pos			= {0, 0, 0.70},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};

actor_rat.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_JUMP,
	dist				= 5,
	real_min_dist			= 2,
	real_max_dist			= 2,
	desired_min_dist		= 0, --4, 
	desired_max_dist		= 1000, 
	max_angle			= 4, 
	stop_during_attack		= 0,
	
	damage_type			= g_damage_type.KNOCK,	
	damage				= 10,
	impulse				= 0,
	dispersion			= 0,
	offset_pos			= {0.70, 0, 1.70},
	
	jump_height			= 0.5,
	
	pause_between_attacks = 4000,
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump",
};


---------------------------------------------------------------------------------
actor_rat.states_design = {};


--------------------
-- IDLE
--------------------
actor_rat.states_design["idle"] = {
	{anim = "idle1_p1", anim_speed = 1, weight = 1},
	{anim = "idle2_p1", anim_speed = 1, weight = 1},
	{anim = "idle3_p1", anim_speed = 1, weight = 1},
};
			
--------------------
-- IDLE ALERT
--------------------
actor_rat.states_design["idle_alert"] = {
	{anim = "alert1", weight = 1, snd = "Rat_alert1"},
};

--------------------
-- IDLE ALERT
--------------------
actor_rat.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "Rat_alert1", snd_params = snd_actor_alert},
};
		

--------------------
-- PAIN
--------------------
actor_rat.states_design["pain"] = {
	{anim = "pain1", weight = 1, snd = "Rat_pain1", snd_params = snd_actor_pain},
	{anim = "pain2", weight = 1, snd = "Rat_pain2", snd_params = snd_actor_pain},
	{anim = "pain3", weight = 1, snd = "Rat_pain3", snd_params = snd_actor_pain},
};
			
--------------------
-- WALK			
--------------------
actor_rat.states_design["forward_walk"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run"},
};
actor_rat.states_design["backward_walk"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run"},
};
actor_rat.states_design["strafe_left_walk"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run"},
};
actor_rat.states_design["strafe_right_walk"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run"},
};

--------------------
-- RUN
--------------------
actor_rat.states_design["forward_run"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run", weight = 40,},
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_pain2", snd_params = snd_actor_alert, weight = 1,},
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_alert1", snd_params = snd_actor_alert, weight = 1,},
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_death1", snd_params = snd_actor_alert, weight = 1,},
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_death2", snd_params = snd_actor_alert, weight = 1,},
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_death3", snd_params = snd_actor_alert, weight = 1,},
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_death4", snd_params = snd_actor_alert, weight = 1,},

};
actor_rat.states_design["backward_run"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run"},
};
actor_rat.states_design["strafe_left_run"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run"},
};
actor_rat.states_design["strafe_right_run"] = {
	{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Rat_run"},
};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_rat.states_design["jump_prepare"] = {
	{anim = "jamp1", anim_speed = 1.0, },
};
-- начало прыжка			
actor_rat.states_design["jump_begin"] = {
	{anim = "jamp2", anim_speed = 1, snd = "Rat_jamp4"},
};

-- зацикленная анимация состояния падения
actor_rat.states_design["fall"] = {
	{anim = "jamp3", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY},
};

-- приземление на бегу
actor_rat.states_design["land_run"] = {
	{anim = "jamp4", anim_speed = 1, snd = "Rat_jamp4"},
};
-- приземление на месте
actor_rat.states_design["land_stand"] = {
	{anim = "jamp4", anim_speed = 1, snd = "Rat_jamp4"},
};

----------------------------
-- ATTACK
----------------------------
actor_rat.states_design["attack_begin"] = {
	{anim = "attack1", anim_speed = 1, snd = "Rat_attack1"},
	{anim = "attack2", anim_speed = 1, snd = "Rat_attack2"},
	{anim = "attack3", anim_speed = 1, snd = "Rat_attack3"},
};

actor_rat.states_design["attack_end"] = {
	{anim = "attack1_out"},
	{anim = "attack2_out"},
	{anim = "attack3_out"},
};

----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_rat.states_design["attack_jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, },};
-- начало прыжка			
actor_rat.states_design["attack_jump_begin"] = {
			{anim = "jamp2", anim_speed = 1.0, snd = "Rat_attack1", snd_params = snd_actor_attack},};			

-- зацикленная анимация состояния падения
actor_rat.states_design["attack_jump_fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY },};

-- приземление на месте
actor_rat.states_design["attack_jump_land_stand"] = {
			{anim = "jamp4", anim_speed = 1.3, snd = "Rat_jamp4", snd_params = snd_actor_attack},};
---------------------------------------------------------------------------------

actor_rat.states_design["custom_idle_eat"] = {
			{anim = "attack1", anim_speed = 1, snd = "Rat_attack1", weight = 1},
			{anim = "attack3", anim_speed = 1, snd = "Rat_attack3", weight = 1},
			};
			
			
----------------------------
-- DEATH
----------------------------
actor_rat.states_design["death"] = {
			{ anim = "dead1", anim_speed = 1, snd = "Rat_death1", snd_params = snd_actor_death},
			{ anim = "dead2", anim_speed = 1, snd = "Rat_death2", snd_params = snd_actor_death},
			{ anim = "dead3", anim_speed = 1, snd = "Rat_death3", snd_params = snd_actor_death},
			{ anim = "dead4", anim_speed = 1, snd = "Rat_death4", snd_params = snd_actor_death},};