------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Electro - монстр электрик
------------------------------------------------------------------------

actor_electro = {};

---------------------------------------------------------------------------------
actor_electro.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"elektro" },
	{ "rag_doll_model",			"elektro_ragdoll"  },	

	{ "stay_height",			1.60  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.8	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		300.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		560.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			130 },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				35	  },	-- максимальная дальность зрения (м)
	
	-- выравнивать модель по положению нормали земли, на которой стоим
	{ "align_model_to_ground_normal",	true	  },
	{ "align_model_only_by_pitch",		true	  },
});
---------------------------------------------------------------------------------
actor_electro.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 200, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 1,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 60000,
	
	-- расстояние отступления
	retreat_dist = 7,
	-- расстояние преследования
	chase_dist = 4,
	-- расстояние стрейфа
	dodge_dist = 5,
	-- время стрейфа в одну сторону
	dodge_time = 3000,
	
	--[[
	-- настройки для взрыва регдола, после смерти - 
	-- разлета кусков после сильного повреждения
	death_explosion_impulse_threshold = nil;
	death_explosion_damage_threshold = 90;
	-- настроки для взрыва регдола
	death_explosion_effect = "Rat_Blood.lua";
	death_explosion_model_name = "rat";
	death_explosion_debris_model = "rat_debris";
	death_explosion_debris_scattering = 200000;
	--]]
};

---------------------------------------------------------------------------------
-- состояние тела
--actor_electro.params.body_states_transistions = {};
--actor_electro.params.body_states_transistions[NORMAL_BODY_STATE] = {};
--actor_electro.params.body_states_transistions[SIT_BODY_STATE] = {};

--actor_electro.params.body_states_transistions[NORMAL_BODY_STATE][SIT_BODY_STATE] = "transition_stay_to_sit";
--actor_electro.params.body_states_transistions[SIT_BODY_STATE][NORMAL_BODY_STATE] = "transition_sit_to_stay";


-- настройки hitbox-ов
actor_electro_damage_k = 0.6;
actor_electro.params.hitboxes = { 
	{name = "head", damage_k = 1.7 * actor_electro_damage_k, },
	{name = "pelvis", damage_k = 1 * actor_electro_damage_k, },
    {name = "rupperArm1", damage_k = .3 * actor_electro_damage_k, },
    {name = "rupperArm2", damage_k = .45 * actor_electro_damage_k, },
    {name = "spine", damage_k = 1 * actor_electro_damage_k, },
    {name = "spine3", damage_k = 1 * actor_electro_damage_k, },
    {name = "lupperArm1", damage_k = .3 * actor_electro_damage_k, },
    {name = "lupperArm2", damage_k = .45 * actor_electro_damage_k, },
    {name = "lthigh1", damage_k = .5 * actor_electro_damage_k, },
    {name = "lthigh2", damage_k = .45 * actor_electro_damage_k, },
    {name = "rthigh1", damage_k = .5 * actor_electro_damage_k, },
    {name = "rthigh2", damage_k = .45 * actor_electro_damage_k, },
};

-- параметры атаки
actor_electro.params.attack_info = {};

-- ближняя атака
actor_electro.params.attack_info[0] = {
		type				= ATTACK_MELEE,
		dist				= 2, 
		desired_min_dist	= 0, 
		desired_max_dist	= 3,
		max_angle			= 6,  
		stop_during_attack	= 1,
		turn_body_to_enemy	= 1,
		
		priority = 1, 
		pause_between_attacks = 4000, -- пауза между атаками такого типа
		
			
		damage_type			= g_damage_type.KNOCK,
		damage				= 22,
		impulse				= 0.2,
		dispersion			= 0,
		offset_pos			= {0.2, 2.2, 2},
		
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};

-- fireball
actor_electro.params.attack_info[1] = {
		type				= ATTACK_DISTANT,
		dist				= 300,
		desired_min_dist	= 3, 		
		desired_max_dist	= 1000,
		max_angle			= 6,
		stop_during_attack	= 1,
		
		turn_body_to_enemy	= 1,
		
		--critical_min_dist	= 3,
		
		priority = 0, 
		pause_between_attacks = 2500, -- пауза между атаками такого типа
		
		dispersion			= 0,
		offset_pos			= {0, 1, 1.70},
		
		-- коррекция для попадания по параболе: на dist метрах мы целимся на height метров выше.
		--height_offset				= {min_height = 0, min_dist = 5, max_dist = 15, max_height = 4}, 
		height_offset				= {min_height = 0, min_dist = 5, max_dist = 25, max_height = 12}, 
		missile						= "ammo_missile_fireball",
		missile_velocity			= 1500,
		missile_angular_velocity	= {0, 0, 0},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack_missile",
		
		
		--shoot_point_tag		= "#shoot_point",
		shoot_effect		= {["#shoot_point"] = {"pfx_electro_attack_start.lua"},},
};

-- атака прыжок
actor_electro.params.attack_info[2] = {

	type				= ATTACK_JUMP,
	real_min_dist		= 2,
	real_max_dist		= 2.2,
	dist				= 9,
	desired_min_dist	= 7, 
	desired_max_dist	= 9, 
	max_angle			= 10,
	stop_during_attack	= 0,
	
	turn_body_to_enemy	= 1,
	
	damage_type			= g_damage_type.KNOCK,
	damage				= 30,
	impulse				= 0.3,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
	priority = 1,
	--pause_between_attacks = 8000, -- пауза между атаками такого типа
	
	jump_height			= 3,
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_jump",
	visual_state_prefix	= "attack_jump_approach",
};
---------------------------------------------------------------------------------
actor_electro.states_design = {};


--------------------
-- IDLE
--------------------
actor_electro.states_design["idle"] = {
			{anim = "idle1_p1", anim_speed = 1, snd = "Electrik_idle1_p1", weight = 1},
			{anim = "idle2_p1", anim_speed = 1, snd = "Electrik_idle2_p1", weight = 1},
			{anim = "idle3_p1", anim_speed = 1, snd = "Electrik_idle3_p1", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_electro.states_design["idle_alert"] = {
			{anim = "alert1", anim_speed = 0.9, snd = "Electrik_idle1_p1", weight = 1},
			{anim = "alert2", anim_speed = 0.9, snd = "Electrik_idle2_p1", weight = 1},
			{anim = "alert3", anim_speed = 1.6, snd = "Electrik_idle3_p1", weight = 1},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_electro.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "electrik_klich", snd_params = snd_actor_alert},
};			
			
--------------------
-- WALK			
--------------------
actor_electro.states_design["forward_walk"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk", anim_speed = 1.5, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_volk"},};
actor_electro.states_design["backward_walk"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_volk"},};
actor_electro.states_design["strafe_left_walk"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_jump_L"},};
actor_electro.states_design["strafe_right_walk"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_jump_R"},};
--------------------
-- RUN
--------------------
actor_electro.states_design["forward_run"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk_spid", anim_speed = 1.5, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_volk_spid"},};
actor_electro.states_design["backward_run"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk_spid", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_volk_spid"},};
actor_electro.states_design["strafe_left_run"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk_spid", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_volk_spid"},};
actor_electro.states_design["strafe_right_run"] = {
			body_state = SIT_BODY_STATE,
			{anim = "volk_spid", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Electrik_volk_spid"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка

actor_electro.states_design["jump_prepare"] = {
			body_state = SIT_BODY_STATE,
			{anim = "jamp1", anim_speed = 1.0, snd = "Electrik_volk_spid"},};
-- начало прыжка			
actor_electro.states_design["jump_begin"] = {
			body_state = SIT_BODY_STATE,
			{anim = "jamp2", anim_speed = 1, snd = "Electrik_jump_pered"},};			

-- зацикленная анимация состояния падения
actor_electro.states_design["fall"] = {
			body_state = SIT_BODY_STATE,
			{anim = "jamp3", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY,},};

-- приземление на бегу
actor_electro.states_design["land_run"] = {
			body_state = SIT_BODY_STATE,
--			{anim = "jamp5", anim_speed = 2, snd = "Electrik_volk_spid"},
			{anim = "jamp4", anim_speed = 2, snd = "Electrik_volk_spid"},
};
-- приземление на месте
actor_electro.states_design["land_stand"] = {
			{anim = "jamp4", anim_speed = 2, snd = "Electrik_volk_spid"},
};
			
----------------------------
-- ATTACK JUMP APPROACH
----------------------------
actor_electro.states_design["attack_jump_approach_prepare"] = actor_electro.states_design["jump_prepare"];
actor_electro.states_design["attack_jump_approach_begin"] = actor_electro.states_design["jump_begin"];
actor_electro.states_design["attack_jump_approach_fall"] = actor_electro.states_design["fall"];
actor_electro.states_design["attack_jump_approach_land_run"] = actor_electro.states_design["land_run"];
actor_electro.states_design["attack_jump_approach_land_stand"] = actor_electro.states_design["land_stand"];
			

----------------------------
-- ATTACK
----------------------------
actor_electro.states_design["attack_begin"] = {
			body_state = SIT_BODY_STATE,
			{anim = "atak_1_p2", anim_speed = 2, snd = "Electrik_atak_1_p2", },};
actor_electro.states_design["attack_end"] = {
			body_state = SIT_BODY_STATE,
			{anim = "atak_1_p2_out"},};

----------------------------
-- ATTACK MISSILE
----------------------------
actor_electro.states_design["attack_missile_begin"] = {
			{anim = "atak_2_p3", anim_speed = 1, snd = "Electrik_atak_2_p3", snd_params = snd_actor_attack},
			{anim = "atak_3_p3", anim_speed = 1, snd = "Electrik_atak_3_p3", snd_params = snd_actor_attack},
			{anim = "atak_4_p3", anim_speed = 1, snd = "Electrik_atak_4_p3", snd_params = snd_actor_attack},};


actor_electro.states_design["attack_missile_end"] = {
			{anim = "atak_2_p3_out"},
			{anim = "atak_3_p3_out"},
			{anim = "atak_4_p3_out"},};

--------------------------------------------------------
-- Переходы из стоячего положения в сидячее и обратно
--------------------------------------------------------
actor_electro.states_design["transition_stay_to_sit"] = {
			{anim = "perehod_p2", anim_speed = 1, snd = "Electrik_perehod_p2"},};
actor_electro.states_design["transition_sit_to_stay"] = {
			{anim = "perehod_p3", anim_speed = 1, snd = "Electrik_perehod_p3"},};
			

	
			
--------------------
-- PAIN  Electrik_perehod_p2
--------------------
actor_electro.states_design["pain"] = {
			{anim = "pain1_p3", weight = 1, snd = "Electrik_pain1_p3", snd_params = snd_actor_pain},
			{anim = "pain2_p3", weight = 1, snd = "Electrik_pain2_p3", snd_params = snd_actor_pain},
			{anim = "pain3_p3", weight = 1, snd = "Electrik_pain3_p3", snd_params = snd_actor_pain},
			{anim = "pain4_p3", weight = 1, snd = "Electrik_pain3_p3", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_electro.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Electrik_dead1_p3", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "Electrik_dead1_p3", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "Electrik_dead1_p3", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "Electrik_dead1_p3", snd_params = snd_actor_death},};
			

			