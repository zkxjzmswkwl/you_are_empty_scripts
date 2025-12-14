------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Kolhoz - колхозница с серпом
------------------------------------------------------------------------

actor_kolhoz = {};

---------------------------------------------------------------------------------
actor_kolhoz.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"kolhoz" },
	{ "rag_doll_model",			"kolhoz1_ragdoll" },

	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		100.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		340.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			100	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
	
	-- не колидится с другими актерами
--	{ "collide_with_carriers",			false	  },
--	{ "align_model_to_ground_normal",	true	  },
});
---------------------------------------------------------------------------------
actor_kolhoz.params = {
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

actor_kolhoz.damage_k = 1.7;


-- настройки hitbox-ов
actor_kolhoz.params.hitboxes = { 
	{name = "head", damage_k = 1.7 * actor_kolhoz.damage_k, },
	{name = "pelvis", damage_k = 1* actor_kolhoz.damage_k, },
    {name = "rupperArm1", damage_k = .3 * actor_kolhoz.damage_k, },
    {name = "rupperArm2", damage_k = .45 * actor_kolhoz.damage_k, },
    {name = "spine", damage_k = 1 * actor_kolhoz.damage_k, },
    {name = "spine3", damage_k = 1 * actor_kolhoz.damage_k, },
    {name = "lupperArm1", damage_k = .3 * actor_kolhoz.damage_k, },
    {name = "lupperArm2", damage_k = .45 * actor_kolhoz.damage_k, },
    {name = "lthigh1", damage_k = .5 * actor_kolhoz.damage_k, },
    {name = "lthigh2", damage_k = .45 * actor_kolhoz.damage_k, },
    {name = "rthigh1", damage_k = .5 * actor_kolhoz.damage_k, },
    {name = "rthigh2", damage_k = .45 * actor_kolhoz.damage_k, },
};


-- параметры атаки
actor_kolhoz.params.attack_info = {};

actor_kolhoz.params.attack_info[0] = {
		id					= ATTACK_PRIMARY,
		type				= ATTACK_MELEE,
		dist				= 2, 
		real_min_dist		= 1.2, 
		real_max_dist		= 2.2, 
		desired_min_dist	= 0,
		desired_max_dist	= 1000, 
		max_angle			= 6,
		stop_during_attack	= 1,
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 15,
		impulse				= 1,
		dispersion			= 0,
		offset_pos			= {0, 0, 1.30},
		
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack",
		visual_state_prefix	= "attack",
};

---------------------------------------------------------------------------------
actor_kolhoz.states_design = {};


actor_kolhoz.snd_vol = -0.5;

--------------------
-- IDLE
--------------------
actor_kolhoz.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, snd = "kolhoznitca_idle1", weight = 1, snd_vol = actor_kolhoz.snd_vol},
			{anim = "idle2", anim_speed = 1, snd = "kolhoznitca_idle2", weight = 1, snd_vol = actor_kolhoz.snd_vol},
			{anim = "idle3", anim_speed = 1, snd = "kolhoznitca_idle3", weight = 1, snd_vol = actor_kolhoz.snd_vol},
			{anim = "idle4", anim_speed = 1, snd = "kolhoznitca_idle4", weight = 1, snd_vol = actor_kolhoz.snd_vol},};
			
			
--------------------
-- IDLE ALERT
--------------------
actor_kolhoz.states_design["idle_alert"] = {
			--{anim = "damaged_idle1", weight = 1, snd = ""},
			{anim = "damaged_idle1", weight = 1, snd = "kolhoznitca_damaged_idle1", snd_vol = actor_kolhoz.snd_vol},
			{anim = "damaged_idle2", weight = 1, snd = "kolhoznitca_damaged_idle2, snd_vol = actor_kolhoz.snd_vol"},
};
			
			
-------------------------------------------------------------
-- TRANSITION TO IDLE (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_kolhoz.states_design["transition_to_alert"] = {
	{anim = nil, weight = 1, snd = "kolhoznitca_klich", snd_params = snd_actor_alert, snd_vol = actor_kolhoz.snd_vol, },
};	
							
--------------------
-- WALK			
--------------------
actor_kolhoz.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_walk", snd_vol = actor_kolhoz.snd_vol},
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, weight = 2},};
actor_kolhoz.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_walk", snd_vol = actor_kolhoz.snd_vol},};
actor_kolhoz.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_walk", snd_vol = actor_kolhoz.snd_vol},};
actor_kolhoz.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_walk", snd_vol = actor_kolhoz.snd_vol},};
--------------------
-- RUN
--------------------
actor_kolhoz.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_run", snd_vol = actor_kolhoz.snd_vol},
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, weight = 2},};
actor_kolhoz.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_run", snd_vol = actor_kolhoz.snd_vol},};
actor_kolhoz.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_run", snd_vol = actor_kolhoz.snd_vol},};
actor_kolhoz.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "kolhoznitca_run", snd_vol = actor_kolhoz.snd_vol},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_kolhoz.states_design["jump_prepare"] = {
			{anim = "run", anim_speed = 1.0},};
-- начало прыжка			
actor_kolhoz.states_design["jump_begin"] = {
			{anim = "run", anim_speed = 1},};

-- зацикленная анимация состояния падения
actor_kolhoz.states_design["fall"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY},};

-- приземление на бегу
actor_kolhoz.states_design["land_run"] = {
			{anim = "run", anim_speed = 1},};
-- приземление на месте
actor_kolhoz.states_design["land_stand"] = {
			{anim = "run", anim_speed = 1},};

----------------------------
-- ATTACK
----------------------------
actor_kolhoz.states_design["attack_begin"] = {
			{anim = "attack1", anim_speed = 1, snd = "kolhoznitca_attack1", snd_params = snd_actor_attack, snd_vol = actor_kolhoz.snd_vol},
			{anim = "attack2", anim_speed = 1, snd = "kolhoznitca_attack2", snd_params = snd_actor_attack, snd_vol = actor_kolhoz.snd_vol},	
            {anim = "attack3", anim_speed = 1, snd = "kolhoznitca_attack3", snd_params = snd_actor_attack, snd_vol = actor_kolhoz.snd_vol},
            {anim = "attack4", anim_speed = 1, snd = "kolhoznitca_attack4", snd_params = snd_actor_attack, snd_vol = actor_kolhoz.snd_vol},
            {anim = "attack5", anim_speed = 1, snd = "kolhoznitca_attack5", snd_params = snd_actor_attack, snd_vol = actor_kolhoz.snd_vol},
};

actor_kolhoz.states_design["attack_end"] = {
			{anim = "attack1_out", anim_speed = 1},
			{anim = "attack2_out", anim_speed = 1},
            {anim = "attack3_out", anim_speed = 1},
            {anim = "attack4_out", anim_speed = 1},
            {anim = "attack5_out", anim_speed = 1},
};
                        
----------------------------
-- DEAD - лежит мертвая и просыпается
----------------------------
actor_kolhoz.states_design["idle_dead_1"] = {
			{anim = "idle_dead1", anim_speed = 1.0,},};
actor_kolhoz.states_design["to_alert_dead_1"] = {
			{anim = "to_alert_dead1", anim_speed = 1, snd = "kolhoznitca_to_alert_dead1", snd_params = snd_actor_alert, snd_vol = actor_kolhoz.snd_vol},};
			
actor_kolhoz.states_design["idle_dead_2"] = {
			{anim = "idle_dead2", anim_speed = 1,},};
actor_kolhoz.states_design["to_alert_dead_2"] = {
			{anim = "to_alert_dead2", anim_speed = 1, snd = "kolhoznitca_to_alert_dead2", snd_params = snd_actor_alert, snd_vol = actor_kolhoz.snd_vol},};
			
actor_kolhoz.states_design["idle_dead_3"] = {
			{anim = "idle_dead3", anim_speed = 1,},};
actor_kolhoz.states_design["to_alert_dead_3"] = {
			{anim = "to_alert_dead3", anim_speed = 1, snd = "kolhoznitca_to_alert_dead3", snd_params = snd_actor_alert, snd_vol = actor_kolhoz.snd_vol},};
			
--------------------
-- PAIN
--------------------
actor_kolhoz.states_design["pain"] = {
			{anim = "pain1", weight = 1, snd = "kolhoznitca_pain1", snd_params = snd_actor_pain, snd_vol = actor_kolhoz.snd_vol},
			{anim = "pain2", weight = 1, snd = "kolhoznitca_pain2", snd_params = snd_actor_pain, snd_vol = actor_kolhoz.snd_vol},
			{anim = "pain3", weight = 1, snd = "kolhoznitca_pain3", snd_params = snd_actor_pain, snd_vol = actor_kolhoz.snd_vol},
			{anim = "pain4", weight = 1, snd = "kolhoznitca_pain4", snd_params = snd_actor_pain, snd_vol = actor_kolhoz.snd_vol},};
		
--------------------
-- DEATH
--------------------
actor_kolhoz.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "kolhoznitca_death1", snd_params = snd_actor_death, snd_vol = actor_kolhoz.snd_vol},
			{--[[anim = "dead2",--]] weight = 1, snd = "kolhoznitca_death2", snd_params = snd_actor_death, snd_vol = actor_kolhoz.snd_vol},};