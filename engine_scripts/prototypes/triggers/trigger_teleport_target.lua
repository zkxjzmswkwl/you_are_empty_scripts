------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- trigger_teleport_target - место назначения телепорта
------------------------------------------------------------------------

------------------------------------
-- общая часть
trigger_teleport_target = {
	guid = {0xae0debfc, 0xf364, 0x46c9, 0xa9, 0xd6, 0x2, 0x9d, 0x1f, 0x5b, 0xf4, 0x96},
}

------------------------------------
-- серверная часть 
sv_trigger_teleport_target = utils.inherit(sv_game_object, trigger_teleport_target);

function sv_trigger_teleport_target:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	
	self.in_teleport_slot = self:register_input_slot("teleport", self.teleport);
end

-- функции обработчики слотов
function sv_trigger_teleport_target:teleport(sender, activator, input_data)
	local tm = self:get_tm()
	self:send_event(activator, EVENT_SET_POS, tm)
end

------------------------------------
-- клиентская часть 
cl_trigger_teleport_target = utils.inherit(cl_game_object, trigger_teleport_target);
