------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Оружие Граната
------------------------------------------------------------------------

include("ammo_grenade.lua")

weapon_grenade = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_grenade.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemMauzer"},
	{"hit_material",		"mat_hit_ppsh" },
	{ "slot_name",			g_weapon_slots[10] },	-- слот в котором может быть оружие
	{ "priority",			10 },					-- приоритет оружия
--	{ "icon_id",			7 },					-- иконка для HUD
	
	{ "loaded_ammo",		1 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			10 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_grenade.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"granata_hands",	"granata"			},
}

-- иконка для HUD
weapon_grenade.m_ammo_icon_id		= 7
weapon_grenade.m_holdable_icon_id	= 13 

----------------------------------------
-- параметры патронов
----------------------------------------
weapon_grenade.m_ammo_class				= "ammo_grenade"			-- класс используемых патронов
weapon_grenade.m_missile_ammo_class		= "ammo_missile_grenade"	-- класс используемых метательных патронов 
weapon_grenade.m_throw_point_offset		= {0.3, 1.5, 1.6}				-- смещение точки выброса метательного патрона
weapon_grenade.m_angular_velocity		= {20, 0, 0}				-- вращение после броска
weapon_grenade.m_ammo_type				= "grenade ammo"			-- тип используемых патронов
weapon_grenade.m_clip_size				= 1							-- вместимость обоймы
weapon_grenade.m_ammo_for_shot			= 1							-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_grenade.m_model_fov = 45;

----------------------------------------
-- параметры броска
----------------------------------------

--	При нажатии и удерживании кнопки выстрела, стартовая скорость полета 
--  метательного оружия будет увеличиваться	от минимальной(нажали и сразу же отпустили),
--  до максимальной(удерживание гранаты в течение времени m_time_to_gain_max_velocity или дольше)

-- минимальная стартовая скорость полета метательного оружия	
weapon_grenade.m_min_velocity	= 300
-- максимальная стартовая скорость полета метательного оружия
weapon_grenade.m_max_velocity	= 2000
-- время, в течение которого метательное оружие приобретает максимальную стартовую скорость
weapon_grenade.m_time_to_gain_max_velocity = 1500

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_grenade.states_design = {};

-- HIDING/TAKING
weapon_grenade.states_design["show"] = {{anim = "taking", snd = "Granade_show"},};
weapon_grenade.states_design["hide"] = {{anim = "hiding", snd = "Granade_hide"},};

-- IDLE
weapon_grenade.states_design["idle"] = {
	{anim = "idle", anim_playback = ANIM_PB_REPEATEDLY,},
};

-- FIRE
weapon_grenade.states_design["fire_start"]	= {{anim = "fire1", snd = "Granade_fire1"},};
weapon_grenade.states_design["fire"]		= {{anim = "fire2", snd = "Granade_fire2"},};
weapon_grenade.states_design["fire_finish"]	= {{anim = "fire3", snd = "Granade_fire3"},};

-- общая часть
weapon_grenade.guid = {0x5f3f5cba, 0xdde4, 0x4ef3, 0x92, 0x78, 0xf9, 0x93, 0x15, 0x33, 0x60, 0x9d};

function weapon_grenade:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_grenade = utils.inherit(sv_weapon_missile, weapon_grenade);

function sv_weapon_grenade:register_properties(prop_registry)
	sv_weapon_missile.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_grenade:on_init()
	sv_weapon_missile.on_init(self);
	weapon_grenade.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_grenade = utils.inherit(cl_weapon_missile, weapon_grenade);

function cl_weapon_grenade:on_init()
	cl_weapon_missile.on_init(self);
	weapon_grenade.on_init(self);
end
