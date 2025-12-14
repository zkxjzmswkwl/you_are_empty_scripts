------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Rat - монстр крыса
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_rat.guid = {0x90b0d667, 0x6cb4, 0x4dc9, 0xab, 0x21, 0xaa, 0xf2, 0xf, 0xd5, 0x35, 0x45};


function actor_rat:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_rat = utils.inherit(sv_actor_basic, actor_rat);

function sv_actor_rat:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_rat:on_init()
	sv_actor_basic.on_init(self);
	actor_rat.on_init(self);
	
	local bomb = engine.spawn_entity("Bomb")
	bomb:set_property_value_by_name("model_name", "rat")
	
	bomb:set_property_value_by_name("shape", "sphere")
	bomb:set_property_value_by_name("radius", 1)
	
	bomb:set_property_value_by_name("effect", "Rat_Blood.lua")
	bomb:set_property_value_by_name("debris_model", "rat_debris")
	
	bomb:set_property_value_by_name("auto_fall_apart", true)
	bomb:set_property_value_by_name("debris_scattering", 200000)
	
	engine.add_entity_to_world(bomb)
	
	self.m_bomb = bomb;

end
	
function sv_actor_rat:on_death()

	self.m_bomb:set_pos(self:get_pos())
	self.m_bomb:signal("explode", self);

	engine.destroy_entity(self)
end




---------------------------------------------------------------------------
-- клиентская
cl_actor_rat = utils.inherit(cl_actor_basic, actor_rat);

function cl_actor_rat:on_init()
	cl_actor_basic.on_init(self);
	actor_rat.on_init(self);
end