------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- trigger_kill - триггер, находясь в котором, объект умирает
------------------------------------------------------------------------

------------------------------------
-- общая часть
trigger_kill = {
	guid = {0x80fcaa07, 0xcc00, 0x48c8, 0xbe, 0x34, 0x76, 0xe9, 0x14, 0xae, 0xfc, 0xe3},
};

function trigger_kill:register_properties(prop_registry)
end

------------------------------------
-- серверная часть 
sv_trigger_kill = utils.Inherit(sv_game_object, trigger_kill);

function sv_trigger_kill:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	trigger_kill.register_properties(self, prop_registry);
end

function sv_trigger_kill:OnInit()
	sv_game_object.OnInit(self);
end

-- функции обработчики слотов
function sv_trigger_kill:OnEnter(activator)
	--.hack - надо сделать EVENT_KILL
	self:send_event(activator, EVENT_DAMAGE, 0, 1, -1);
	return true;
end

------------------------------------
-- клиентская часть 
cl_trigger_kill = utils.Inherit(cl_game_object, trigger_kill);

function cl_trigger_kill:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	trigger_kill.register_properties(self, prop_registry);
end
