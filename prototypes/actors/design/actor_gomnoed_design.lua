------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Gomnoed - монстр плюющейся кислотой
------------------------------------------------------------------------

actor_gomnoed = {};

---------------------------------------------------------------------------------
actor_gomnoed.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"gomnoed" },
	{ "rag_doll_model",			"gomnoed_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		140.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		340.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			30	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
	
	{ "turn_hands",							  0 },
	{ "allow_head_turn",				false	},
	
	-- выравнивать модель по положению нормали земли, на которой стоим
	{ "align_model_to_ground_normal",	true	  },
	{ "align_model_only_by_pitch",		true	  },
});
---------------------------------------------------------------------------------
actor_gomnoed.params = {
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
actor_gomnoed.params.hitboxes = { 
	{name = "head", damage_k = .7, },
	
	{name = "pelvis", damage_k = 1, },
    {name = "spine", damage_k = 1, },
    {name = "spine3", damage_k = 1, },
    
    {name = "rupperArm1", damage_k = .3, },
    {name = "rupperArm2", damage_k = .45, },

    {name = "lupperArm1", damage_k = .3, },
    {name = "lupperArm2", damage_k = .45, },
    {name = "lthigh1", damage_k = .5, },
    {name = "lthigh2", damage_k = .45, },
    {name = "rthigh1", damage_k = .5, },
    {name = "rthigh2", damage_k = .45, },
};

-- параметры атаки
actor_gomnoed.params.attack_info = {};


-- плевание
actor_gomnoed.params.attack_info[0] = {
	type				= ATTACK_DISTANT,
	dist				= 15, 
	desired_min_dist	= 4, 
	desired_max_dist	= 1000, 
	max_angle			= 6, 
	stop_during_attack	= 1,
	
	pause_between_attacks = 3000, -- пауза между атаками такого типа
	
	dispersion			= 0,
	offset_pos			= {0.0, 2.0, 1.3},

	-- коррекция для попадания по параболе: на dist метрах мы целимся на height метров выше.
	height_offset				= {min_height = 0, min_dist = 5, max_dist = 25, max_height = 14}, 
	
	missile						= "ammo_missile_spit",
	missile_velocity			= 1300,
	missile_angular_velocity	= {0, 0, 0},

	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile",
};

-- ближняя атака
actor_gomnoed.params.attack_info[1] = {
		type				= ATTACK_MELEE,
		dist				= 2,
		desired_min_dist	= 0,
		desired_max_dist	= 1000,  
		max_angle			= 6,
		stop_during_attack	= 1, 
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 20,
		impulse				= 1.5,
		dispersion			= 0,
		offset_pos			= {0, 0, 0.70},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};

---------------------------------------------------------------------------------
actor_gomnoed.states_design = {};


--------------------
-- IDLE
--------------------
actor_gomnoed.states_design["idle"] = {
			{anim = "idle_2_p1", anim_speed = 1, snd = "gomnoed_idle_2_p1", weight = 1},
			{anim = "idle_3_p1", anim_speed = 1, snd = "gomnoed_idle_3_p1", weight = 1},
			{anim = "idle_4_p1", anim_speed = 1, snd = "gomnoed_idle_4_p1", weight = 1},
			{anim = "idle_5_p1", anim_speed = 1, snd = "gomnoed_idle_5_p1", weight = 1},
	        {anim = "idle_6_p1", anim_speed = 1, snd = "gomnoed_idle_6_p1", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_gomnoed.states_design["idle_alert"] = {
			{anim = "alert1_p1", weight = 1, snd = "gomnoed_alert1_p1"},
			{anim = "alert2_p1", weight = 1, snd = "gomnoed_alert2_p1"},
			{anim = "alert3_p1", weight = 1, snd = "gomnoed_alert3_p1"},
			{anim = "alert4_p1", weight = 1, snd = "gomnoed_alert4_p1"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_gomnoed.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "gomnoed_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_gomnoed.states_design["forward_walk"] = {
			{anim = "volk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_volk"},};
actor_gomnoed.states_design["backward_walk"] = {
			{anim = "volk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_volk"},};
actor_gomnoed.states_design["strafe_left_walk"] = {
			{anim = "volk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_volk"},};
actor_gomnoed.states_design["strafe_right_walk"] = {
			{anim = "volk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_volk"},};
--------------------
-- RUN
--------------------
actor_gomnoed.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_run"},};
actor_gomnoed.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_run"},};
actor_gomnoed.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_run"},};
actor_gomnoed.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_gomnoed.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "gomnoed_run"},};
-- начало прыжка			
actor_gomnoed.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "gomnoed_run"},};			

-- зацикленная анимация состояния падения
actor_gomnoed.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "gomnoed_run"},};

-- приземление на бегу
actor_gomnoed.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "gomnoed_run"},};
-- приземление на месте
actor_gomnoed.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "gomnoed_run"},};

----------------------------
-- ATTACK
----------------------------
actor_gomnoed.states_design["attack_begin"] = {

			{anim = "atak_1_p1", anim_speed = 1, snd = "gomnoed_atak_1_p1", snd_params = snd_actor_attack},
			{anim = "atak_2_p1", anim_speed = 1, snd = "gomnoed_atak_2_p1", snd_params = snd_actor_attack},	
            {anim = "atak_3_p1", anim_speed = 1, snd = "gomnoed_atak_3_p1", snd_params = snd_actor_attack},
			{anim = "jump_1_in", anim_speed = 0.8, snd = "gomnoed_atak_4_p1", snd_params = snd_actor_attack},
};
           
actor_gomnoed.states_design["attack_end"] = {
			{anim = "atak_1_p1_out"},
			{anim = "atak_2_p1_out"},
            {anim = "atak_3_p1_out"},
            {anim = "jump_1_out", anim_speed = 0.8,},};
			
			

----------------------------
-- ATTACK MISSILE
----------------------------
actor_gomnoed.states_design["attack_missile_begin"] = {
			{anim = "atak_4_p1", anim_speed = 1, snd = "gomnoed_atak_4_p1", snd_params = snd_actor_attack},};

actor_gomnoed.states_design["attack_missile_end"] = {
			{anim = "atak_4_p1_out"},};
			
--------------------
-- PAIN
--------------------
actor_gomnoed.states_design["pain"] = {
		{anim = "pain1_p1", anim_speed = 1, weight = 1, snd = "gomnoed_pain1_p1", snd_params = snd_actor_pain},
		{anim = "pain2_p1", anim_speed = 1, weight = 1, snd = "gomnoed_pain2_p1", snd_params = snd_actor_pain},
		{anim = "pain3_p1", anim_speed = 1, weight = 1, snd = "gomnoed_pain3_p1", snd_params = snd_actor_pain},
		{anim = "pain4_p1", anim_speed = 1, weight = 1, snd = "gomnoed_pain4_p1", snd_params = snd_actor_pain},
		{anim = "pain5_p1", anim_speed = 1, weight = 1, snd = "gomnoed_pain5_p1", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_gomnoed.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "gomnoed_death1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "gomnoed_death2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "gomnoed_death3", snd_params = snd_actor_death},
};
			
			