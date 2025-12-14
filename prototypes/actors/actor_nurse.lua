------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Nurse - монстр мед. сестра
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть для актера
---------------------------------------------------------------------------------
actor_nurse.guid = {0xc930c049, 0xf91d, 0x41ef, 0xbb, 0xd5, 0xed, 0xb, 0xdd, 0x8e, 0xbb, 0x99};

function actor_nurse:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_nurse = utils.inherit(sv_actor_basic, actor_nurse);

function sv_actor_nurse:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end


function sv_actor_nurse:on_init()
	sv_actor_basic.on_init(self);
	actor_nurse.on_init(self);
        

end
	
function sv_actor_nurse:on_death()
	local med = engine.spawn_entity("item_medikit_small")
	med:set_pos(self:get_pos())
	engine.add_entity_to_world(med)
	sv_actor_basic.on_death(self)

end
---------------------------------------------------------------------------
-- клиентская
cl_actor_nurse = utils.inherit(cl_actor_basic, actor_nurse);

function cl_actor_nurse:on_init()
	cl_actor_basic.on_init(self);
	actor_nurse.on_init(self);
end