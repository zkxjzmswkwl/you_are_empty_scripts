------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- timer
------------------------------------------------------------------------

------------------------------------
-- общая часть
timer = {
	guid = {0x7706d5e, 0x7e98, 0x4ac1, 0xa2, 0xff, 0xa5, 0x10, 0x80, 0x5b, 0xef, 0xdf},
}

function timer:register_properties(prop_registry)
	self.time_min_prop = self:register_property(prop_registry, "time_min", 500);
	self.time_max_prop = self:register_property(prop_registry, "time_max", 1000);
	self.time_left_prop = self:register_property(prop_registry, "time_left", 0);
	self.ticks_count_prop = self:register_property(prop_registry, "ticks_count", 0);
	self.ticks_count_max_prop = self:register_property(prop_registry, "ticks_count_max", -1);
	self.next_time_prop = self:register_property(prop_registry, "next_time", -1);
	self.local_time_prop = self:register_property(prop_registry, "local_time", 0);
end

------------------------------------
-- серверная часть 
sv_timer = utils.inherit(sv_game_object, timer)

function sv_timer:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	timer.register_properties(self, prop_registry);
	self.in_reset			= self:register_input_slot("reset", self.in_reset);
	-- Принудительный вызов события tick
	self.in_tick			= self:register_input_slot("tick", self.in_tick);
	self.out_tick_slot		= self:register_output_slot("on_tick", nil)
end

function sv_timer:on_update(dt)
	sv_game_object.on_update(self, dt)

	-- проверка на окончание работы по количеству тиков	
	local ticks_count = self:get_property_value(self.ticks_count_prop)
	local ticks_count_max = self:get_property_value(self.ticks_count_max_prop)
	if ticks_count_max >= 0 and ticks_count >= ticks_count_max then return end
	
	-- корректировка времен
	local time_max = self:get_property_value(self.time_max_prop);
	local time_min = self:get_property_value(self.time_min_prop);
	
	if time_min < 0 then
		console.warning("[timer] Warning: time_min < 0")
		time_min = 0
	end

	if time_max < time_min then
		console.warning("[timer] Warning: time_max < time_min")
		time_max = time_min
	end

	-- получим значения из properties
	local next_time = self:get_property_value(self.next_time_prop);
	local local_time = self:get_property_value(self.local_time_prop);

	if next_time < 0
	then
		-- первый раз не срабатываем
		next_time = local_time + time_min;
	elseif next_time < local_time
	then
		local time_left = time_min;
		if time_max > time_min then 
			-- возможно задавать одинаковые времена в интервале
			time_left = time_left + math.random(time_max - time_min)
		end
		
		-- время следующего срабатывания
		next_time = local_time + time_left

		self:set_property_value(self.time_left_prop, time_left)
		self:set_property_value(self.ticks_count_prop, ticks_count + 1)

		self:emit_signals(self.out_tick_slot)
	end

	-- просчет локального времени
	local_time = local_time + dt
	
	-- установим обновленные значения
	self:set_property_value(self.next_time_prop, next_time)
	self:set_property_value(self.local_time_prop, local_time)
	
end

-----------------------------------
-- input slots
-----------------------------------
function sv_timer:in_reset()
	self:set_property_value(self.next_time_prop, -1)
	self:set_property_value(self.local_time_prop, 0)
	self:set_property_value(self.time_left_prop, 0)
	self:set_property_value(self.ticks_count_prop, 0)
end

------------------------------------
function sv_timer:in_tick()
	local ticks_count = self:get_property_value(self.ticks_count_prop)
	self:set_property_value(self.ticks_count_prop, ticks_count + 1)
	self:emit_signals(self.out_tick_slot)
end

------------------------------------
-- клиентская часть 
cl_timer = utils.inherit(cl_game_object, timer)

function cl_timer:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	timer.register_properties(self, prop_registry);
end

function cl_timer:on_init(dreader)
	cl_game_object.on_init(self, dreader)
	self:set_update_enable(false)
end
