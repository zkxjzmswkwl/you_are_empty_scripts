------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Budyonovets - солдат красной армии
------------------------------------------------------------------------

actor_budyonovets_controller = {};

actor_budyonovets = {};

---------------------------------------------------------------------------------
actor_budyonovets.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"budyonovets" },
	{ "rag_doll_model",			"budyonovets1_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5   },

	{ "mass",				300.0 },

	{ "walk_forward_speed",		100.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		280.0 },
	{ "run_backward_speed",		500.0 },
	{ "run_strafe_speed",		200.0 },
	{ "jump_height",			30	  },
	{ "turn_speed",				{280.0, 280.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				70	  },	-- угол обзора (град) 
	{ "view_dist",				2500	  },	-- максимальная дальность зрения (м)
	{ "vision_fade_in_time",			700 },	-- реакция на появление врага
	{ "vision_fade_out_time",			700 },	-- реакция на изчезновение врага

    { "turn_hands",				3 },	--// 0 - none, 1 - right, 2 - left, 3 - both
	{ "allow_head_turn",				true	},
});
---------------------------------------------------------------------------------
actor_budyonovets.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 2000,
	-- кол-во патронов в обойме
	clip_size			= 5,
};

-- настройки hitbox-ов
actor_budyonovets.params.hitboxes = { 
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
actor_budyonovets.params.attack_info = {};

actor_budyonovets.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	dist				= 2, 
	desired_min_dist	= 0, 
	desired_max_dist	= 5, 
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 25,
	impulse				= 1.5,
	offset_pos			= {0, 0, 0.70},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

actor_budyonovets.params.attack_info[1] = {
	id					= ATTACK_SECONDARY,
	type				= ATTACK_DISTANT,

	real_min_dist		= 30,
	real_max_dist		= 300,
	dist				= 300, 
	desired_min_dist	= 5, 
	desired_max_dist	= 1000, 
	max_angle			= 6, 
	stop_during_attack	= 1,	
	
	damage_type			= g_damage_type.GUNSHOT,
	damage				= 8,
	impulse				= 1,
	dispersion			= 5,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0.70, 0, 1.70}, -- не используется, если указан 'shoot_point_tag'
	
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_soldier.lua"}, 
						  },
	-- Эффект, трейса пули.
	trace_bullet_effect = "pfx_shot_trace.lua",
  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot",
	visual_state_prefix	= "attack_shot",
};

---------------------------------------------------------------------------------
actor_budyonovets.states_design = {};


--------------------
-- IDLE
--------------------
actor_budyonovets.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "budyon_idle1", weight = 1},
			{anim = "idle2", anim_speed = 1, snd = "budyon_idle2", weight = 1},
			{anim = "idle3", anim_speed = 1, snd = "budyon_idle3", weight = 1},
			{anim = "idle4", anim_speed = 1, snd = "budyon_idle4", weight = 1},
			{anim = "idle5", anim_speed = 1, snd = "budyon_idle5", weight = 1},
			{anim = "idle6", anim_speed = 1, snd = "budyon_idle6", weight = 1},};
			
--------------------
-- IDLE ALERT
--------------------
actor_budyonovets.states_design["idle_alert"] = {
			{anim = "idle5", weight = 1, snd = "budyon_idle5"},
			{anim = "idle6", weight = 1, snd = "budyon_idle5"},};
			
-------------------------------------------------------------
-- TRANSITION TO ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_budyonovets.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "budyon_klich", snd_params = snd_actor_alert},
};
			
--------------------
-- WALK			
--------------------
actor_budyonovets.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_walk"},};
actor_budyonovets.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_walk"},};
actor_budyonovets.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_l"},};
actor_budyonovets.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_r"},};
--------------------
-- RUN
--------------------
actor_budyonovets.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_run"},};
actor_budyonovets.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_run"},};
actor_budyonovets.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_run"},};
actor_budyonovets.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_budyonovets.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0, snd = "budyon_run"},};
-- начало прыжка			
actor_budyonovets.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1, snd = "budyon_run"},};			

-- зацикленная анимация состояния падения
actor_budyonovets.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "budyon_run"},};

-- приземление на бегу
actor_budyonovets.states_design["land_run"] = {
			{anim = "run", anim_speed = 1, snd = "budyon_run"},};
-- приземление на месте
actor_budyonovets.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1, snd = "budyon_run"},};

----------------------------
-- ATTACK
----------------------------
actor_budyonovets.states_design["attack_begin"] = {

			{anim = "attack1", anim_speed = 1.5, snd = "budyon_attack1", snd_params = snd_actor_attack},
			{anim = "attack2", anim_speed = 1.5, snd = "budyon_attack2", snd_params = snd_actor_attack},	
			{anim = "attack3", anim_speed = 1.5, weight = 3, snd = "budyon_attack3", snd_params = snd_actor_attack },};

actor_budyonovets.states_design["attack_end"] = {
			{anim = "attack1_out"},
			{anim = "attack2_out"},
			{anim = "attack3_out", weight = 3,},};
			

----------------------------
-- ATTACK SHOT
----------------------------
actor_budyonovets.states_design["attack_shot_begin"] = {
			{anim = "alert_attack4", anim_speed = 1, snd = "budyon_alert_attack4", snd_params = snd_actor_shot},
			{anim = "alert_attack5", anim_speed = 1, snd = "budyon_alert_attack5", snd_params = snd_actor_shot},};

actor_budyonovets.states_design["attack_shot_end"] = {
			{anim = "alert_attack4_out"},
			{anim = "alert_attack5_out"},};
			
----------------------------
-- RELOAD
----------------------------
actor_budyonovets.states_design["reload"] = {
			{anim = "alert_reload1", anim_speed = 1, snd = "budyon_alert_reload1"},};		
			
--------------------
-- PAIN
--------------------
actor_budyonovets.states_design["pain"] = {
			{anim = "pain1", anim_speed = 1, weight = 1, snd = "budyon_pain1", snd_params = snd_actor_pain},
			{anim = "pain2", anim_speed = 1, weight = 1, snd = "budyon_pain2", snd_params = snd_actor_pain},
			{anim = "pain3", anim_speed = 1, weight = 1, snd = "budyon_pain3", snd_params = snd_actor_pain},
			{anim = "pain4", anim_speed = 1, weight = 1, snd = "budyon_pain4", snd_params = snd_actor_pain},
			{anim = "pain5", anim_speed = 1, weight = 1, snd = "budyon_pain5", snd_params = snd_actor_pain},
};
			
--------------------
-- DEATH
--------------------
actor_budyonovets.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "budyon_death1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "budyon_death2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "budyon_death3", snd_params = snd_actor_death},
};