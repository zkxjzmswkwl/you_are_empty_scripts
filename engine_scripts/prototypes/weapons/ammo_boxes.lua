------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Коробки с патронами для различных типов оружия
------------------------------------------------------------------------

function create_ammo_box(_guid, _ammo_box_model, _ammo_name, _ammo_capacity, _snd_on_take, _pp_on_take, _icon_id)

	local _common_table = {};
	local _server_table = {};
	local _client_table = {};
								
	_common_table.guid = _guid;
	_server_table = utils.inherit(sv_game_object, _common_table);
	_server_table.register_properties = function(self, prop_registry)
		sv_game_object.register_properties(self, prop_registry);
		self:set_property_value_by_name("model_name",	_ammo_box_model);
		self:set_property_value_by_name("ammo_name",	_ammo_name);
		self:set_property_value_by_name("ammo_capacity",_ammo_capacity);
		self:set_property_value_by_name("ammo_stored",	_ammo_capacity);
		self:set_property_value_by_name("sound_on_take",_snd_on_take);
		self:set_property_value_by_name("pp_on_take",	_pp_on_take);
	end
	
	_server_table.on_init = function(self)
		sv_game_object.on_init(self);
		self:set_property_value_by_name("is_can_take", false);
		self:set_update_enable(false);
	end	
	
	-- использование патронов актером
	_server_table.on_use = function(self, activator)
	
		-- проверка на то, можно ли подобрать патроны
		-- или у нас уже нет метса
		
		if(activator.get_all_from_inventory == nil) then return end
		
		-- перебираем все слоты
		for i, slot_name in pairs(g_weapon_slots) do
			
			local weapons = activator:get_all_from_inventory(slot_name)
			if type(weapons) ~= "table" then
				continue
			end
				
			-- Перебираем все оружия данного слота
			for j, weapon in pairs(weapons) do	
				
				-- Каждое оружие, использующее данный тип патронов
				-- пересчитывает количество доступных патронов
				if weapon.m_ammo_class == self.class_name and weapon:get_owner() then
					if(weapon.m_all_ammo_prop and weapon.m_max_ammo_prop and 
						weapon:get_property_value(weapon.m_all_ammo_prop) < weapon:get_property_value(weapon.m_max_ammo_prop)) then
						local max_ammo = weapon:get_property_value(weapon.m_max_ammo_prop);
						local all_ammo = weapon:get_property_value(weapon.m_all_ammo_prop);
						
						local stored = self:get_property_value_by_name("ammo_stored");
						
						local taken_ammo = (all_ammo + stored > max_ammo) and
									(max_ammo - all_ammo) or stored;
						
						self:set_property_value_by_name("ammo_stored", taken_ammo);
						self:set_property_value_by_name("is_can_take", true);
					end
					-- не можем взять больше патронов
					do return; end
				end
			end
		end
		
		--engine.warning(" cant take ammo "..self.class_name);
		self:set_property_value_by_name("is_can_take", true);
	end
				
	
	-- Вызывается при подборе патронов
	_server_table.on_take = function(self, _holder)
		-- При подборе патронов, все оружия, использующие данный
		-- тип патронов должны пересчитать свое количество доступных патронов.
		
		-- Перебираем все слоты
		for i, slot_name in pairs(g_weapon_slots) do
			
			local weapons = _holder:get_all_from_inventory(slot_name)
			if type(weapons) ~= "table" then
				continue
			end
				
			-- Перебираем все оружия данного слота
			for j, weapon in pairs(weapons) do	
				-- Каждое оружие, использующее данный тип патронов
				-- пересчитывает количество доступных патронов
				if weapon.m_ammo_class == self.class_name and weapon:get_owner() then
					weapon:calc_ammo_count()
				end
			end
		end
	end

	_client_table = utils.inherit(cl_game_object, _common_table);
	_client_table.m_holdable_icon_id = _icon_id
		
	return _common_table, _server_table, _client_table;
end