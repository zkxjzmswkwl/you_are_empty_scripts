------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Protivogaz - сборщик органов
------------------------------------------------------------------------

actor_protivogaz = {};

---------------------------------------------------------------------------------
actor_protivogaz.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"protivogaz" },
	{ "rag_doll_model",			"protivogaz_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		100.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		80.0  },
	{ "run_forward_speed",		230.0 },
	{ "run_backward_speed",		180.0 },
	{ "run_strafe_speed",		180.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{380.0, 380.0, 380.0}  }, -- углова€ скорость поворота
	
	-- праметры зрени€
	{ "view_fov",				70	  },	-- угол обзора (град) 
	{ "view_dist",				100	  },	-- максимальна€ дальность зрени€ (м)

	-- erection params
	{ "vision_fade_in_time",			500 },
	{ "vision_fade_out_time",			500 },

    { "turn_hands",				1 },	--// 0 - none, 1 - right, 2 - left, 3 - both
	{ "allow_head_turn",				true	},

	{ "ignore_insuperable_danger", 	false   }, -- реагировать на гранаты
});
---------------------------------------------------------------------------------
actor_protivogaz.params = {
	-- поворот тела относительно головы при ходьбе пр€мо и вбок
	body_rotate_forward_strafe = 30,
	-- врем€ падени€ после которого начинает отыгрывать€ анимаци€ падени€
	falling_time = 60, 
	-- высота, выше которой включаетс€ анимаци€ падени€
	above_ground_level = 2,
	-- врем€ в течении которого персонаж должен находитс€ в состо€нии
	-- idle_alert после последней атаки
	aggresive_stance_time = 50000,
	-- кол-во патронов в обойме
	clip_size			= 5,

	-- рассто€ние отступлени€
	retreat_dist = 0*7,
	-- рассто€ние преследовани€
	chase_dist = 5,
	-- рассто€ние стрейфа
	dodge_dist = 0*2,
	-- врем€ стрейфа в одну сторону
	dodge_time = 0*3000,
};

-- настройки hitbox-ов
actor_protivogaz.params.hitboxes = { 
	{name = "head", damage_k = 1.7, },
	{name = "pelvis", damage_k = 1.2, },
    {name = "rupperArm1", damage_k = .4, },
    {name = "rupperArm2", damage_k = .55, },
    {name = "spine", damage_k = 1.2, },
    {name = "spine3", damage_k = 1.2, },
    {name = "lupperArm1", damage_k = .4, },
    {name = "lupperArm2", damage_k = .55, },
    {name = "lthigh1", damage_k = .7, },
    {name = "lthigh2", damage_k = .5, },
    {name = "rthigh1", damage_k = .7, },
    {name = "rthigh2", damage_k = .5, },
};

-- параметры атаки
actor_protivogaz.params.attack_info = {};

actor_protivogaz.params.attack_info[0] = {
	type				= ATTACK_DISTANT,
	real_min_dist		= 10,
	real_max_dist		= 100,
	dist			= 100,
	desired_min_dist	= 0, 
	desired_max_dist	= 100, 
	max_angle			= 6, 
	stop_during_attack	= 1,
	--turn_body_to_enemy	= 1,
		
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 10,
	impulse				= .5,
	dispersion			= 9,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0, 0, 1.60}, -- не используетс€, если указан 'shoot_point_tag'
	
	-- Ёффект, по€вл€ющийс€ при выстреле.
	--  лючами в данной таблице €вл€ютс€ точки прив€зки в модели.
	-- «начени€м в данной таблице €вл€ютс€ списки эффектов. ¬о врем€ выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_organ.lua"}, 
						  },
	-- Ёффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
						  
	  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot",
	visual_state_prefix	= "attack",
};

actor_protivogaz.params.attack_info[1] = {
	type				= ATTACK_DISTANT,
	dist				= 15,
	desired_min_dist	= 8, 
	desired_max_dist	= 50,  
	max_angle			= 6, 
	stop_during_attack	= 1,
	--turn_body_to_enemy	= 1,
	
	dispersion			= 0,
	offset_pos			= {0, 1.50, 1.70},
	
	height_offset				= {min_height = -1, min_dist = 5, max_dist = 15, max_height = 4},
	missile						= "ammo_missile_bottle_bot",
	missile_velocity			= 1000,
	missile_angular_velocity	= {0, 25, 0},
	
	pause_between_attacks = 9000, -- пауза между атаками такого типа
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile",
};

---------------------------------------------------------------------------------
actor_protivogaz.states_design = {};


--------------------
-- IDLE
--------------------
actor_protivogaz.states_design["idle"] = {

			{anim = "idle1_p1", anim_speed = 1, snd = "Organ_idle1_p1", weight = 1},
			{anim = "idle2_p1", anim_speed = 1, snd = "Organ_idle2_p1", weight = 1},
			{anim = "idle3_p1", anim_speed = 1, snd = "Organ_idle3_p1", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_protivogaz.states_design["idle_alert"] = {
			{anim = "idle4_p2", anim_speed = 1, snd = "Organ_idle4_p2", weight = 1},
			{anim = "idle5_p2", anim_speed = 1, snd = "Organ_idle5", weight = 1},};
			
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (ѕереход в агрессивное состо€ние)
-------------------------------------------------------------
actor_protivogaz.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "organ_klich", snd_params = snd_actor_alert},
};			
			
--------------------
-- WALK			
--------------------
actor_protivogaz.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_walk"},};
actor_protivogaz.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_walk"},};
actor_protivogaz.states_design["strafe_left_walk"] = {
			{anim = "L", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_L"},};
actor_protivogaz.states_design["strafe_right_walk"] = {
			{anim = "R", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_R"},};
--------------------
-- RUN
--------------------
actor_protivogaz.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1.2, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_ran"},};
actor_protivogaz.states_design["backward_run"] = {
			{anim = "walk", anim_speed = 1.4, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_walk"},};
actor_protivogaz.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_L"},};
actor_protivogaz.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_R"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительна€ фаза прыжка
actor_protivogaz.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "Organ_ran"},};
-- начало прыжка			
actor_protivogaz.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "Organ_ran"},};			

-- зацикленна€ анимаци€ состо€ни€ падени€
actor_protivogaz.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Organ_ran"},};

-- приземление на бегу
actor_protivogaz.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "Organ_ran"},};
-- приземление на месте
actor_protivogaz.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "Organ_ran"},};

----------------------------
-- ATTACK
----------------------------
actor_protivogaz.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "Organ_attack1", snd_params = snd_actor_shot},
			{anim = "attack2", anim_speed = 1, snd = "Organ_attack2", snd_params = snd_actor_shot},	};

actor_protivogaz.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},};
		
----------------------------
-- ATTACK MISSILE
----------------------------
actor_protivogaz.states_design["attack_missile_begin"] = {
			{anim = "granata", anim_speed = 1, snd = "moto_ugol_l_granata", snd_params = snd_actor_attack},};
actor_protivogaz.states_design["attack_missile_end"] = {
			{anim = "granata_out"},};

----------------------------
-- RELOAD
----------------------------
actor_protivogaz.states_design["reload"] = {
			{anim = "reload", anim_speed = 1, snd = "Organ_reload"},};
			

--------------------
-- PAIN
--------------------
actor_protivogaz.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "Organ_pain1", snd_params = snd_actor_pain},
			{anim = "pain2", weight = 1, snd = "Organ_pain2", snd_params = snd_actor_pain},
			{anim = "pain3", weight = 1, snd = "Organ_pain3", snd_params = snd_actor_pain},};
			
--------------------
-- DEATH
--------------------
actor_protivogaz.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Organ_dead1", snd_params = snd_actor_death},
};	
			