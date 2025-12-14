------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Andrey Frolov
--		   Yuri Dobronravin 	
------------------------------------------------------------------------
-- NPC, заходя в тригер активирует, команду, которая
-- вызывает другой такой же тригер, который говорит NPC идти в позицию
-- второго тригера.
------------------------------------------------------------------------

-- общая часть
trigger_ai_ctrl = {
	guid = {0xe25e6585, 0xe221, 0x4ec1, 0xa1, 0x95, 0x6b, 0x7a, 0x55, 0x3, 0xa7, 0x69},
};

------------------------------------
-- серверная часть 
sv_trigger_ai_ctrl = utils.inherit(sv_game_object, trigger_ai_ctrl);

function sv_trigger_ai_ctrl:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	
	self.out_execute_slot = self:register_output_slot("on_execute", self.out_execute);
	self.in_execute_slot = self:register_input_slot("execute", self.execute);

	self.in_call_ai_here_slot = self:register_input_slot("call_ai_here", self.call_ai_here);
end


-- функции обработчики слотов

function sv_trigger_ai_ctrl:out_execute(activator)
	return true;
end

function sv_trigger_ai_ctrl:execute(sender, activator, input_data)
	self:emit_signals(self.out_execute_slot, activator);
end


function sv_trigger_ai_ctrl:call_ai_here(sender, activator, input_data)
	-- предполагается, что activator это NPC, и мы шлем ему event
	-- чтоб он двигался в позицию тригера (т.е. нас)
	self:send_event(activator, EVENT_WALK_HERE, self:get_pos());
end

------------------------------------
-- клиентская часть 
cl_trigger_ai_ctrl = utils.inherit(cl_game_object, trigger_ai_ctrl);
