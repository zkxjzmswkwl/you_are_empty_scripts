------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Bumper - монстр катается по уровню и бодает игрока
------------------------------------------------------------------------

actor_bumper = {};

---------------------------------------------------------------------------------
actor_bumper.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"brichka" },
	{ "rag_doll_model",			"zlob_ragdoll"  },	

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
	{ "jump_height",			0	  },
	{ "turn_speed",				{180.0, 180.0, 180.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)
});

---------------------------------------------------------------------------------
actor_bumper.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 60, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 2,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 10000,
};

-- настройки hitbox-ов
actor_bumper.params.hitboxes = { 
	{name = "head", damage_k = 1, },

};

-- параметры атаки
actor_bumper.params.attack_info = {};

actor_bumper.params.attack_info[0] = {
		id					= ATTACK_PRIMARY,
		type				= ATTACK_MELEE,
		dist				= 5,
		desired_min_dist		= 0,
		desired_max_dist		= 1000,
		max_angle			= 6,
		stop_during_attack		= 0, 
		
		damage_type			= g_damage_type.KNOCK,
		damage				= 15,
		impulse				= 3,
		dispersion			= 0,
		offset_pos			= {0, 0, 1.50},
			
		allowed_bhv			= {BHV_STAND, BHV_WALK},
		fsm_state			= "attack_run",
		visual_state_prefix	= "attack_run",
};

---------------------------------------------------------------------------------
actor_bumper.states_design = {};


--------------------
-- IDLE
--------------------
actor_bumper.states_design["idle"] = {
			{anim = "idle1"},};
			
--------------------
-- IDLE ALERT
--------------------
actor_bumper.states_design["idle_alert"] = {
			{anim = "idle1"},};
			
--------------------
-- WALK			
--------------------
actor_bumper.states_design["forward_walk"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};
actor_bumper.states_design["backward_walk"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};
actor_bumper.states_design["strafe_left_walk"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};
actor_bumper.states_design["strafe_right_walk"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};
--------------------
-- RUN
--------------------
actor_bumper.states_design["forward_run"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};
actor_bumper.states_design["backward_run"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};
actor_bumper.states_design["strafe_left_run"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};
actor_bumper.states_design["strafe_right_run"] = {
			{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY}};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_bumper.states_design["jump_prepare"] = {
			{anim = "idle1"},};
-- начало прыжка			
actor_bumper.states_design["jump_begin"] = {
			{anim = "idle1"},};

-- зацикленная анимация состояния падения
actor_bumper.states_design["fall"] = {
			{anim = "idle1"},};

-- приземление на бегу
actor_bumper.states_design["land_run"] = {
			{anim = "idle1"},};
-- приземление на месте
actor_bumper.states_design["land_stand"] = {
			{anim = "idle1"},};

----------------------------
-- ATTACK
----------------------------
actor_bumper.states_design["attack_begin"] = {
			{anim = "idle1"},};
actor_bumper.states_design["attack_end"] = {
			{anim = "idle1"},};

----------------------------
-- ATTACK RUN
----------------------------
actor_bumper.states_design["attack_run_begin"] = {
			{anim = "idle1", anim_speed = 1, weight = 1},
			};
			
actor_bumper.states_design["attack_run_end"] = {
			{anim = "idle1", anim_speed = 1, weight = 1},
			};