------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- counter - счетчик, выдающий сигнал по достижении заданного числа
------------------------------------------------------------------------

------------------------------------
-- общая часть
counter = {
	guid = {0x5a89ed9d, 0x87f1, 0x4f3c, 0xac, 0x2c, 0xd8, 0x2b, 0xd3, 0xbc, 0x88, 0x8f},
}

function counter:register_properties(prop_registry)
	self.count_current_prop = self:register_property(prop_registry, "count_current", 0);
	self.count_estimate_prop = self:register_property(prop_registry, "count_estimate", 0);
end

------------------------------------
-- серверная часть 
sv_counter = utils.Inherit(sv_game_object, counter)

function sv_counter:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	counter.register_properties(self, prop_registry);

	self.in_increase_slot = self:register_input_slot("increase", self.increase)
	self.in_decrease_slot = self:register_input_slot("decrease", self.decrease)

	self.out_execute_slot = self:register_output_slot("on_execute", nil)
end

function sv_counter:check(num)
	if self:get_property_value(self.count_current_prop) == self:get_property_value(self.count_estimate_prop) then 
		self:emit_signals(self.out_execute_slot) end
end

function sv_counter:increase(sender, activator, input_data)
	self:set_property_value(self.count_current_prop, self:get_property_value(self.count_current_prop) + 1)
	self:check()
end

function sv_counter:decrease(sender, activator, input_data)
	self:set_property_value(self.count_current_prop, self:get_property_value(self.count_current_prop) - 1)
	self:check()
end

------------------------------------
-- клиентская часть 
cl_counter = utils.Inherit(cl_game_object, counter)

function cl_counter:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	counter.register_properties(self, prop_registry);
end
