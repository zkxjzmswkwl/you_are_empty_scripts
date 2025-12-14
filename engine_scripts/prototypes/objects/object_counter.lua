------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- object_counter - счетчик, выдающий сигнал по достижении заданного числа
------------------------------------------------------------------------

------------------------------------
-- общая часть
object_counter = {
	guid = {0x5a89ed9d, 0x87f1, 0x4f3c, 0xac, 0x2c, 0xd8, 0x2b, 0xd3, 0xbc, 0x88, 0x8f},
}

function object_counter:register_properties(prop_registry)
	self.value_prop = self:register_property(prop_registry, "value", 0);
	self.ref_value_prop = self:register_property(prop_registry, "ref_value", 0);
end

------------------------------------
-- серверная часть 
sv_object_counter = utils.inherit(sv_game_object, object_counter)

function sv_object_counter:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	object_counter.register_properties(self, prop_registry);

	self.in_add_slot = self:register_input_slot("add", self.add, "value = 1")
	self.in_sub_slot = self:register_input_slot("sub", self.sub, "value = 1")
	self.in_mul_slot = self:register_input_slot("mul", self.mul, "value = 1")
	self.in_set_slot = self:register_input_slot("set", self.set, "value = 0")
	self.in_set_est_slot = self:register_input_slot("set_ref", self.set_ref, "value = 0")

	self.out_changed_slot	= self:register_output_slot("on_value_changed", nil)
	self.out_equal_slot		= self:register_output_slot("on_value_equal", nil)
	self.out_less_slot		= self:register_output_slot("on_value_less", nil)
	self.out_greater_slot	= self:register_output_slot("on_value_greater", nil)
end

function sv_object_counter:on_init()
	sv_game_object.on_init(self);
	self:set_update_enable(false);
end

function sv_object_counter:check(num)
	local value = self:get_property_value(self.value_prop)
	local ref_value = self:get_property_value(self.ref_value_prop)
	
	if value == ref_value then
		self:emit_signals(self.out_equal_slot)
	else
		self:emit_signals(self.out_changed_slot)
		if value < ref_value then
			self:emit_signals(self.out_less_slot)
		else
			self:emit_signals(self.out_greater_slot)
		end
	end
end

function sv_object_counter:add(sender, activator, input_data)
	self:set_property_value(self.value_prop, self:get_property_value(self.value_prop) + input_data.value)
	self:check()
end

function sv_object_counter:sub(sender, activator, input_data)
	self:set_property_value(self.value_prop, self:get_property_value(self.value_prop) - input_data.value)
	self:check()
end

function sv_object_counter:mul(sender, activator, input_data)
	self:set_property_value(self.value_prop, self:get_property_value(self.value_prop)*input_data.value)
	self:check()
end

function sv_object_counter:set(sender, activator, input_data)
	self:set_property_value(self.value_prop, input_data.value)
	self:check()
end

function sv_object_counter:set_ref(sender, activator, input_data)
	self:set_property_value(self.ref_value_prop, input_data.value)
	self:check()
end

------------------------------------
-- клиентская часть 
cl_object_counter = utils.inherit(cl_game_object, object_counter)

function cl_object_counter:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	object_counter.register_properties(self, prop_registry);
end

function cl_object_counter:on_init()
	cl_game_object.on_init(self);
	self:set_update_enable(false);
end
