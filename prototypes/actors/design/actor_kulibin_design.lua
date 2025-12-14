------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Kulibin - дед NPC с уровня "Колхоз"
------------------------------------------------------------------------

actor_kulibin = {};

---------------------------------------------------------------------------------
actor_kulibin.properties_design = utils.merge_arrays(actor_basic.properties_design, {
	{ "model_name",				"kulibin" },
	{ "rag_doll_model",			"?"  },	

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
	{ "jump_height",			160	  },
	{ "turn_speed",				{180.0, 180.0, 380.0}  }, -- угловая скорость поворота
	
	-- праметры зрения
	{ "view_fov",				90	  },	-- угол обзора (град) 
	{ "view_dist",				25	  },	-- максимальная дальность зрения (м)

	{ "allow_head_turn",		false  },
});

---------------------------------------------------------------------------------
actor_kulibin.params = {
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
actor_kulibin.params.hitboxes = { 
	{name = "pelvis", damage_k = 0, },
};


-- параметры атаки
actor_kulibin.params.attack_info = {};


---------------------------------------------------------------------------------
actor_kulibin.states_design = {};


--------------------
-- IDLE
--------------------
actor_kulibin.states_design["idle"] = {
			{anim = "idle1", anim_speed = 1, weight = 4},
			{anim = "idle2", anim_speed = 1, weight = 4},
			{anim = "idle3", anim_speed = 1, weight = 4},
			{anim = "zahodi1", anim_speed = 1, snd = "zahodi1", weight = 1, snd_params = snd_actor_kulib},
			{anim = "zahodi2", anim_speed = 1, snd = "zahodi2", weight = 1, snd_params = snd_actor_kulib},
			{anim = "zahodi3", anim_speed = 1, snd = "zahodi3", weight = 1, snd_params = snd_actor_kulib},
			{anim = "zahodi4", anim_speed = 1, snd = "zahodi4", weight = 1, snd_params = snd_actor_kulib},
			{anim = "zahodi5", anim_speed = 1, snd = "zahodi5", weight = 1, snd_params = snd_actor_kulib},
			};

--------------------
-- DONT SHOOT
--------------------
actor_kulibin.states_design["dont_shoot"] = {
			{anim = "ne_strelay1", anim_speed = 1, snd = "ne_strelay1", weight = 2, snd_params = snd_actor_kulib},
			{anim = "ne_strelay2", anim_speed = 1, snd = "ne_strelay2", weight = 2, snd_params = snd_actor_kulib},
			{anim = "zahodi6", anim_speed = 1, snd = "zahodi6",  weight = 1, snd_params = snd_actor_kulib},
			};			

--------------------
-- TALK
--------------------
actor_kulibin.states_design["to_talk"] = {
			{anim = "perehod_p2", anim_speed = 1, weight = 1, snd_params = snd_actor_kulib},
			};

actor_kulibin.states_design["begin_talk"] = {
			{anim = "progon1", anim_speed = 1, snd = "Kulib_Progon1", weight = 1, snd_params = snd_actor_kulib},
			};
			
actor_kulibin.states_design["finish_talk"] = {
			{anim = "progon1_out", anim_speed = 1, weight = 1, snd_params = snd_actor_kulib},
			};