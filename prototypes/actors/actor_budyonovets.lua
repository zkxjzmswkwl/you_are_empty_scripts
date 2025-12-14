------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Budyonovets - солдат красной армии
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_budyonovets.guid = {0xf993fb1d, 0xfd60, 0x4160, 0xa4, 0x13, 0x5f, 0xf3, 0x74, 0x77, 0xd8, 0x90};

function actor_budyonovets:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_budyonovets = utils.inherit(sv_actor_basic, actor_budyonovets);

function sv_actor_budyonovets:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_budyonovets:on_init()
	sv_actor_basic.on_init(self);
	actor_budyonovets.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_budyonovets = utils.inherit(cl_actor_basic, actor_budyonovets);

function cl_actor_budyonovets:on_init()
	cl_actor_basic.on_init(self);
	actor_budyonovets.on_init(self);
end