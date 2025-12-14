------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- trigger_teleport - триггер, перемещающий объект в заданный trigger_teleport_target
------------------------------------------------------------------------

------------------------------------
-- общая часть
trigger_teleport = {
	guid = {0x80fcaa07, 0xcc00, 0x48c8, 0xbe, 0x34, 0x76, 0xe9, 0x14, 0xae, 0xfc, 0xe3},
}

function trigger_teleport:register_properties(prop_registry)
end

------------------------------------
-- серверная часть 
sv_trigger_teleport = utils.inherit(sv_game_object, trigger_teleport);

function sv_trigger_teleport:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	trigger_teleport.register_properties(self, prop_registry);
end

function sv_trigger_teleport:on_init()
	sv_game_object.on_init(self);
end

------------------------------------
-- клиентская часть 
cl_trigger_teleport = utils.inherit(cl_game_object, trigger_teleport);

function cl_trigger_teleport:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	trigger_teleport.register_properties(self, prop_registry);
end
