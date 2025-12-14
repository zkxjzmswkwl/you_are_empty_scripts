------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Vodolaz - монстр водолаз
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_vodolaz.guid = {0xcb2aaa, 0xb40f, 0x44bd, 0x95, 0x7b, 0x8, 0x7d, 0x24, 0x5, 0xd, 0xc7};

function actor_vodolaz:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_vodolaz = utils.inherit(sv_actor_basic, actor_vodolaz);

function sv_actor_vodolaz:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_vodolaz:on_init()
	sv_actor_basic.on_init(self);
	actor_vodolaz.on_init(self);

end

---------------------------------------------------------------------------
-- клиентская
cl_actor_vodolaz = utils.inherit(cl_actor_basic, actor_vodolaz);

function cl_actor_vodolaz:on_init()
	cl_actor_basic.on_init(self);
	actor_vodolaz.on_init(self);
end