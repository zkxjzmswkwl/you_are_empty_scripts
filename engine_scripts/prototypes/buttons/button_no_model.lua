------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Прототип объекта кнопка без модели
------------------------------------------------------------------------

------------------------------------------------------------------------
-- общая часть
button_no_model = {
	guid = {0xa616ae8c, 0x9656, 0x45a3, 0x82, 0xa6, 0x35, 0x20, 0x26, 0x35, 0x56, 0xeb},
}

------------------------------------------------------------------------
function button_no_model:register_properties(prop_registry)
	self:register_property(prop_registry, "switch_state", false);
	self:register_property(prop_registry, "is_locked", false);
end

------------------------------------------------------------------------
function button_no_model:on_init()
end
	
------------------------------------------------------------------------
-- серверная часть 
sv_button_no_model = utils.inherit(sv_game_object, button_no_model);

function sv_button_no_model:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	button_no_model.register_properties(self, prop_registry);
	
	self.in_switch_on		= self:register_input_slot("switch_on", self.in_switch_on);
	self.in_switch_off		= self:register_input_slot("switch_off", self.in_switch_off);
	self.in_switch_toggle	= self:register_input_slot("switch_toggle", self.in_switch_toggle);
	
	self.out_switch_on		= self:register_output_slot("on_switch_on", nil);
	self.out_switch_off		= self:register_output_slot("on_switch_off", nil);
end

------------------------------------------------------------------------
function sv_button_no_model:on_init(dreader)
	sv_game_object.on_init(self);
	button_no_model.on_init(self);
	
	self.main_fsm			= self:add_fsm("main_fsm");
	self.switch_on_state	= self:add_fsm_state(self.main_fsm, "switch_on_state",	self.on_enter_switch_on, self.on_update_switch_on, nil, nil);
	self.switch_off_state	= self:add_fsm_state(self.main_fsm, "switch_off_state",	self.on_enter_switch_off, self.on_update_switch_off, nil, nil);
	
	self:set_property_value_by_name("is_usable", true)
end

------------------------------------------------------------------------
function sv_button_no_model:is_locked()
	return self:get_property_value_by_name("is_locked");
end

------------------------------------------------------------------------
function sv_button_no_model:on_use()
	if self:is_locked() == false then
		self:switch_toggle();
	end
end

------------------------------------------------------------------------
function sv_button_no_model:switch_on()
	self:change_fsm_state(self.main_fsm, self.switch_on_state, true)
	self:set_property_value_by_name("switch_state", true)
end

------------------------------------------------------------------------
function sv_button_no_model:switch_off()
	self:change_fsm_state(self.main_fsm, self.switch_off_state, true)
	self:set_property_value_by_name("switch_state", false)
end

------------------------------------------------------------------------
function sv_button_no_model:switch_toggle()
	
	if (self:get_property_value_by_name("switch_state") == true) then
		self:switch_off()
	else
		self:switch_on()
	end
end

------------------------------------------------------------------------
-- input slots
------------------------------------------------------------------------
function sv_button_no_model:in_switch_on()
	if self:is_locked() == false then
		self:switch_on()
	end
end

------------------------------------------------------------------------
function sv_button_no_model:in_switch_off()
	if self:is_locked() == false then
		self:switch_off()
	end
end

------------------------------------------------------------------------
function sv_button_no_model:in_switch_toggle()
	if self:is_locked() == false then
		self:switch_toggle()
	end
end

------------------------------------------------------------------------
function sv_button_no_model:OnLocked()
end

------------------------------------------------------------------------
-- FSM states functions
------------------------------------------------------------------------

------------------------------------------------------------------------
-- on
function sv_button_no_model:on_enter_switch_on()
	self:set_enable(true);
end

------------------------------------------------------------------------
function sv_button_no_model:on_update_switch_on()
	self:emit_signals(self.out_switch_on);
	self:set_fsm_update_time(self.main_fsm, 0);
end

------------------------------------------------------------------------
-- off
function sv_button_no_model:on_enter_switch_off()
	self:set_enable(true);
end

------------------------------------------------------------------------
function sv_button_no_model:on_update_switch_off()
	self:emit_signals(self.out_switch_off);
	self:set_fsm_update_time(self.main_fsm, 0);
end

------------------------------------------------------------------------
-- клиентская часть
cl_button_no_model = utils.inherit(cl_game_object, button_no_model);

------------------------------------------------------------------------
function cl_button_no_model:on_init()
	cl_game_object.on_init(self);
	button_no_model.on_init(self);
end