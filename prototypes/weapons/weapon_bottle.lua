------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Оружие Коктейль Молотова
------------------------------------------------------------------------

include("ammo_bottle.lua")

weapon_bottle = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_bottle.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"molotbotle"},
	{"hit_material",		"mat_hit_ppsh" },
	{ "slot_name",			g_weapon_slots[10] },	-- слот в котором может быть оружие
	{"sound_on_take",		"Player_Take_Butilo4ka.wav"},
	{ "priority",			1 },					-- приоритет оружия
--	{ "icon_id",			8 },					-- иконка для HUD
	
	{ "loaded_ammo",		1 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			5 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_bottle.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"batl_hands",		"batl"			},
}

-- иконка для HUD
weapon_bottle.m_ammo_icon_id		= 7
weapon_bottle.m_holdable_icon_id	= 13 

weapon_bottle.m_damage_limit			= 5		-- Предел повреждения, при котором бутылка разрушается

----------------------------------------
-- эффекты
----------------------------------------
weapon_bottle.m_shot_effect_name			= "pfx_burning_bottle.lua"	-- эффект при выстреле
weapon_bottle.m_shot_point_name				= "#shoot_point"		-- точка привязки эффекта в модели

----------------------------------------
-- параметры патронов
----------------------------------------
weapon_bottle.m_ammo_class				= "ammo_bottle"			-- класс используемых патронов
weapon_bottle.m_missile_ammo_class		= "ammo_missile_bottle"	-- класс используемых метательных патронов 
weapon_bottle.m_throw_point_offset		= {0.2, 0.5, 2}			-- смещение точки выброса метательного патрона
weapon_bottle.m_angular_velocity		= {0, 20, 0}			-- вращение после броска
weapon_bottle.m_ammo_type				= "bottle ammo"			-- тип используемых патронов
weapon_bottle.m_clip_size				= 1						-- вместимость обоймы
weapon_bottle.m_ammo_for_shot			= 1						-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_bottle.m_model_fov = 30;

----------------------------------------
-- параметры броска
----------------------------------------

--	При нажатии и удерживании кнопки выстрела, стартовая скорость полета 
--  метательного оружия будет увеличиваться	от минимальной(нажали и сразу же отпустили),
--  до максимальной(удерживание гранаты в течение времени m_time_to_gain_max_velocity или дольше)

-- минимальная стартовая скорость полета метательного оружия	
weapon_bottle.m_min_velocity	= 300
-- максимальная стартовая скорость полета метательного оружия
weapon_bottle.m_max_velocity	= 1300
-- время, в течение которого метательное оружие приобретает максимальную стартовую скорость
weapon_bottle.m_time_to_gain_max_velocity = 1500

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_bottle.states_design = {};

-- HIDING/TAKING
weapon_bottle.states_design["show"] = {{anim = "taking", snd = "butl_taking"},};
weapon_bottle.states_design["hide"] = {{anim = "hiding", snd = "butl_hiding"},};

-- IDLE
weapon_bottle.states_design["idle"] = {
	{anim = "idle", anim_playback = ANIM_PB_REPEATEDLY,},
};

-- FIRE
weapon_bottle.states_design["fire_start"]	= {{anim = "fire1", snd = "butl_fire1"},};
weapon_bottle.states_design["fire_lift"]	= {{anim = "fire2", },};
weapon_bottle.states_design["fire"]			= {{anim = "fire3", snd = "butl_fire3"},};
weapon_bottle.states_design["fire_finish"]	= {{anim = "fire4", },};

-- общая часть
weapon_bottle.guid = {0x7d73d792, 0x9f3d, 0x4e91, 0x99, 0x21, 0xf8, 0xb1, 0x7c, 0x1a, 0x2, 0x1d};

function weapon_bottle:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_bottle = utils.inherit(sv_weapon_missile, weapon_bottle);

function sv_weapon_bottle:register_properties(prop_registry)
	sv_weapon_missile.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_bottle:on_init()
	sv_weapon_missile.on_init(self);
	weapon_bottle.on_init(self);

	-- дополнительное состояние для выстрела	
	-- замах
	self.fire_lift_state	= self:add_fsm_state(self.main_fsm, "fire_lift_state", self.on_enter_fire_lift, self.on_update_fire_lift, nil, nil);
	
	-- Разрушение бутылки
	self:set_property_value_by_name("damage_limit",		self.m_damage_limit);
	self:set_property_value_by_name("auto_fall_apart",	true);
end

-------------------------------------------
function sv_weapon_bottle:on_damage_limit()

	-- Создаем взрыв
	local explosion = engine.spawn_entity("Explosion")
	
	-- Задаем свойства, такие же как и у ammo_missile_bottle
	local missile = engine.spawn_entity("ammo_missile_bottle")
	
	explosion:set_property_value_by_name("radius", missile:get_property_value_by_name("explode_radius") * 64)
	explosion:set_property_value_by_name("force", missile:get_property_value_by_name("explode_impulse") * 1000)
	explosion:set_property_value_by_name("damage", missile:get_property_value_by_name("explode_damage"))
	explosion:set_property_value_by_name("damage_type", missile:get_property_value_by_name("explode_damage_type"))
	explosion:set_property_value_by_name("effect", missile:get_property_value_by_name("explode_effect_name"))
	explosion:set_property_value_by_name("destroy_after_explosion", true)
	
	-- Уничтожаем временный объект
	missile:destroy_object()
	
	-- Позиционируем
	explosion:set_pos(self:get_pos())
	engine.add_entity_to_world(explosion)
	
	-- Взрываем
	explosion:signal("explode", self);

end

---------------------------------------------------------------------------
function sv_weapon_bottle:on_update_fire_start()
	self:change_fsm_state(self.main_fsm, self.fire_lift_state, true);
end

---------------------------------------------------------------------------
function sv_weapon_bottle:on_enter_fire_lift()
	self:visualize_state(self.main_fsm, self.state_visual_info, "fire_lift");
	self:visualize_shoot_effects()
end

---------------------------------------------------------------------------
function sv_weapon_bottle:on_update_fire_lift()
	if self.m_event_lever1_up then
		self:change_fsm_state(self.main_fsm, self.fire_state, true);
	end
end

---------------------------------------------------------------------------
function sv_weapon_bottle:on_enter_fire_finish()
	sv_weapon_missile.on_enter_fire_finish(self)
	
	-- На всякий случай прячем эффекты горения 
	self:deactivate_shoot_effects()
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_bottle = utils.inherit(cl_weapon_missile, weapon_bottle);

function cl_weapon_bottle:on_init()
	cl_weapon_missile.on_init(self);
	weapon_bottle.on_init(self);
end
