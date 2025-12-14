------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Madman - монстр псих.больной
------------------------------------------------------------------------


---------------------------------------------------------------------------------
-- общая часть
actor_madman.guid = {0x5a22d68c, 0x8382, 0x456d, 0x8c, 0x61, 0x77, 0xa1, 0x4d, 0x30, 0xc9, 0x76};

function actor_madman:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_madman = utils.inherit(sv_actor_basic, actor_madman);

function sv_actor_madman:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_madman:on_init()
	sv_actor_basic.on_init(self);
	actor_madman.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_madman = utils.inherit(cl_actor_basic, actor_madman);

function cl_actor_madman:on_init()
	cl_actor_basic.on_init(self);
	actor_madman.on_init(self);
end