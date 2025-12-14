------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- object_random - счетчик, выдающий сигнал по достижении заданного числа
------------------------------------------------------------------------

------------------------------------
-- общая часть
object_random = {
	guid = {0x567c195b, 0x52a5, 0x4e9a, 0x9e, 0x5c, 0xb5, 0xd9, 0xaf, 0x81, 0x49, 0x3a},
}

function object_random:register_properties(prop_registry)
	self.random_time_min_prop = self:register_property(prop_registry, "random_time_min", 500);
	self.random_time_max_prop = self:register_property(prop_registry, "random_time_max", 1000);
end

------------------------------------
-- серверная часть 
sv_object_random = utils.Inherit(sv_game_object, object_random)
sv_object_random.next_time = 0

function sv_object_random:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	object_random.register_properties(self, prop_registry);

	self.out_execute_slot = self:register_output_slot("on_execute", nil)
end

function sv_object_random:OnUpdate(dt)
	sv_game_object.OnUpdate(self, dt)
	local curr_time = engine.get_curr_time()
	
	if self.next_time < curr_time 
	then
		self.next_time = curr_time + math.random(self:get_property_value(self.random_time_min_prop) + 
															  self:get_property_value(self.random_time_max_prop))
		self:emit_signals(self.out_execute_slot)
	end
end

------------------------------------
-- клиентская часть 
cl_object_random = utils.Inherit(cl_game_object, object_random)

function cl_object_random:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	object_random.register_properties(self, prop_registry);
end
