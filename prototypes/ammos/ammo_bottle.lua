------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Коктейль молотова (патроны)
------------------------------------------------------------------------

-- общая часть
ammo_bottle = {};

ammo_bottle.guid = {0x86d1dff4, 0xc573, 0x44bf, 0x97, 0x42, 0xfe, 0x63, 0xba, 0x88, 0xdc, 0x64}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_bottle.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"bottle ammo"},
	{"ammo_capacity",	1},
	{"ammo_stored",		1},
	{"sound_on_take",	"Player_Take_Butilo4ka.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_bottle.m_holdable_icon_id	= 13	-- Иконка HUD
ammo_bottle.m_damage_limit		= 5		-- Предел повреждения, при котором бутылка разрушается


------------------------------------
-- серверная часть 
sv_ammo_bottle = utils.inherit(sv_ammo_basic, ammo_bottle)

-------------------------------------------
function sv_ammo_bottle:on_init()
	sv_ammo_basic.on_init(self)
	
	self:set_property_value_by_name("damage_limit",		self.m_damage_limit);
	self:set_property_value_by_name("auto_fall_apart",	true);
end
					
-------------------------------------------
function sv_ammo_bottle:on_damage_limit()

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

------------------------------------
-- клиентская часть 
cl_ammo_bottle = utils.inherit(cl_ammo_basic, ammo_bottle)