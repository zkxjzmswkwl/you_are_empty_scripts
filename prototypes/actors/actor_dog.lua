------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Dog - монстр собака
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть

actor_dog.guid = {0x716095f2, 0xf372, 0x4eec, 0x9c, 0xcd, 0x8e, 0xa9, 0x1a, 0xb1, 0x5f, 0xa9};


function actor_dog:on_init()	
end

------------------------------------
-- серверная часть 
sv_actor_dog = utils.inherit(sv_actor_basic, actor_dog);

function sv_actor_dog:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_dog:on_init()
	sv_actor_basic.on_init(self);
	actor_dog.on_init(self);

end

---------------------------------------------------------------------------
-- клиентская
cl_actor_dog = utils.inherit(cl_actor_basic, actor_dog);

function cl_actor_dog:on_init()
	cl_actor_basic.on_init(self);
	actor_dog.on_init(self);
end