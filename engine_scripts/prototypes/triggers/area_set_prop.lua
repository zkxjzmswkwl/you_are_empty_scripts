------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Vyacheslav Korotayev
------------------------------------------------------------------------
-- area_set_prop - зона, которая по входящему событию устанавливает 
-- указанное свойство объектам, которые в ней находятся.
------------------------------------------------------------------------

------------------------------------
-- общая часть
area_set_prop = {
	guid = {0x679abedf, 0x5ca9, 0x4933, 0x9d, 0xbe, 0xaa, 0x9a, 0x56, 0x34, 0x35, 0x11},
	UNKNOWN			= "-unknown-",
};

------------------------------------
function area_set_prop:register_properties(prop_registry)
end

------------------------------------
-- серверная часть 
sv_area_set_prop = utils.inherit(sv_game_object, area_set_prop);

function sv_area_set_prop:on_init()
	sv_game_object.on_init(self);
	self.m_property_name	= self.UNKNOWN
	self.m_property_value	= self.UNKNOWN
end
------------------------------------
function sv_area_set_prop:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	area_set_prop.register_properties(self, prop_registry);
	
	self.in_set_prop_slot = self:register_input_slot("set_contained_property",
		self.set_prop, "prop_name = '" .. self.UNKNOWN .. "',value = '" .. self.UNKNOWN .. "'")
end

------------------------------------
-- функции обработчики слотов
function sv_area_set_prop:set_prop(sender, activator, input_data)
	self.m_property_name	= input_data.prop_name
	self.m_property_value	= input_data.value
	self:Enable(true)
end

------------------------------------
function sv_area_set_prop:OnEnter(activator)
	
	local obj_property = activator:get_property_by_name(self.m_property_name)
	if obj_property then
		-- Задаем свойство попавшему объекту
		local prop_value	= self.m_property_value
		local value_number	= tonumber(prop_value)
		
		if value_number then
			activator:set_property_value_by_name(self.m_property_name, value_number)
		else
			if prop_value == "true" then
				activator:set_property_value_by_name(self.m_property_name, true)
			elseif prop_value == "false" then
				activator:set_property_value_by_name(self.m_property_name, false)
			else
				activator:set_property_value_by_name(self.m_property_name, prop_value)
			end
		end
	end
	
	return true
end

------------------------------------
function sv_area_set_prop:OnPhysicsAfterStep(activator)
	self:Enable(false)
	return true
end

------------------------------------
-- клиентская часть 
cl_area_set_prop = utils.inherit(cl_game_object, area_set_prop);

------------------------------------
function cl_area_set_prop:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	area_set_prop.register_properties(self, prop_registry);
end
