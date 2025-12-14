------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Karl - летающий монстр карлосон
------------------------------------------------------------------------

actor_karl = {};

---------------------------------------------------------------------------------
actor_karl.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"karl" },
	{ "rag_doll_model",			"karl_ragdoll"  },	

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		310.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		450.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			300	  },
	{ "turn_speed",				{180.0, 180.0, 220.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
});

---------------------------------------------------------------------------------
actor_karl.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 30000,
	
	-- эффект горелки 
	nozzle_effect_name = "pfx_welder_nozzle.lua",
	-- точка выброса огня
	nozzle_point = "#shoot_point",
};


-- настройки hitbox-ов
actor_karl.params.hitboxes = { 
	{name = "head", damage_k = 1.5, },
	{name = "pelvis", damage_k = 1, },
    {name = "rupperArm1", damage_k = .3, },
    {name = "rupperArm2", damage_k = .45, },
    {name = "spine", damage_k = 1, },
    {name = "spine3", damage_k = 1, },
    {name = "lupperArm1", damage_k = .3, },
    {name = "lupperArm2", damage_k = .45, },
    {name = "lthigh1", damage_k = .7, },
    {name = "lthigh2", damage_k = .6, },
    {name = "rthigh1", damage_k = .7, },
    {name = "rthigh2", damage_k = .6, },
};

-- параметры атаки
actor_karl.params.attack_info = {};

-- ближняя атака
actor_karl.params.attack_info[0] = {

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

-- атака с прыжка
actor_karl.params.attack_info[1] = {

	type				= ATTACK_JUMP,
	real_min_dist		= 1.8,
	real_max_dist		= 2.2,
	dist				= 18,
	desired_min_dist	= 4, 
	desired_max_dist	= 10, 
	max_angle			= 359,
	stop_during_attack	= 0,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 20,
	impulse				= 2,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	pause_between_attacks = 5000, -- пауза между атаками такого типа
	
	jump_height			= 3,
	
	allowed_bhv			= {BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump",
};

-- атака для приближения к цели
actor_karl.params.attack_info[2] = {

	type				= ATTACK_JUMP,
	real_min_dist		= 0,
	real_max_dist		= 0,
	dist				= 1000,
	desired_min_dist	= 15, 
	desired_max_dist	= 1000, 
	max_angle			= 359,
	stop_during_attack	= 0,
	
	damage_type			= g_damage_type.KNOCK,
	damage				= 0,
	impulse				= 0,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	pause_between_attacks = 8000, -- пауза между атаками такого типа
	
	jump_height			= 7,
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump_approach",
};


---------------------------------------------------------------------------------
actor_karl.states_design = {};


--------------------
-- IDLE
--------------------
actor_karl.states_design["idle"] = {
			{anim = "idle1_p1", anim_speed = 1, snd = "karlson_idle1_p1", weight = 6},
			{anim = "idle2_p1", anim_speed = 1, snd = "karlson_idle2_p1", weight = 1},
			{anim = "idle3_p1", anim_speed = 1, snd = "karlson_idle3_p1", weight = 1},
			{anim = "idle4_p1", anim_speed = 1, snd = "karlson_idle4_p1", weight = 1},
			{anim = "idle5_p1", anim_speed = 1, snd = "karlson_idle5_p1", weight = 3},
};
			
--------------------
-- IDLE ALERT
--------------------
actor_karl.states_design["idle_alert"] = {
			{anim = "alert1_p1", snd = "karlson_alert1_p1", weight = 1},
			--{anim = "alert2_p1", snd = "karlson_alert2_p1", weight = 1},
			};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_karl.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "karlson_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_karl.states_design["forward_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
actor_karl.states_design["backward_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
actor_karl.states_design["strafe_left_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
actor_karl.states_design["strafe_right_walk"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
--------------------
-- RUN
--------------------
actor_karl.states_design["forward_run"] = {
			{anim = "flay1_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_flay1_p4"},
			{anim = "flay2_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_fly2_p4"},
			{anim = "flay3_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_fly3_p4"},};
actor_karl.states_design["backward_run"] = {
			{anim = "flay1_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_flay1_p4"},};
actor_karl.states_design["strafe_left_run"] = {
			{anim = "flay1_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_flay1_p4"},};
actor_karl.states_design["strafe_right_run"] = {
			{anim = "flay1_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_flay1_p4"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_karl.states_design["jump_prepare"] = {
			{anim = "perehod_p1_p4", anim_speed = 1.0, snd = "karlson_perehod_p1_p4"},};
-- начало прыжка			
actor_karl.states_design["jump_begin"] = {
			{anim = "flay1_p4", anim_speed = 1, snd = "karlson_flay1_p4"},};			

-- зацикленная анимация состояния падения
actor_karl.states_design["fall"] = {
			{anim = "flay1_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_flay1_p4"},};

-- приземление на бегу
actor_karl.states_design["land_run"] = {
			{anim = "flay1_p4", anim_speed = 1, snd = "karlson_flay1_p4"},};
-- приземление на месте
actor_karl.states_design["land_stand"] = {
			{anim = "perehod_p4_p1", anim_speed = 1, snd = "karlson_perehod_p4_p1"},};

----------------------------
-- ATTACK
----------------------------
actor_karl.states_design["attack_begin"] = {
			{anim = "attack1_p1", anim_speed = 1, snd = "karlson_attack1_p1"},
			{anim = "attack2_p1", anim_speed = 1, snd = "karlson_attack2_p1"},
			{anim = "attack3_p1", anim_speed = 1, snd = "karlson_attack3_p1"},
			{anim = "attack5_p1", anim_speed = 1, snd = "karlson_attack5_p1"},
			{anim = "flay_jamp_p4", anim_speed = 1, snd = "karlson_fly_jamp_p4"},}; 
actor_karl.states_design["attack_end"] = {
			{anim = "attack1_out_p1",anim_speed = 1,},
			{anim = "attack2_out_p1",anim_speed = 1,},
			{anim = "attack3_out_p1",anim_speed = 1,},
			{anim = "attack5_out_p1",anim_speed = 1,},
			{anim = "flay_jamp_p4_out",anim_speed = 0.8,},};
			
----------------------------
-- ATTACK JUMP 
----------------------------
-- подготовительная фаза прыжка
actor_karl.states_design["attack_jump_prepare"] = {
			{anim = "jump1", anim_speed = 1.0, snd = "karlson_jamp1"},};
-- начало прыжка			
actor_karl.states_design["attack_jump_begin"] = {
			{anim = "jump2", anim_speed = 1.0, snd = "karlson_jamp3"},};			

-- зацикленная анимация состояния падения
actor_karl.states_design["attack_jump_fall"] = {
			{anim = "flay1_p4", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_flay1_p4"},};

-- приземление на месте
actor_karl.states_design["attack_jump_land_stand"] = {
			{anim = "jump4", anim_speed = 1.3, snd = "karlson_fly_jamp_p4"},};


----------------------------
-- ATTACK JUMP APPROACH
----------------------------
-- подготовительная фаза прыжка
actor_karl.states_design["attack_jump_approach_prepare"] = {
			{anim = "perehod_p1_p4", anim_speed = 1.0, snd = "karlson_perehod_p1_p4"},};
-- начало прыжка			
actor_karl.states_design["attack_jump_approach_begin"] = {
			{anim = "flay1_p4", anim_speed = 1, snd = "karlson_flay1_p4"},};			

-- зацикленная анимация состояния падения
actor_karl.states_design["attack_jump_approach_fall"] = {
			{anim = "flay1_p4", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "karlson_flay1_p4"},};

-- приземление на бегу
actor_karl.states_design["attack_jump_approach_land_run"] = {
			{anim = "flay1_p4", anim_speed = 1, snd = "karlson_flay1_p4"},};
-- приземление на месте
actor_karl.states_design["attack_jump_approach_land_stand"] = {
			{anim = "perehod_p4_p1", anim_speed = 1, snd = "karlson_perehod_p4_p1"},};


----------------------------
-- FLY - неожиданный взлет
----------------------------
actor_karl.states_design["fly_idle"] = {
			{anim = "jump5_vzlet_idle", anim_speed = 1.0, snd = "karlson_jamp1"},};
actor_karl.states_design["fly_to_alert"] = {
			{anim = "jump5_vzlet", anim_speed = 1.0, snd = "karlson_jamp3"},};
			
----------------------------
-- Висит на стенке и работает
----------------------------
actor_karl.states_design["idle_working"] = {
			{anim = "idle6_p2", anim_speed = 1.0, snd = "karlson_idle6_p2"},
			{anim = "idle7_p2", anim_speed = 1.0, snd = "karlson_idle7_p2"},
			{anim = "idle8_p2", anim_speed = 1.0, snd = "karlson_pain8_p2"},
			{anim = "idle9_p2", anim_speed = 1.0, snd = "karlson_idle9_p2"},
			{anim = "idle10_p2", anim_speed = 1.0, snd = "karlson_idle10_p2"},
			{anim = "idle11_p2", anim_speed = 1.0, snd = "karlson_idle11_p2"},
			{anim = "idle12_p2", anim_speed = 1.0, snd = "karlson_idle12_p2"},
			{anim = "idle13_p2", anim_speed = 1.0, snd = "karlson_idle13_p2"},
			{anim = "idle14_p2", anim_speed = 1.0, snd = "karlson_idle14_p2"},
			{anim = "idle15_p2", anim_speed = 1.0, snd = "karlson_idle15_p2"},
			};
			
			
--------------------
-- PAIN
--------------------
actor_karl.states_design["pain"] = {
			{anim = "pain1_p1",snd = "karlson_pain1_p1", snd_params = snd_actor_pain},
			{anim = "pain2_p1",snd = "karlson_pain2_p1", snd_params = snd_actor_pain},
			{anim = "pain3_p1",snd = "karlson_pain3_p1", snd_params = snd_actor_pain},
			{anim = "pain4_p1",snd = "karlson_pain4_p1", snd_params = snd_actor_pain},
			{anim = "pain5_p1",snd = "karlson_pain5_p1", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_karl.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Karlson_dead2", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "Karlson_death1", snd_params = snd_actor_death},
};
			