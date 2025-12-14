------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Ружье - обрез
-- 
------------------------------------------------------------------------

include("ammo_obrez.lua")

weapon_obrez = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_obrez.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"Item_Obrez"},
	{"hit_material",		"mat_hit_obrez" },
	{ "slot_name",			g_weapon_slots[3] },	-- слот в котором может быть оружие
	{ "priority",			4 }, -- приоритет оружия
--	{ "icon_id",			3 },	-- иконка для HUD
	
	{ "loaded_ammo",		2 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			2 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			60 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_obrez.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"obrez_hands",		"obrez"			},
}

-- иконка для HUD
weapon_obrez.m_ammo_icon_id		= 2
weapon_obrez.m_holdable_icon_id	= 7

---------------------------------------
-- параметры выстрела
---------------------------------------
-- параметры для одиночного выстрела
weapon_obrez.single = {}
	weapon_obrez.single.m_ammo_for_shot		= 1;	-- кол-во патронов расходуемых на один выстрел
	weapon_obrez.single.m_bullets_in_shot	= 5;	-- кол-во дробинок в выстреле
	weapon_obrez.single.m_bullet_damage		= 50;
	weapon_obrez.single.m_bullet_impulse	= .2 * 4;
	weapon_obrez.single.m_bullet_min_dist	= 10;
	weapon_obrez.single.m_bullet_max_dist	= 30;
	weapon_obrez.single.m_bullet_dist		= 25;
	weapon_obrez.single.m_shot_disp			= 25;
	weapon_obrez.single.m_shot_recoil		= 3.5;

-- параметры для двойного выстрела
weapon_obrez.double = {}		
	weapon_obrez.double.m_ammo_for_shot		= weapon_obrez.single.m_ammo_for_shot	* 2;
	weapon_obrez.double.m_bullets_in_shot	= weapon_obrez.single.m_bullets_in_shot	* 2;
	weapon_obrez.double.m_bullet_damage		= weapon_obrez.single.m_bullet_damage;
	weapon_obrez.double.m_bullet_impulse	= weapon_obrez.single.m_bullet_impulse;
	weapon_obrez.double.m_bullet_min_dist	= 15;
	weapon_obrez.double.m_bullet_max_dist	= 30;
	weapon_obrez.double.m_bullet_dist		= 20;
	weapon_obrez.double.m_shot_disp			= 30;
	weapon_obrez.double.m_shot_recoil		= weapon_obrez.single.m_shot_recoil		* 2;

weapon_obrez.m_shot_effect_name				= "pfx_shot_shotgun.lua"	-- эффект при выстреле
weapon_obrez.m_shot_point_name				= "#shoot_point"			-- точка привязки эффекта в модели
weapon_obrez.m_trace_bullet_effect_name		= "pfx_shot_trace_fp.lua"		-- эффект трейса пули

-- Скорострельность оружия
weapon_obrez.m_rate_of_fire					= 1
	
----------------------------------------
-- параметры патронов
----------------------------------------
weapon_obrez.m_ammo_class	= "ammo_obrez"	-- класс используемых патронов
weapon_obrez.m_ammo_type	= "obrez ammo"	-- тип используемых патронов
weapon_obrez.m_clip_size	= 2				-- вместимость обоймы

-- FOV дляразных режимов
weapon_obrez.m_normal_fov	= 90
weapon_obrez.m_model_fov	= 45

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_obrez.states_design = {};
weapon_obrez.states_design["show"] = {{anim = "taking", anim_speed = 2, snd = "Drobovik_taking", snd_params = snd_weapon_common},};
weapon_obrez.states_design["hide"] = {{anim = "hiding", anim_speed = 2.5, snd = "Drobovik_hiding", snd_params = snd_weapon_common},};
weapon_obrez.states_design["idle"] = {{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,}};
weapon_obrez.states_design["fire"] = {{anim = "fire1_in", anim_speed = weapon_obrez.m_rate_of_fire}};
weapon_obrez.states_design["fire_finish"] = {{anim = "fire1", snd = "Drobovik_fire1", anim_speed = weapon_obrez.m_rate_of_fire, snd_params = snd_weapon_shot},};
-- перезарядка
weapon_obrez.states_design["reload"] = {{anim = "reload", anim_speed = 1.5, snd = "Drobovik_reload", snd_params = snd_weapon_reload},};

-- общая часть
weapon_obrez.guid = {0x7b17e68a, 0xd148, 0x4560, 0x81, 0xfe, 0xd, 0xb0, 0x7d, 0x62, 0xe2, 0xeb};

---------------------------------------------------------------------------
function weapon_obrez:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_obrez = utils.inherit(sv_weapon_firearm, weapon_obrez);

---------------------------------------------------------------------------
function sv_weapon_obrez:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_obrez:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_obrez.on_init(self);
	
	-- Установим значения по умолчанию
	self:set_shoot_params("single")
end

---------------------------------------------------------------------------
function sv_weapon_obrez:on_event(event_id, event)
	sv_weapon_firearm.on_event(self, event_id, event);
end

---------------------------------------------------------------------------
function sv_weapon_obrez:set_shoot_params(shoot_type)
	self.m_ammo_for_shot	= self[shoot_type].m_ammo_for_shot	
	self.m_bullets_in_shot	= self[shoot_type].m_bullets_in_shot	
	self.m_bullet_damage	= self[shoot_type].m_bullet_damage	
	self.m_bullet_impulse	= self[shoot_type].m_bullet_impulse	
	self.m_bullet_dist		= self[shoot_type].m_bullet_dist	
	self.m_bullet_min_dist	= self[shoot_type].m_bullet_min_dist
	self.m_bullet_max_dist	= self[shoot_type].m_bullet_max_dist
	self.m_shot_disp		= self[shoot_type].m_shot_disp		
	self.m_shot_recoil		= self[shoot_type].m_shot_recoil		
end

---------------------------------------------------------------------------
function sv_weapon_obrez:event_lever1_down()
	self:set_shoot_params("single")
	sv_weapon_firearm.event_lever1_down(self)
end

---------------------------------------------------------------------------
function sv_weapon_obrez:event_lever2_down()
	if self:get_property_value(self.m_loaded_ammo_prop) ~= 1 then
		self:set_shoot_params("double")
	end
	sv_weapon_firearm.event_lever1_down(self)
end

---------------------------------------------------------------------------
function sv_weapon_obrez:on_enter_fire()
	sv_weapon_firearm.on_enter_fire(self);
	--self:set_fsm_update_time(self.main_fsm, 133);
end

---------------------------------------------------------------------------
function sv_weapon_obrez:on_enter_fire_finish()
	sv_weapon_firearm.on_enter_fire_finish(self);
end

---------------------------------------------------------------------------
function sv_weapon_obrez:on_update_fire_finish()
	if(self:can_reload() and not self:can_fire()) then
		self:change_fsm_state(self.main_fsm, self.reload_state, true);
	else
		self:change_fsm_state(self.main_fsm, self.idle_state, true);
	end
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_obrez = utils.inherit(cl_weapon_firearm, weapon_obrez);

function cl_weapon_obrez:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_obrez.on_init(self);
end