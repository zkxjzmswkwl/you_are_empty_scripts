------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Flamethrower - огнеметчик
------------------------------------------------------------------------

actor_flamethrower = {};

---------------------------------------------------------------------------------
actor_flamethrower.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"fireman_zzot" },
	{ "rag_doll_model",			"faer_zzot_ragdoll"  },
	
	{ "stay_height",			1.80  },
	{ "sit_height",				1.0   },
  	{ "body_radius",			0.5	  },

	{ "mass",					200.0 },

	{ "walk_forward_speed",		200.0 },
	{ "walk_backward_speed",	100.0 },
	{ "walk_strafe_speed",		50.0  },
	{ "run_forward_speed",		330.0 },
	{ "run_backward_speed",		310.0 },
	{ "run_strafe_speed",		210.0 },
	{ "jump_height",			40	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	-------------------------------
	-- настройки сенсоров осязания
	-------------------------------
	-- FOV зрения
	{ "view_fov",					70 },
	-- макс. дистанция зрения 
	{ "view_dist",					25 },	
	-- порог слышимости звука
	-- минимальная громкость звука (0 - слышит все, до >1 - не слышит ничего),
	-- на которую срабатывает сенсор слуха
	--{ "sensor_sound_threshold",		0  },	
	-- параметры повреждения
	-- мин. размер хита и импульса чувствительные для сенсора повреждения
	{ "sensor_damage_hit_threshold",	 0  },
    { "sensor_damage_impulse_threshold", 0  },
    -- сенсор столкновения (вкл/выкл)
    { "sensor_collision",		true    },
    { "allow_head_turn",		true	},
    { "turn_hands",				1 },
    
--	 { "custom_transition_to_alert",	"attack_jump_prepare1"},
--   { "stop_during_transition_to_alert",	true},
	{ "ignore_insuperable_danger", 	false   }, -- реагировать на гранаты
});

---------------------------------------------------------------------------------
actor_flamethrower.params = {
	-- поворот тела относительно головы при ходьбе прямо и вбок
	body_rotate_forward_strafe = 30,
	-- время падения после которого начинает отыгрыватья анимация падения
	falling_time = 20, 
	-- высота, выше которой включается анимация падения
	above_ground_level = 0.5,
	-- время в течении которого персонаж должен находится в состоянии
	-- idle_alert после последней атаки
	aggresive_stance_time = 40000,
	
	-- Эффект выброса огня
	flame_effect_name = "pfx_flamethrower1.lua",
	-- Эффект горелки
	nozzle_effect_name = "pfx_flamethrower1_nozzle.lua",
	-- Точка выброса огня
	flame_shoot_point = "#shoot_point",
	
	-- Звук начала выброса огня
	begin_flame_snd_name = "fl_start", 
	
	-- Количество выстрелов в очереди.
	burst_size			= 3,

};


-- настройки hitbox-ов
actor_flamethrower.params.hitboxes = { 
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
actor_flamethrower.params.attack_info = {};

actor_flamethrower.params.attack_info[0] = {
	id					= ATTACK_PRIMARY,
	type				= ATTACK_DISTANT,
	dist				= 6,
	desired_min_dist	= 4, 
	desired_max_dist	= 100, 
	max_angle			= 20, 
	stop_during_attack	= 1,
	
	damage_type			= g_damage_type.BURN,	
	damage				= 20,
	impulse				= 0.1,
	dispersion			= 0,
	offset_pos			= {0, 0, 0.70},
	
--	burst_size			= 3, -- Количество выстрелов в очереди.
	
	allowed_bhv			= {BHV_STAND, BHV_WALK},
	fsm_state			= "attack_shot_burst",
	visual_state_prefix	= "attack_throwfire",
};

---------------------------------------------------------------------------------
actor_flamethrower.states_design = {};

--------------------
-- IDLE
--------------------
actor_flamethrower.states_design["idle"] = {
			{anim = "idle1_p1", anim_speed = 1,	snd = "Fireman_Idle1", weight = 1},
			{anim = "idle2_p1", anim_speed = 1, snd = "Fireman_Idle2", weight = 1},
			{anim = "idle3_p1", anim_speed = 1, snd = "Fireman_Idle3", weight = 1},
			{anim = "idle4_p1", anim_speed = 1, snd = "Fireman_Idle4", weight = 1},
			{anim = "idle5_p1", anim_speed = 1, snd = "Fireman_Idle5", weight = 1},
};
			
--------------------
-- IDLE ALERT
--------------------
actor_flamethrower.states_design["idle_alert"] = {
			{anim = "idle1_p1", snd = "Fireman_AgresIdle1", weight = 1},
			{anim = "idle2_p1", snd = "Fireman_AgresIdle3", weight = 1},
};


--[[			
--------------------
-- PAIN
--------------------
actor_flamethrower.states_design["pain"] = {
			{anim = "pain1_p1", weight = 1, snd = "Fireman_Damage1"},
			{anim = "pain2_p1", weight = 1, snd = "Fireman_Damage2"},
			{anim = "pain3_p1", weight = 1, snd = "Fireman_Damage3"},
			{anim = "pain4_p1", weight = 1, snd = "Fireman_Damage4"},
			{anim = "pain4_p1", weight = 1, snd = "Fireman_Damage1He"},
};
--]]

-------------------------------------------------------------
-- TRANSITION TO IDLE ALERT (Переход в агрессивное состояние)
-------------------------------------------------------------
actor_flamethrower.states_design["transition_to_alert"] = {
			{weight = 1, snd = "fireman_klich", snd_params = snd_actor_alert},
			};

--------------------
-- PAIN
--------------------
actor_flamethrower.states_design["pain"] = {
			{anim = "pain1_p1", weight = 1, snd = "Fireman_Damage1", snd_params = snd_actor_pain},
			{anim = "pain2_p1", weight = 1, snd = "Fireman_Damage2", snd_params = snd_actor_pain},
			{anim = "pain3_p1", weight = 1, snd = "Fireman_Damage3", snd_params = snd_actor_pain},
			{anim = "pain4_p1", weight = 1, snd = "Fireman_Damage4", snd_params = snd_actor_pain},
			{anim = "pain5_p1", weight = 1, snd = "Fireman_Damage1", snd_params = snd_actor_pain},};

--------------------
-- DEATH
--------------------
actor_flamethrower.states_design["death"] = {
			{--[[anim = "dead1",--]] weight = 1, snd = "Fireman_Dead1", snd_params = snd_actor_death},
			{--[[anim = "dead2",--]] weight = 1, snd = "Fireman_Dead2", snd_params = snd_actor_death},
			{--[[anim = "dead3",--]] weight = 1, snd = "Fireman_Dead3", snd_params = snd_actor_death},};
			
--------------------
-- WALK			
--------------------
actor_flamethrower.states_design["forward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk"},};
actor_flamethrower.states_design["backward_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Walk"},};
actor_flamethrower.states_design["strafe_left_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_StepLeft"},};
actor_flamethrower.states_design["strafe_right_walk"] = {
			{anim = "walk", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_StepRight"},};
--------------------
-- RUN
--------------------
actor_flamethrower.states_design["forward_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY,--[[ anim_bone_group = "upper_model",--]] snd = "Fireman_Run"},};
actor_flamethrower.states_design["backward_run"] = {
			{anim = "run", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
actor_flamethrower.states_design["strafe_left_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};
actor_flamethrower.states_design["strafe_right_run"] = {
			{anim = "run", anim_speed = 1, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};

----------------------------
-- JUMP & FALL & LAND
----------------------------
-- подготовительная фаза прыжка
actor_flamethrower.states_design["jump_prepare"] = {
			{anim = "jamp1", anim_speed = 1.0, snd = "Fireman_Run"},};
-- начало прыжка			
actor_flamethrower.states_design["jump_begin"] = {
			{anim = "jamp2", anim_speed = 1.0, snd = "Fireman_Run"},};			

-- зацикленная анимация состояния падения
actor_flamethrower.states_design["fall"] = {
			{anim = "jamp3", anim_speed = 1.0, anim_playback = ANIM_PB_REPEATEDLY, snd = "Fireman_Run"},};

-- приземление на бегу
actor_flamethrower.states_design["land_run"] = {
			{anim = "jamp_4run", anim_speed = 1, snd = "Fireman_Run"},};
-- приземление на месте
actor_flamethrower.states_design["land_stand"] = {
			{anim = "jamp5", anim_speed = 1, snd = "Fireman_Run"},};

----------------------------
-- ATTACK THROW FIRE
----------------------------
actor_flamethrower.states_design["attack_throwfire_begin"] = {
};

actor_flamethrower.states_design["attack_throwfire_shooting"] = {
			{anim = "attack1_p1", anim_speed = 1,},
};

actor_flamethrower.states_design["attack_throwfire_end"] = {
};