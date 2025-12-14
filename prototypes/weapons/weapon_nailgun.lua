------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Оружие гвоздомет 
------------------------------------------------------------------------

include("ammo_nailgun.lua")

weapon_nailgun = {};

weapon_nailgun.guid = {0x528272db, 0x254f, 0x43c4, 0x91, 0xc9, 0xb5, 0x9e, 0x4e, 0xd, 0xe2, 0x6c};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_nailgun.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemNailGun"},
	{"hit_material",		"mat_hit_mauzer" },
	{ "slot_name",			g_weapon_slots[7] }, -- слот в котором может быть оружие
	{ "priority",			5 }, -- приоритет оружия
--	{ "icon_id",			8 }, -- иконка для HUD
	
	{ "loaded_ammo",		33 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			165 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_nailgun.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"nailgun_hands",		"nailgun"			},
}

-- иконка для HUD
weapon_nailgun.m_ammo_icon_id		= 6
weapon_nailgun.m_holdable_icon_id	= 10

---------------------------------------
-- параметры скорострельности
---------------------------------------
-- время через которое, 
-- можно не дожидаясь начала анимации сделать новый выстрел,
-- если nil, то обязательно ждем конца всей анимации
weapon_nailgun.fire_finish_interruption_time = 350;

---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_nailgun.m_bullets_in_shot	= 1;
weapon_nailgun.m_bullet_damage		= 35;
weapon_nailgun.m_bullet_impulse		= .9;
weapon_nailgun.m_bullet_min_dist	= 15;
weapon_nailgun.m_bullet_max_dist	= 500;

weapon_nailgun.m_shot_disp			= 3;
weapon_nailgun.m_shot_disp_zoomed	= weapon_nailgun.m_shot_disp / 3;

weapon_nailgun.m_shot_recoil		= 2.7;
weapon_nailgun.m_shot_recoil_zoomed	= 1.5;

-- Скорострельность оружия
weapon_nailgun.m_rate_of_fire		= 5

-- Эффекты
weapon_nailgun.m_shot_effect_name			= "pfx_shot_nailgun.lua"	-- эффект при выстреле
weapon_nailgun.m_shot_point_name			= "#shoot_point"			-- точка привязки эффекта в модели
weapon_nailgun.m_trace_bullet_effect_name	= "pfx_shot_trace_fp.lua"	-- эффект трейса пули

----------------------------------------
-- параметры патронов
----------------------------------------
weapon_nailgun.m_ammo_class			= "ammo_nailgun";	-- класс используемых патронов
weapon_nailgun.m_ammo_type			= "nailgun ammo";	-- тип используемых патронов
weapon_nailgun.m_clip_size			= 33;				-- вместимость обоймы
weapon_nailgun.m_ammo_for_shot		= 1;				-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_nailgun.m_normal_fov			= 90;
weapon_nailgun.m_zoomed_fov			= 45;
weapon_nailgun.m_model_fov			= 45;

-- Чувствительность мыши (коэффициент масштабирования)
weapon_nailgun.m_zoomed_mouse_sens_scale	= 0.3;
weapon_nailgun.m_normal_mouse_sens_scale	= 1;

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_nailgun.states_design = {};
weapon_nailgun.states_design["show"] = {{anim = "taking", anim_speed = 1, snd = "nailgun_hiding.WAV_taking", snd_params = snd_weapon_common},};
weapon_nailgun.states_design["hide"] = {{anim = "hiding", anim_speed = 1, snd = "nailgun_hiding"},};

-- IDLE
weapon_nailgun.states_design["idle"] = {
	{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle2", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle3", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle4", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle5", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle6", anim_playback = ANIM_PB_REPEATEDLY,},
};

-- FIRE
weapon_nailgun.states_design["fire"] = {
	{anim = "fire1_in", anim_speed = weapon_nailgun.m_rate_of_fire},
	{anim = "fire2_in", anim_speed = weapon_nailgun.m_rate_of_fire},
	{anim = "fire3_in", anim_speed = weapon_nailgun.m_rate_of_fire},
	{anim = "fire4_in", anim_speed = weapon_nailgun.m_rate_of_fire},
}

weapon_nailgun.states_design["fire_finish"] = {
	{anim = "fire1", snd = "nailgun_fire1", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire2", snd = "nailgun_fire2", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire3", snd = "nailgun_fire3", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire4", snd = "nailgun_fire4", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
}

-- Анимации для zoom in/out
weapon_nailgun.states_design["zoom_in"]		= { {anim = "sight_in", anim_speed = 1} };
weapon_nailgun.states_design["zoom_out"]	= { {anim = "sight_out", anim_speed = 1} };
weapon_nailgun.states_design["idle_zoomed"] = {
	{anim = "idle_in_s7", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_in_s8", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_in_s9", anim_playback = ANIM_PB_REPEATEDLY,},
}
weapon_nailgun.states_design["fire_zoomed"] = {
	{anim = "fire_in_s1_in", anim_speed = weapon_nailgun.m_rate_of_fire},
	{anim = "fire_in_s2_in", anim_speed = weapon_nailgun.m_rate_of_fire},
}
weapon_nailgun.states_design["fire_finish_zoomed"] = {
	{anim = "fire_in_s1", snd = "nailgun_fire1", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s2", snd = "nailgun_fire2", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s1", snd = "nailgun_fire3", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s2", snd = "nailgun_fire4", anim_speed = weapon_nailgun.m_rate_of_fire, snd_params = snd_weapon_shot},
}

-- RELOAD
weapon_nailgun.states_design["reload"] = {
	{anim = "reload", snd = "nailgun_reload", snd_params = snd_weapon_common},
}

---------------------------------------------------------------------------
-- общая часть
function weapon_nailgun:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_nailgun = utils.inherit(sv_weapon_firearm, weapon_nailgun);

---------------------------------------------------------------------------
function sv_weapon_nailgun:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_nailgun:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_nailgun.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_nailgun = utils.inherit(cl_weapon_firearm, weapon_nailgun);

---------------------------------------------------------------------------
function cl_weapon_nailgun:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_nailgun.on_init(self);

	self.m_hide_crosshair_in_zoom = false
end