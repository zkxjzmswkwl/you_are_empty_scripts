------------------------------------------------------------------------
-- Copyright (C) 2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Vyacheslav Korotayev
------------------------------------------------------------------------
-- occlusion_area
------------------------------------------------------------------------

------------------------------------
-- общая часть
occlusion_area = {
	guid = {0xc0496291, 0x302a, 0x4f6b, 0x98, 0xc8, 0xb2, 0xd5, 0xe9, 0x9, 0x9d, 0x68},
}

function occlusion_area:register_properties(prop_registry)
end

------------------------------------
-- серверная часть 
sv_occlusion_area = utils.inherit(sv_game_object, occlusion_area)

function sv_occlusion_area:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	occlusion_area.register_properties(self, prop_registry);
end

------------------------------------
function sv_occlusion_area:on_init()
	sv_game_object.on_init(self)
	
	-- Создаем и запоминаем id для того, чтобы уничтожить area после уничтожения объекта
	self.m_area_id = self:create_occlusion_area()
	self:set_update_enable(false)
end

------------------------------------
function sv_occlusion_area:on_shutdown()
	sv_game_object.on_shutdown(self)
	
	self:destroy_occlusion_area(self.m_area_id)
end

------------------------------------
-- клиентская часть 
cl_occlusion_area = utils.inherit(cl_game_object, occlusion_area)

function cl_occlusion_area:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	occlusion_area.register_properties(self, prop_registry);
end

function cl_occlusion_area:on_init()
	cl_game_object.on_init(self)
	self:set_update_enable(false)
end
