------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Коробки с патронами для различных типов оружия
------------------------------------------------------------------------

-- общая часть
ammo_basic = {};

ammo_basic.properties_design =
{
}

----------------------------------------------------------------------
function ammo_basic:register_properties(prop_registry)
end

----------------------------------------------------------------------
function ammo_basic:on_init()
end

----------------------------------------------------------------------
-- серверная часть 
sv_ammo_basic = utils.inherit(sv_game_object, ammo_basic)

----------------------------------------------------------------------
function sv_ammo_basic:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	ammo_basic.register_properties(self, prop_registry);
	
	self:init_properties_from_table(self.properties_design)
end

----------------------------------------------------------------------
function sv_ammo_basic:on_init()
	sv_game_object.on_init(self)
	ammo_basic.on_init(self)
	
	self:set_property_value_by_name("is_can_take", false);
	self:set_update_enable(false);
end

----------------------------------------------------------------------
-- использование патронов актером
function sv_ammo_basic:on_use(activator)
	-- проверка на то, можно ли подобрать патроны
	-- или у нас уже нет места
	
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

----------------------------------------------------------------------
-- Вызывается при подборе патронов
function sv_ammo_basic:on_take(_holder)
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

----------------------------------------------------------------------------------
-- клиентская
cl_ammo_basic = utils.inherit(cl_game_object, ammo_basic);

----------------------------------------------------------------------------------
function cl_ammo_basic:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	ammo_basic.register_properties(self, prop_registry);
end

----------------------------------------------------------------------------------
function cl_ammo_basic:on_init()
	cl_game_object.on_init(self);
	ammo_basic.on_init(self);
end