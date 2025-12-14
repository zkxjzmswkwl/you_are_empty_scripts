------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Базовый класс для метательного оружия.
------------------------------------------------------------------------

-- общая часть
weapon_missile = {
};

---------------------------------------------------------------------------------
function weapon_missile:on_init()
end

---------------------------------------------------------------------------------
function weapon_missile:register_properties(prop_registry) 
	self.m_min_velocity_prop = self:register_property(prop_registry, "min_velocity", self.m_min_velocity);
		
	self.m_max_velocity_prop = self:register_property(prop_registry, "max_velocity", self.m_max_velocity);
		
	self.m_time_to_gain_max_velocity_prop = self:register_property(prop_registry, 
		"time_to_gain_max_velocity", self.m_time_to_gain_max_velocity);
end

---------------------------------------------------------------------------------
-- серверная часть 
sv_weapon_missile = utils.inherit(sv_weapon_firearm, weapon_missile);

---------------------------------------------------------------------------------
function sv_weapon_missile:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
	weapon_missile.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------------
function sv_weapon_missile:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_missile.on_init(self);
	
	-- дополнительное состояние для выстрела
	self.fire_start_state	= self:add_fsm_state(self.main_fsm, "fire_start_state", self.on_enter_fire_start, self.on_update_fire_start, nil, nil);
end

---------------------------------------------------------------------------------
function sv_weapon_missile:can_be_selected()
	-- Если нет патронов, то не позволяем выбирать оружие
	return not self:is_empty()
end

---------------------------------------------------------------------------
function sv_weapon_missile:event_reload()	
	-- Ничего не делаем, в отличие от версии в sv_weapon_firearm
end

---------------------------------------------------------------------------
function sv_weapon_missile:event_lever1_down()
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	--.hack	
	self.m_lever_down_time = engine.get_game_time()
		
	if cur_state == self.idle_state  then
		if self:can_fire() then
			self.m_lever_down_time = engine.get_game_time()
			self:change_fsm_state(self.main_fsm, self.fire_start_state, true);
		else
			if self:can_reload() then
				self:reload_ammo()
				self:change_fsm_state(self.main_fsm, self.fire_start_state, true);
			end
		end 
	end
	self.m_event_lever1_up = false
end

---------------------------------------------------------------------------
function sv_weapon_missile:event_lever1_up()
	self.m_lever_up_time = engine.get_game_time()
	self.m_event_lever1_up = true
end

---------------------------------------------------------------------------
function sv_weapon_missile:on_enter_fire_start()
	self:visualize_state(self.main_fsm, self.state_visual_info, "fire_start");
end

---------------------------------------------------------------------------
function sv_weapon_missile:on_update_fire_start()
	if self.m_event_lever1_up then
		self:change_fsm_state(self.main_fsm, self.fire_state, true);
	end
end

---------------------------------------------------------------------------
function sv_weapon_missile:on_enter_fire()
	self:visualize_state(self.main_fsm, self.state_visual_info, "fire");
end

---------------------------------------------------------------------------------
function sv_weapon_missile:on_event(event_id, event)
	sv_weapon_firearm.on_event(self, event_id, event);
end

---------------------------------------------------------------------------
function sv_weapon_missile:on_update_fire()
	local owner = self:get_owner();
	if owner then
	
		local min_velocity = self:get_property_value(self.m_min_velocity_prop)
		local max_velocity = self:get_property_value(self.m_max_velocity_prop)
		local time_to_gain_max_velocity = self:get_property_value(self.m_time_to_gain_max_velocity_prop)
		
		-- Направление атаки: прямо перед собой
		local attack_dir = owner:calc_target_dir({0, 0, 0}, 0, 0, 0);
		
		-- Время удерживания гранаты
		local hold_time = self.m_lever_up_time - self.m_lever_down_time
		-- Определим скорость пропорционально времени удержания
		local velocity
		if hold_time > time_to_gain_max_velocity then 
			velocity = max_velocity
		else
			velocity = min_velocity + (max_velocity - min_velocity) * hold_time / time_to_gain_max_velocity
		end
		
		-- Бросаем гранату
		owner:fire_missile(self.m_throw_point_offset, attack_dir, self.m_missile_ammo_class, 
			0, velocity, self.m_angular_velocity);		
		
		-- Уменьшаем количество патронов
		self:set_property_value(self.m_loaded_ammo_prop, 
			self:get_property_value(self.m_loaded_ammo_prop) - self.m_ammo_for_shot);
	end
	
	self:change_fsm_state(self.main_fsm, self.fire_finish_state, true);
end

---------------------------------------------------------------------------
function sv_weapon_missile:on_enter_fire_finish()
	if self:can_reload() then
		self:visualize_state(self.main_fsm, self.state_visual_info, "fire_finish");
	end
end

---------------------------------------------------------------------------
function sv_weapon_missile:on_update_fire_finish()
	if self:can_reload() then
		self:reload_ammo()	
		self:change_fsm_state(self.main_fsm, self.idle_state, true);
	else
		-- Закончились патроны - преключаемся на следующее оружие (по приоритету)
		local owner = self:get_owner()
		if owner then
			if not owner:select_weapon(BEST_WEAPON) then
				owner:deselect_current_holdable()
			end
		end
	end
end

---------------------------------------------------------------------------
function sv_weapon_missile:on_enter_hide()
	sv_weapon_basic.on_enter_hide(self);
end
---------------------------------------------------------------------------
function sv_weapon_missile:event_lever2_down()
	-- Ничего не делаем, в отличие от версии в sv_weapon_firearm
end

---------------------------------------------------------------------------------
-- клиентская
cl_weapon_missile = utils.inherit(cl_weapon_firearm, weapon_missile);

---------------------------------------------------------------------------------
function cl_weapon_missile:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_missile.on_init(self);
end

---------------------------------------------------------------------------------
function cl_weapon_missile:register_properties(prop_registry)
	cl_weapon_firearm.register_properties(self, prop_registry);
	weapon_missile.register_properties(self, prop_registry);
end