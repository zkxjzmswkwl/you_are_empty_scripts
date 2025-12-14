------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Butcher - монстр мясник
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_butcher.guid = {0xbfa53e46, 0x4fd9, 0x412f, 0x9d, 0xb4, 0x11, 0xd, 0xe5, 0x41, 0x2, 0x77};

function actor_butcher:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_butcher = utils.inherit(sv_actor_basic, actor_butcher);

function sv_actor_butcher:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_butcher:on_init()
	sv_actor_basic.on_init(self);
	actor_butcher.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_butcher = utils.inherit(cl_actor_basic, actor_butcher);

function cl_actor_butcher:on_init()
	cl_actor_basic.on_init(self);
	actor_butcher.on_init(self);
end