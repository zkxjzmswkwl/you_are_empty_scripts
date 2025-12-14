------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- object_flare
------------------------------------------------------------------------

------------------------------------
-- общая часть
object_flare = {
	guid = {0x8b0d8dd3, 0xc782, 0x4a0f, 0xb2, 0x88, 0xb5, 0x3, 0xa0, 0xb8, 0x13, 0x61},
}

function object_flare:register_properties(prop_registry)
	self.m_table_name_prop = self:register_property(prop_registry, "table_name", " ");
end

------------------------------------
-- серверная часть 
sv_object_flare = utils.inherit(sv_game_object, object_flare)

function sv_object_flare:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	object_flare.register_properties(self, prop_registry);
end

function sv_object_flare:on_update(dt)
	sv_game_object.on_update(self, dt)
	self:set_update_enable(false)
end

------------------------------------
-- клиентская часть 
cl_object_flare = utils.inherit(cl_game_object, object_flare)

function cl_object_flare:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	object_flare.register_properties(self, prop_registry);
end

function cl_object_flare:on_init()
	cl_game_object.on_init(self)
	self.m_flare = engine.create_flare(self:get_pos(), self:get_property_value(self.m_table_name_prop))
	if self.m_flare == nil then
		engine.error("Cannot create flare object\nclass_name: "..self.class_name.."\nname: "..self:get_property_value_by_name(self.m_name))
	end
	engine.place_flare(self.m_flare, self:get_pos());
end

function cl_object_flare:on_update(dt)
	cl_game_object.on_update(self, dt)
	self:set_update_enable(false)
end

function cl_object_flare:on_tm_changed()
	if self.m_flare ~= nil then
		engine.place_flare(self.m_flare, self:get_pos());
	end
end

function cl_object_flare:on_shutdown()
	cl_game_object.on_shutdown(self)
	engine.destroy_flare(self.m_flare);
end

function cl_object_flare:on_enable(is_enable)
	engine.enable_flare(self.m_flare, is_enable);
end
