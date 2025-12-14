------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Yuri Dobronravin
--				Andrey Frolov
------------------------------------------------------------------------
-- trigger_damage - триггер, находясь в котором, объект получает damage 
------------------------------------------------------------------------

------------------------------------
-- общая часть
trigger_damage = {
	guid = {0xb740ab7f, 0x1d04, 0x480b, 0xb6, 0xa9, 0x03, 0xf6, 0x41, 0xaf, 0x3b, 0x6f},
};

function trigger_damage:register_properties(prop_registry)
	self.damage_amount_prop = self:register_property(prop_registry, "damage_amount", -1);
	self.damage_delay_prop = self:register_property(prop_registry, "damage_delay", 0);
	self.damage_frequency_prop = self:register_property(prop_registry, "damage_frequency", 1000);
	self.damage_type_prop = self:register_property(prop_registry, "damage_type", "GUNSHOT");
end

------------------------------------
-- серверная часть 

sv_trigger_damage = utils.inherit(sv_game_object, trigger_damage);
sv_trigger_damage.last_damage_time = -1;
sv_trigger_damage.entered_time = -1;

function sv_trigger_damage:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	trigger_damage.register_properties(self, prop_registry);
end

function sv_trigger_damage:on_init()
	sv_game_object.on_init(self);
	
	-- Считываем тип damage'а
	local damage_type = self:get_property_value(self.damage_type_prop)
	self.damage_type = g_damage_type[damage_type]
	if not self.damage_type then
		self.damage_type = g_damage_type.GUNSHOT
	end
	
end

function sv_trigger_damage:damage(activator)
	local curr_time = engine.get_game_time()
	
	if self.entered_time + self:get_property_value(self.damage_delay_prop) > curr_time or
		self.last_damage_time + self:get_property_value(self.damage_frequency_prop) > curr_time
			then return false end

	self.last_damage_time = curr_time
	
	self:send_event(
		activator, 
		EVENT_DAMAGE, 
		self.damage_type,
		self:get_property_value(self.damage_amount_prop)
	)

	console.print("sv_trigger_damage:damage "..curr_time)
	return true
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
