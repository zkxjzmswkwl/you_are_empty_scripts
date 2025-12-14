------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Базовый класс для всех пистолетов и револьверов,
-- выстрел происходит в 2 фазы 
------------------------------------------------------------------------

include("ammo_mauzer.lua")

weapon_mauzer = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_mauzer.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemMauzer"},
	{"hit_material",		"mat_hit_mauzer" },
	{ "slot_name",			g_weapon_slots[2] }, -- слот в котором может быть оружие
	{ "priority",			3 }, -- приоритет оружия
--	{ "icon_id",			2 }, -- иконка для HUD
	
	{ "loaded_ammo",		5 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			45 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_mauzer.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"mauzer_hands",		"mauzer"			},
}

-- иконка для HUD
weapon_mauzer.m_ammo_icon_id		= 1
weapon_mauzer.m_holdable_icon_id	= 5

---------------------------------------
-- параметры скорострельности
---------------------------------------
-- время через которое, 
-- можно не дожидаясь начала анимации сделать новый выстрел,
-- если nil, то обязательно ждем конца всей анимации
weapon_mauzer.fire_finish_interruption_time = 350;
---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_mauzer.m_bullets_in_shot		= 1;
weapon_mauzer.m_bullet_damage		= 70;
weapon_mauzer.m_bullet_impulse		= .8;
weapon_mauzer.m_bullet_min_dist		= 15;
weapon_mauzer.m_bullet_max_dist		= 500;

weapon_mauzer.m_shot_disp			= 3;
weapon_mauzer.m_shot_disp_zoomed	= weapon_mauzer.m_shot_disp / 3;

weapon_mauzer.m_shot_recoil			= 7;
weapon_mauzer.m_shot_recoil_zoomed	= weapon_mauzer.m_shot_recoil;

weapon_mauzer.m_shot_effect_name			= "pfx_shot_mauzer.lua" -- эффект при выстреле
weapon_mauzer.m_shot_point_name				= "#shoot_point"		-- точка привязки эффекта в модели
weapon_mauzer.m_trace_bullet_effect_name	= "pfx_shot_trace_fp.lua"	-- эффект трейса пули

-- Скорострельность оружия
weapon_mauzer.m_rate_of_fire		= 1
----------------------------------------
-- параметры патронов
----------------------------------------
weapon_mauzer.m_ammo_class			= "ammo_mauzer";	-- класс используемых патронов
weapon_mauzer.m_ammo_type			= "mauzer ammo";	-- тип используемых патронов
weapon_mauzer.m_clip_size			= 9;				-- вместимость обоймы
weapon_mauzer.m_ammo_for_shot		= 1;				-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_mauzer.m_normal_fov			= 90;
weapon_mauzer.m_zoomed_fov			= 45;
weapon_mauzer.m_model_fov			= 65;

-- Чувствительность мыши (коэффициент масштабирования)
weapon_mauzer.m_zoomed_mouse_sens_scale	= 0.3;
weapon_mauzer.m_normal_mouse_sens_scale	= 1;

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_mauzer.states_design = {};
weapon_mauzer.states_design["show"] = {{anim = "taking", anim_speed = 2, snd = "mauz_taking", snd_params = snd_weapon_common},};
weapon_mauzer.states_design["hide"] = {{anim = "hiding", anim_speed = 2.5, snd = "mauz_hiding", snd_params = snd_weapon_common},};
weapon_mauzer.states_design["idle"] = {{anim = "idle", anim_playback = ANIM_PB_REPEATEDLY,}};
weapon_mauzer.states_design["fire"] = {{anim = "fire_in", snd = "mauz_fire_in", anim_speed = weapon_mauzer.m_rate_of_fire*8, snd_params = snd_weapon_common},};
weapon_mauzer.states_design["fire_finish"] = {{anim = "fire", snd = "mauz_fire", anim_speed = weapon_mauzer.m_rate_of_fire, snd_params = snd_weapon_shot},};
-- анимации для zoom in/out
weapon_mauzer.states_design["zoom_in"] = {{anim = "sight_in", anim_speed = 1.7}};
weapon_mauzer.states_design["zoom_out"] = {{anim = "sight_out", anim_speed = 1.8}};
weapon_mauzer.states_design["idle_zoomed"] = {{anim = "sight", anim_playback = ANIM_PB_REPEATEDLY,}};
weapon_mauzer.states_design["fire_zoomed"] = {{anim = "fire_in_s", snd = "mauz_fire_in", anim_speed = weapon_mauzer.m_rate_of_fire*8, snd_params = snd_weapon_common},};
weapon_mauzer.states_design["fire_finish_zoomed"] = {{anim = "fire_s", snd = "mauz_fire", anim_speed = weapon_mauzer.m_rate_of_fire, snd_params = snd_weapon_shot},};
-- перезарядка
weapon_mauzer.states_design["reload"] = {{anim = "reload", snd = "mauz_reload", snd_params = snd_weapon_common},};


-- общая часть
weapon_mauzer.guid = {0x3cf4872, 0xbac, 0x45e8, 0xbc, 0xa9, 0xbb, 0xe7, 0xb7, 0xa9, 0x95, 0xff};

---------------------------------------------------------------------------
function weapon_mauzer:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_mauzer = utils.inherit(sv_weapon_firearm, weapon_mauzer);

---------------------------------------------------------------------------
function sv_weapon_mauzer:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_mauzer:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_mauzer.on_init(self);
end

---------------------------------------------------------------------------
function sv_weapon_mauzer:on_enter_fire()
	sv_weapon_firearm.on_enter_fire(self);
	--self:set_fsm_update_time(self.main_fsm, 133);	
end

---------------------------------------------------------------------------
function sv_weapon_mauzer:on_enter_fire_finish()
	sv_weapon_firearm.on_enter_fire_finish(self);
	--self:set_fsm_update_time(self.main_fsm, 866);
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_mauzer = utils.inherit(cl_weapon_firearm, weapon_mauzer);

---------------------------------------------------------------------------
function cl_weapon_mauzer:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_mauzer.on_init(self);

	self.m_hide_crosshair_in_zoom = false
end

----------------------------------------------------------------------------------
function cl_weapon_mauzer:on_enter_zoom_in()
	cl_weapon_firearm.on_enter_zoom_in(self)
end

----------------------------------------------------------------------------------
function cl_weapon_mauzer:on_enter_zoom_out()
	cl_weapon_firearm.on_enter_zoom_out(self)
end
