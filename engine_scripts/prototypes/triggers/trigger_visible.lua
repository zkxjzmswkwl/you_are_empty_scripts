------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- trigger_visible - триггер, срабатывыющий на видимость игроками
------------------------------------------------------------------------

------------------------------------
-- общая часть
trigger_visible = {
	guid = {0x4228a215, 0xb0a6, 0x4177, 0xad, 0xf3, 0x31, 0x91, 0x8, 0x18, 0x92, 0x14},
};

function trigger_visible:register_properties(prop_registry)
	---------------------------------------------------------------------------------------
	self.max_distance_prop	= self:register_property(prop_registry, "max_distance", -1);
	self.fov_prop				= self:register_property(prop_registry, "fov", 90);
	self.is_need_trace		= self:register_property(prop_registry, "is_need_trace", false);
	self.enter_delay_prop	= self:register_property(prop_registry, "enter_delay", 0);
	self.leave_delay_prop	= self:register_property(prop_registry, "leave_delay", 0);
	---------------------------------------------------------------------------------------
end

------------------------------------
-- серверная часть 

sv_trigger_visible = utils.inherit(sv_game_object, trigger_visible);
sv_trigger_visible.is_in_view = false;
sv_trigger_visible.enter_time = -1;
sv_trigger_visible.leave_time = -1;

function sv_trigger_visible:register_properties(prop_registry)
	---------------------------------------------------------------------------------------
	sv_game_object.register_properties(self, prop_registry);
	trigger_visible.register_properties(self, prop_registry);
	---------------------------------------------------------------------------------------
	self.on_enter_visibility	= self:register_output_slot("on_enter_visibility", nil);
	self.on_leave_visibility	= self:register_output_slot("on_leave_visibility", nil);
	---------------------------------------------------------------------------------------
end

function sv_trigger_visible:on_init()
	---------------------------------------------------------------------------------------
	sv_game_object.on_init(self);
	---------------------------------------------------------------------------------------
end

function sv_trigger_visible:on_update(dt)
	sv_game_object.on_update(self, dt);
	
	local my_pos = self:get_pos();
	local max_dist = self:get_property_value(self.max_distance_prop)*M2U;
	
	local players = engine.get_entities_by_name("$single_player_actor");
	local is_visible = false;

	for i,player in players
	do
		-- позиция игрока
		local pl_pos = player:get_pos();
		
		-- проверка видимости по углу
		if player:is_object_visible(self, self:get_property_value(self.fov_prop))
		then
			-- проверка видимости по расстоянию
			local distance_check = false;
			if max_dist <= 0 then
				distance_check = true;
			else	
				local dist_sqrt = utils.vec3_dist_sqrt(my_pos, pl_pos);
			    if dist_sqrt <= max_dist*max_dist then distance_check = true; end
			end
						
			if distance_check
			then
				-- основные тесты пройдены, считаем, что видимость есть
				is_visible = true;

				-- если надо, то проверка видимости по трассировке
				if self:get_property_value(self.is_need_trace)
				then
					was_intersection, point, normal, obj = trace_to_pos(pl_pos, my_pos, player);
					if was_intersection == true
					then
						-- нет видимости по трассировке
						is_visible = false;
					end
				end
	
				if is_visible then
					self:in_visibility();
				end
			end
		end
	end
	
	if is_visible ~= true then
		self:out_visibility();
	end
end

------------------------------------
function sv_trigger_visible:in_visibility()
	if self.is_in_view ~= true
	then
		if self.enter_time < 0 then
			self.enter_time = engine.get_game_time();
		end
	
		if self.enter_time + self:get_property_value(self.enter_delay_prop) <= engine.get_game_time()
		then
			self:emit_signals(self.on_enter_visibility);
			self.is_in_view = true;
			self.enter_time = -1;
		end
	end
	self.leave_time = -1;
end

function sv_trigger_visible:out_visibility()
	if self.is_in_view ~= false
	then
		if self.leave_time < 0 then
			self.leave_time = engine.get_game_time();
		end
	
		if self.leave_time + self:get_property_value(self.leave_delay_prop) <= engine.get_game_time()
		then
			self:emit_signals(self.on_leave_visibility);
			self.is_in_view = false;
			self.leave_time = -1;
		end
	end
	self.enter_time = -1;
end

------------------------------------
-- клиентская часть 
cl_trigger_visible = utils.inherit(cl_game_object, trigger_visible);

function cl_trigger_visible:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	trigger_visible.register_properties(self, prop_registry);
end
