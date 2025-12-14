------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- trigger_check_inventory - триггер, срабатывающий, если у актера есть 
-- заданный предмет в инвенторе
------------------------------------------------------------------------

------------------------------------
-- общая часть
trigger_check_inventory = {
	guid = {0x308efde2, 0x626f, 0x4f4d, 0x9e, 0x29, 0x90, 0x83, 0x68, 0xf8, 0x35, 0xad},
}

function trigger_check_inventory:register_properties(prop_registry)
	game_object.register_properties(self, prop_registry);
	self:register_property(prop_registry, "item_name", " ");
end

------------------------------------
-- серверная часть 
sv_trigger_check_inventory = utils.inherit(sv_game_object, trigger_check_inventory);

function sv_trigger_check_inventory:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	trigger_check_inventory.register_properties(self, prop_registry);
end

function sv_trigger_check_inventory:on_init()
	sv_game_object.on_init(self);
end

function sv_trigger_check_inventory:is_need_react(activator)
	if activator.get_from_inventory ~= nil and activator:get_from_inventory(self:get_property_value_by_name("item_name")) ~= nil 
	then return true end
	return false
end

------------------------------------
-- клиентская часть 
cl_trigger_check_inventory = utils.inherit(cl_game_object, trigger_check_inventory);

function cl_trigger_check_inventory:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	trigger_check_inventory.register_properties(self, prop_registry);
end
