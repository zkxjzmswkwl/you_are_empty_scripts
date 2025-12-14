------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
--
------------------------------------------------------------------------
-- Прототип объекта якоря для навигации ИИ
------------------------------------------------------------------------

------------------------------------
-- общая часть
ai_anchor = {
	guid = {0x229022b6, 0xab78, 0x4bd8, 0x81, 0x8c, 0x8f, 0x33, 0x75, 0x96, 0xa8, 0x5c},
}

function ai_anchor:register_properties(prop_registry)
	--self:register_property(prop_registry, "model_name", "Key_Iron");
	
	self.m_range_prop =  self:register_property(prop_registry, "range", 1.5);
	self.m_allowed_attacks_prop = self:register_property(prop_registry, "allowed_attacks", " ");
	self.m_disallowed_attacks_prop = self:register_property(prop_registry, "disallowed_attacks", " ");
	self.m_blind_attack_allowed_prop = self:register_property(prop_registry, "blind_attack_allowed", false);
	self.m_use_inactive_prop = self:register_property(prop_registry, "use_even_inactive", false);
	
	self.m_priority_prop =  self:register_property(prop_registry, "priority", 1);

	self.m_auto_activate_prop = self:register_property(prop_registry, "auto_activate", false);
	self.m_fov_to_enemy_prop = self:register_property(prop_registry, "fov_to_enemy", 90);
	self.m_max_dist_to_enemy_prop = self:register_property(prop_registry, "max_dist_to_enemy", 10);
	self.m_min_dist_to_enemy_prop = self:register_property(prop_registry, "min_dist_to_enemy", 5);

	self.m_activate_on_event_prop = self:register_property(prop_registry, "activate_on_event", false);
	
	-- 
	self.m_random_activate_prop = self:register_property(prop_registry, "random_activation", false);
	self.m_active_time_min_prop = self:register_property(prop_registry, "active_time_min", 10000);
	self.m_active_time_max_prop = self:register_property(prop_registry, "active_time_max", 20000);
	self.m_inactive_time_min_prop = self:register_property(prop_registry, "inactive_time_min", 10000);
	self.m_inactive_time_max_prop = self:register_property(prop_registry, "inactive_time_max", 20000);

	--
	self.m_block_movement_prop = self:register_property(prop_registry, "block_movement", true);
	self.m_block_turn_prop = self:register_property(prop_registry, "block_turn", false);
	
	-- визуальные состояния которые будет использовать актер вместо оригинальных, 
	-- после активации якоря
	self.m_visual_config_prop = self:register_property(prop_registry, "visual_config", "?");
end

function ai_anchor:on_init()
end
	
------------------------------------
-- серверная часть 
sv_ai_anchor = utils.inherit(sv_game_object, ai_anchor);

--.debug
sv_ai_anchor.ACTIVE_COLOR = {0, 1, 0};
sv_ai_anchor.NOT_ACTIVE_COLOR = {0, 0.5, 0};
sv_ai_anchor.OCCUPIED_COLOR = {0, 1, 1};


function sv_ai_anchor:register_properties(prop_registry)
	---------------------------------------------------------------------------------------
	sv_game_object.register_properties(self, prop_registry);
	ai_anchor.register_properties(self, prop_registry);
	---------------------------------------------------------------------------------------
	self.in_activate	= self:register_input_slot("activate", self.activate);
	self.in_deactivate	= self:register_input_slot("deactivate", self.deactivate);

	self.out_activate	= self:register_output_slot("on_activate", nil);
	self.out_deactivate	= self:register_output_slot("on_deactivate", nil);

	self.out_occupy		= self:register_output_slot("on_occupy", nil);
	self.out_free		= self:register_output_slot("on_free", nil);
	---------------------------------------------------------------------------------------
	self.m_debug_sphere_color_prop = self:get_property_by_name("debug_sphere_color");

end

function sv_ai_anchor:on_init(dreader)
	sv_game_object.on_init(self);
	ai_anchor.on_init(self);
	
	-- устанавливается ИИ контроллером, когда тот занял для себя этот tag point
	self.m_is_occupied = false;
	self.m_occupier = nil;
	
	-- устанавливается ИИ контроллером, когда тот выбрал якорь и бежит к нему
	self.m_wanter = nil;
	self.m_wanter_dist = false;
	self.m_wanter_set_time = 0;

	local allowed_attacks_str = self:get_property_value(self.m_allowed_attacks_prop);
	if(allowed_attacks_str == "all") then
		self.m_allowed_attacks = "all";
	else
		self.m_allowed_attacks = utils.create_table_from_string(allowed_attacks_str);
	end

	local disallowed_attacks_str = self:get_property_value(self.m_disallowed_attacks_prop);
	if(disallowed_attacks_str == "all") then
		self.m_disallowed_attacks = "all";
	else
		self.m_disallowed_attacks = utils.create_table_from_string(disallowed_attacks_str);
	end
	
	self.m_enemy_in_fov = false;
	
	self:set_property_value(self.m_debug_sphere_color_prop, sv_ai_anchor.NOT_ACTIVE_COLOR);
	
	-- принудительно заставляем сработать deactive
	self.m_is_active = true;
	self:deactivate();
	
	self.io.temporary_activation = true;
end

function sv_ai_anchor:post_load_init()
	if(self:get_property_value(self.m_random_activate_prop) == true) then
		self:set_update_enable(true);
	end
end

function sv_ai_anchor:on_shutdown()
	sv_game_object.on_shutdown(self);
end

function sv_ai_anchor:on_update(dt)
	sv_game_object.on_update(self, dt);
	
	if(self.io.m_next_activation_time and
		self.io.m_next_activation_time < engine.get_game_time()) then
		self.io.temporary_activation = true;
	end
	
	if(self.io.m_next_deactivation_time and
		self.io.m_next_deactivation_time < engine.get_game_time()) then
		self.io.temporary_activation = false;
	end
		
end

function sv_ai_anchor:on_destroy()
	if(self:is_occupied() == true) then
		--console.print(" ---- sv_ai_anchor:on_destroy()");
		self.m_occupier:use_anchor(self, false);
	end
end


function sv_ai_anchor:get_range()
	local range = self:get_property_value(self.m_range_prop);
	return range;
end


function sv_ai_anchor:get_visual_config()
	local visual_config = self:get_property_value(self.m_visual_config_prop);
	return visual_config;
end


------------------------------------------------

function sv_ai_anchor:activate()
	if(self:get_property_value(self.m_activate_on_event_prop) == true) then
		self:set_active(true);
	end
end

function sv_ai_anchor:deactivate()
	if(self:get_property_value(self.m_activate_on_event_prop) == true) then
		self:set_active(false);
	end
end

------------------------------------------------

function sv_ai_anchor:set_occupy(occupier)
	--.debug
	if(occupier ~= nil) then
		self:set_property_value(self.m_debug_sphere_color_prop, sv_ai_anchor.OCCUPIED_COLOR);
	else
		if(self.m_is_active == true) then
			self:set_property_value(self.m_debug_sphere_color_prop, sv_ai_anchor.ACTIVE_COLOR);
		else	
			self:set_property_value(self.m_debug_sphere_color_prop, sv_ai_anchor.NOT_ACTIVE_COLOR);
		end	
	end
	
	if(occupier ~= nil) then
	
		--assert(self.m_occupier == nil, "anchor already occupied!");
		if(self.m_occupier ~= nil) then
			--engine.warning(" anchor already occupied! ");
		end
	
		self.m_is_occupied = true;
		self.m_occupier = occupier;
		self:emit_signals(self.out_occupy, occupier:get_attached_actor_body());
		

		-- random deactivation
		if(self:get_property_value(self.m_random_activate_prop) == true) then
			self.io.m_next_activation_time = nil;
			self.io.m_next_deactivation_time = engine.get_game_time() + 
				math.random(self:get_property_value(self.m_active_time_min_prop), 
				self:get_property_value(self.m_active_time_max_prop));
		end

	else
--		assert(self.m_occupier ~= nil, "anchor not occupied!");
-- [[
		if(self.m_occupier == nil) then 
			self.m_is_occupied = false;
			return;
		end
	--]]		
		self.m_is_occupied = false;
		self:emit_signals(self.out_free, self.m_occupier:get_attached_actor_body());
		self.m_occupier = nil;
		
		-- random activation
		if(self:get_property_value(self.m_random_activate_prop) == true) then
			self.io.m_next_deactivation_time = nil;
			self.io.m_next_activation_time = engine.get_game_time() + 
					math.random(self:get_property_value(self.m_inactive_time_min_prop), 
					self:get_property_value(self.m_inactive_time_max_prop));
		end

	end
end

function sv_ai_anchor:is_occupied()
	return self.m_is_occupied;
end

function sv_ai_anchor:am_i_occupier(occupier)
	if(self.m_occupier and 
		self.m_occupier.index_in_factory == occupier.index_in_factory) then
		return true;
	else
		return false;
	end
end

function sv_ai_anchor:get_occupier()
	return self.m_occupier;
end
------------------------------------------------
function sv_ai_anchor:set_wanted(wanter, dist_from_wanter)
	self.m_wanter = wanter;
	self.m_wanter_dist = dist_from_wanter;
	self.m_wanter_set_time = engine.get_game_time();
end

function sv_ai_anchor:can_be_wanter(wanter, dist_from_wanter)
	if(self.m_wanter == nil or 
		self.m_wanter.index_in_factory == wanter.index_in_factory or
 --[[
		self.m_wanter_dist > 2 * dist_from_wanter or
--]]
		(engine.get_game_time() - self.m_wanter_set_time) > 1000

	) then
		return true;
	else
		return false;	
	end
end

------------------------------------------------
function sv_ai_anchor:is_auto_activate()
	return self:get_property_value(self.m_auto_activate_prop);
end

function sv_ai_anchor:set_active(is_true)
	if(is_true ~= self.m_is_active) then
		if(is_true == true) then
			self:set_property_value(self.m_debug_sphere_color_prop, sv_ai_anchor.ACTIVE_COLOR);
			self:emit_signals(self.out_activate, self);
		else	
			self:set_property_value(self.m_debug_sphere_color_prop, sv_ai_anchor.NOT_ACTIVE_COLOR);
			self:emit_signals(self.out_deactivate, self);
		end
	end

	self.m_is_active = is_true;
end


function sv_ai_anchor:set_enemy_in_fov(is_true)
	self.m_enemy_in_fov = is_true;
end

function sv_ai_anchor:is_active()
	return self:is_enable() and self.m_is_active and self.io.temporary_activation;
end

function sv_ai_anchor:is_can_be_used()
	return self:is_enable() and (self:is_active() or self:is_use_inactive());
end

function sv_ai_anchor:is_block_movement()
	return self:get_property_value(self.m_block_movement_prop);
end

function sv_ai_anchor:is_use_inactive()
	return self:get_property_value(self.m_use_inactive_prop);
end

function sv_ai_anchor:is_block_turn()
	return self:get_property_value(self.m_block_turn_prop);
end

function sv_ai_anchor:is_blind_attack_allowed()
	
	if(self:is_auto_activate()) then
		return  self:get_property_value(self.m_blind_attack_allowed_prop) and self:is_active();
	else
		return  self:get_property_value(self.m_blind_attack_allowed_prop);
	end	
end

function sv_ai_anchor:get_min_dist_to_enemy()
	return self:get_property_value(self.m_min_dist_to_enemy_prop);
end

function sv_ai_anchor:get_max_dist_to_enemy()
	return self:get_property_value(self.m_max_dist_to_enemy_prop);
end

function sv_ai_anchor:get_fov_to_enemy()
	return self:get_property_value(self.m_fov_to_enemy_prop);
end


function sv_ai_anchor:get_priority()
	return self:get_property_value(self.m_priority_prop);
end


------------------------------------
-- клиентская часть
cl_ai_anchor = utils.inherit(cl_game_object, ai_anchor);

function cl_ai_anchor:on_init()
	cl_game_object.on_init(self);
	ai_anchor.on_init(self);
end