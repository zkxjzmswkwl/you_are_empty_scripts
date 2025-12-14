------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Hen - монстр курица
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_hen.guid = {0x9c78768f, 0xcc4f, 0x4806, 0x91, 0x8e, 0x84, 0x25, 0x3e, 0xb6, 0x7d, 0xd};

function actor_hen:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_hen = utils.inherit(sv_actor_basic, actor_hen);

-------------------------------------
function sv_actor_hen:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

-------------------------------------
function sv_actor_hen:on_init()
	sv_actor_basic.on_init(self);
	actor_hen.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_hen = utils.inherit(cl_actor_basic, actor_hen);

function cl_actor_hen:on_init()
	cl_actor_basic.on_init(self);
	actor_hen.on_init(self);
end