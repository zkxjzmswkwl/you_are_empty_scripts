------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Sniper - снайпер
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_sniper.guid = {0x7b5d7e2b, 0xded3, 0x4353, 0xbe, 0xfd, 0x2c, 0x59, 0x49, 0xf3, 0x6a, 0xb};

------------------------------------
function actor_sniper:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_sniper = utils.inherit(sv_actor_basic, actor_sniper);

------------------------------------
function sv_actor_sniper:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

------------------------------------
function sv_actor_sniper:on_init()
	sv_actor_basic.on_init(self);
	actor_sniper.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_sniper = utils.inherit(cl_actor_basic, actor_sniper);

------------------------------------
function cl_actor_sniper:on_init()
	cl_actor_basic.on_init(self);
	actor_sniper.on_init(self);
end