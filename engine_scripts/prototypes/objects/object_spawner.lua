------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Vyacheslav Korotayev
------------------------------------------------------------------------
-- object_spawner - создает объекты с заданными свойствами 
-- в месте расположения самого spawner'а
------------------------------------------------------------------------

------------------------------------
-- общая часть
object_spawner = {
	guid = {0x6b38498a, 0x28de, 0x4312, 0x9a, 0xad, 0x65, 0x35, 0x7a, 0x68, 0xef, 0xd},
}

------------------------------------
function object_spawner:register_properties(prop_registry)
	self.m_class_name		= self:register_property(prop_registry, "class_name", "-unknown-");
	self.m_prop_table_name	= self:register_property(prop_registry, "prop_table_name", "-unknown-");
	self:set_update_enable(false);
end

------------------------------------
-- серверная часть 
sv_object_spawner = utils.inherit(sv_game_object, object_spawner)

------------------------------------
function sv_object_spawner:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	object_spawner.register_properties(self, prop_registry);

	-- Регистрация слотов
	self.spawn = self:register_input_slot("spawn", self.spawn)
end

------------------------------------
function sv_object_spawner:spawn(sender, activator, input_data)
	-- Создаем объект
	local new_obj = engine.spawn_entity( self:get_property_value(self.m_class_name) );

	-- Задаем свойства
	local prop_table = _G[self:get_property_value(self.m_prop_table_name)]
	if prop_table then
		for i,v in ipairs(prop_table) do
			new_obj:set_property_value_by_name(v[1], v[2]);
		end
	end

	-- Добавляем объект
	engine.add_entity_to_world(new_obj);
	new_obj:set_pos( self:get_pos() )
end

------------------------------------
-- клиентская часть 
cl_object_spawner = utils.inherit(cl_game_object, object_spawner)

------------------------------------
function cl_object_spawner:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry)
	object_spawner.register_properties(self, prop_registry)	
end