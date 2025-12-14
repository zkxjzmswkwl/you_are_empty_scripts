------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors:	Andrey Frolov
------------------------------------------------------------------------
-- trigger_hitable - триггер, которому можно наносить урон с помощью стрельбы
------------------------------------------------------------------------

------------------------------------
-- общая часть
trigger_hitable = {
	guid = {0xf6d3d4e, 0xed36, 0x4278, 0x8e, 0xff, 0x6d, 0xc3, 0x6, 0xe2, 0x3e, 0x2c},
}

function trigger_hitable:register_properties(prop_registry)
	--self.damage_amount_prop = self:register_property(prop_registry, "damage_amount", -1);
	--self.damage_delay_prop = self:register_property(prop_registry, "damage_delay", 0);
	--self.damage_frequency_prop = self:register_property(prop_registry, "damage_frequency", 1000);
	--self.damage_type_prop = self:register_property(prop_registry, "damage_type", 1);--DAMAGE_PHYSICS);
end

------------------------------------
-- серверная часть 

sv_trigger_hitable = utils.inherit(sv_game_object, trigger_hitable)

function sv_trigger_hitable:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	trigger_hitable.register_properties(self, prop_registry)
end

function sv_trigger_hitable:on_init()
	sv_game_object.on_init(self)
end

-- функции обработчики слотов
function sv_trigger_damage:OnEnter(activator)
	self.entered_time = engine.get_game_time()
	return self:damage(activator)
end

function sv_trigger_damage:OnIn(activator)
	return self:damage(activator);
end

function sv_trigger_damage:OnExit(activator)
	self.entered_time = -1
	return true
end

------------------------------------
-- клиентская часть 
cl_trigger_damage = utils.inherit(cl_game_object, trigger_damage);

function cl_trigger_damage:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	trigger_damage.register_properties(self, prop_registry);
end
