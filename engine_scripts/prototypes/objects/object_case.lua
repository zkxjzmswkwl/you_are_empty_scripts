------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- object_case - case (дешифратор) выдает сигнал на одном из входов, 
-- число у которого совпадает с соответствующим входным числом
------------------------------------------------------------------------

------------------------------------
-- общая часть
object_case = {
	guid = {0x9c1ebf6c, 0x9688, 0x40d2, 0x9f, 0xd0, 0xff, 0xf9, 0xe2, 0xfd, 0x33, 0x39},
}

function object_case:register_properties(prop_registry)
	self.v0_prop = self:register_property(prop_registry, "v0", 0);
	self.v1_prop = self:register_property(prop_registry, "v1", 1);
	self.v2_prop = self:register_property(prop_registry, "v2", 2);
	self.v3_prop = self:register_property(prop_registry, "v3", 3);
	self.v4_prop = self:register_property(prop_registry, "v4", 4);
end

------------------------------------
-- серверная часть 
sv_object_case = utils.inherit(sv_game_object, object_case)

function sv_object_case:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	object_case.register_properties(self, prop_registry);

	self.in_value_slot	= self:register_input_slot("in_value", self.in_value, "value = 0")
	self.in_random_slot = self:register_input_slot("in_random", self.in_random, "v0 = true, v1 = true, v2 = true, v3 = true, v4 = true");

	self.out_v0_slot	= self:register_output_slot("on_equal_v0", nil)
	self.out_v1_slot	= self:register_output_slot("on_equal_v1", nil)
	self.out_v2_slot	= self:register_output_slot("on_equal_v2", nil)
	self.out_v3_slot	= self:register_output_slot("on_equal_v3", nil)
	self.out_v4_slot	= self:register_output_slot("on_equal_v4", nil)
end

function sv_object_case:on_init()
	sv_game_object.on_init(self);
	self:set_update_enable(false);
end

function sv_object_case:in_value(sender, activator, input_data)

	if self:is_enable() == false then return end

	if	
		input_data.value == self:get_property_value(self.v0_prop)
	then
		self:emit_signals(self.out_v0_slot)
	elseif
		input_data.value == self:get_property_value(self.v1_prop)
	then
		self:emit_signals(self.out_v1_slot)
	elseif
		input_data.value == self:get_property_value(self.v2_prop)
	then
		self:emit_signals(self.out_v2_slot)
	elseif
		input_data.value == self:get_property_value(self.v3_prop)
	then
		self:emit_signals(self.out_v3_slot)
	elseif
		input_data.value == self:get_property_value(self.v4_prop)
	then
		self:emit_signals(self.out_v4_slot)
	end
end

function sv_object_case:in_random(sender, activator, input_data)

	if self:is_enable() == false then return end
	
	local num = 0
	local buf = {}
	
	if input_data.v0 == true then
		buf[num] = self.out_v0_slot
		num = num + 1
	end
	if input_data.v1 == true then
		buf[num] = self.out_v1_slot
		num = num + 1
	end
	if input_data.v2 == true then
		buf[num] = self.out_v2_slot
		num = num + 1
	end
	if input_data.v3 == true then
		buf[num] = self.out_v3_slot
		num = num + 1
	end
	if input_data.v4 == true then
		buf[num] = self.out_v4_slot
		num = num + 1
	end
	
	local value = math.random(0, num)
	if	
		value <= 1
	then
		self:emit_signals(buf[0])
	elseif
		value <= 2
	then
		self:emit_signals(buf[1])
	elseif
		value <= 3
	then
		self:emit_signals(buf[2])
	elseif
		value <= 4
	then
		self:emit_signals(buf[3])
	elseif
		value <= 5
	then
		self:emit_signals(buf[4])
	end
end

------------------------------------
-- клиентская часть 
cl_object_case = utils.inherit(cl_game_object, object_case)

function cl_object_case:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	object_case.register_properties(self, prop_registry);
end

function cl_object_case:on_init()
	cl_game_object.on_init(self);
	self:set_update_enable(false);
end
