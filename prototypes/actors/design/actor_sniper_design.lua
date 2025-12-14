------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Sniper - снайпер
------------------------------------------------------------------------

actor_sniper = {};

---------------------------------------------------------------------------------
actor_sniper.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"snay" },
--	{ "rag_doll_model",			"pepe_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		150.0 },
	{ "walk_backward_speed",	150.0 },
	{ "walk_strafe_speed",		80.0  },
	{ "run_forward_speed",		230.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			20	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				20	  },	-- максимальная дальность зрения (м)
});
---------------------------------------------------------------------------------
actor_sniper.params = {
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
	clip_size = 5,
};

-- настройки hitbox-ов
actor_sniper.params.hitboxes = { 
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
actor_sniper.params.attack_info = {};

-- Атака стоя (удар)
actor_sniper.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_MELEE,
	dist				= 2, 
	desired_min_dist	= 0, 
	desired_max_dist	= 5, 
	max_angle			= 6, 
	stop_during_attack	= 1,
		
	damage_type			= g_damage_type.KNOCK,
	damage				= 25,
	impulse				= 1,
	offset_pos			= {0, 0, 0.70},
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack",
};

-- Атака стоя (выстрел)
actor_sniper.params.attack_info[1] = {
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
	damage				= 23,
	impulse				= 2,
	dispersion			= 5,
	shoot_point_tag		= "#shoot_point",
	offset_pos			= {0.70, 0, 1.70}, -- не используется, если указан 'shoot_point_tag'
	
	
	-- Эффект, появляющийся при выстреле.
	-- Ключами в данной таблице являются точки привязки в модели.
	-- Значениям в данной таблице являются списки эффектов. Во время выстрела
	-- будет выбран случайным образом один из эффектов в списке.
	shoot_effect		= {
								["#shoot_point"] = {"pfx_shot_mauzer.lua"}, 
						  },
	-- Эффект, трейса пули.
	--trace_bullet_effect = "pfx_shot_trace.lua",
  
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot",
	visual_state_prefix	= "attack_shot",
};

-- Бросок гранаты
actor_sniper.params.attack_info[2] = {
	type				= ATTACK_DISTANT,
	dist				= 20,
	desired_min_dist	= 7, 
	desired_max_dist	= 30,  
	max_angle			= 25, 
	stop_during_attack	= 1,
	
	dispersion			= 0,
	offset_pos			= {0, 1, 1.70},
	
	missile						= "ammo_missile_grenade",
	missile_velocity			= 1000,
	missile_angular_velocity	= {0, 10, 0},
	
	pause_between_attacks = 6000, -- пауза между атаками такого типа
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack",
	visual_state_prefix	= "attack_missile",
};

---------------------------------------------------------------------------------
actor_sniper.states_design = {};

--------------------
-- IDLE
--------------------
actor_sniper.states_design["idle"] = {
			{anim = "idle1_p1", anim_speed = 1, snd = "Ded_idle2", weight = 1},
			{anim = "idle2_p1", anim_speed = 1, snd = "Ded_idle3", weight = 1},
			{anim = "idle3_p1", anim_speed = 1, snd = "Ded_idle4", weight = 1},
			{anim = "idle4_p1", anim_speed = 1, snd = "Ded_idle2", weight = 1},
			{anim = "idle5_p1", anim_speed = 1, snd = "Ded_idle2", weight = 1},
			};

--------------------
-- IDLE ALERT
--------------------
actor_sniper.states_design["idle_alert"] = {
			{anim = "alert_p1", weight = 1, snd = "Myaso_alert1"},
			};
			
--------------------
-- PAIN
--------------------
actor_sniper.states_design["pain"] = {
			{anim = "pain1_p1", weight = 1, snd = "Ded_pain1"},
			{anim = "pain2_p1", weight = 1, snd = "Ded_pain2"},
			{anim = "pain3_p1", weight = 1, snd = "Ded_pain3"},
            {anim = "pain4_p1", weight = 1, snd = "Ded_pain4"},
            {anim = "pain5_p1", weight = 1, snd = "Ded_pain5"},
            };
			
--------------------
-- WALK			
--------------------
actor_sniper.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_walk"},};
actor_sniper.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_walk"},};
actor_sniper.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_l_walk"},};
actor_sniper.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_r_walk"},};
--------------------
-- RUN
--------------------
actor_sniper.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};
actor_sniper.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};
actor_sniper.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};
actor_sniper.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_sniper.states_design["jump_prepare"] = {
			{anim = "jamp6", anim_speed = 1.0, snd = "Ded_run"},};
-- начало прыжка			
actor_sniper.states_design["jump_begin"] = {
			{anim = "jamp7", anim_speed = 1.0, snd = "Ded_run"},};			

-- зацикленная анимация состояния падения
actor_sniper.states_design["fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Ded_run"},};

-- приземление на бегу
actor_sniper.states_design["land_run"] = {
			{anim = "jamp_4run", anim_speed = 1, snd = "Ded_run"},};
-- приземление на месте
actor_sniper.states_design["land_stand"] = {
			{anim = "jamp5", anim_speed = 1, snd = "Ded_run"},};
			
----------------------------
-- ATTACK
----------------------------
actor_sniper.states_design["attack_begin"] = {
			{anim = "attack11_udar1_p1", anim_speed = 1},
			{anim = "attack14_udar2_p1", anim_speed = 1},
			};

actor_sniper.states_design["attack_end"] = {
			{anim = "attack11_udar1_p1_out", anim_speed = 1},
			{anim = "attack14_udar2_p1_out", anim_speed = 1},
			};
			
----------------------------
-- ATTACK SHOT
----------------------------
actor_sniper.states_design["attack_shot_begin"] = {
			{anim = "attack1_p3", anim_speed = 1, snd = "budyon_alert_attack4", snd_vol = SND_ACTOR_SHOT_VOL, snd_dist_min = SND_ACTOR_SHOT_MIN_DIST, snd_dist_max = SND_ACTOR_SHOT_MAX_DIST},
			{anim = "attack2_p3", anim_speed = 1, snd = "budyon_alert_attack5", snd_vol = SND_ACTOR_SHOT_VOL, snd_dist_min = SND_ACTOR_SHOT_MIN_DIST, snd_dist_max = SND_ACTOR_SHOT_MAX_DIST},};

actor_sniper.states_design["attack_shot_end"] = {
			{anim = "attack1_p3_out"},
			{anim = "attack2_p3_out"},};
			
----------------------------
-- ATTACK MISSILE
----------------------------
actor_sniper.states_design["attack_missile_begin"] = {
			{anim = "granata_p1", anim_speed = 1, snd = "SportsMan_brosok1"},};

actor_sniper.states_design["attack_missile_end"] = {
			{anim = "granata_p1_out"},};
			
----------------------------
-- RELOAD
----------------------------
actor_sniper.states_design["reload"] = {
			{anim = "reload_p2", anim_speed = 1.5, snd = "Ded_reload1_attack"},};