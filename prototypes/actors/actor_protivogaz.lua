------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Protivogaz - сборщик органов
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_protivogaz.guid = {0x297d1796, 0x4296, 0x4d5c, 0x91, 0xa1, 0x36, 0x7b, 0xad, 0xa, 0xba, 0x8e};

-------------------------------------
function actor_protivogaz:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_protivogaz = utils.inherit(sv_actor_basic, actor_protivogaz);

-------------------------------------
function sv_actor_protivogaz:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end
-------------------------------------
function sv_actor_protivogaz:on_init()
	sv_actor_basic.on_init(self);
	actor_protivogaz.on_init(self);
end
---------------------------------------------------------------------------
-- клиентская
cl_actor_protivogaz = utils.inherit(cl_actor_basic, actor_protivogaz);

-------------------------------------
function cl_actor_protivogaz:on_init()
	cl_actor_basic.on_init(self);
	actor_protivogaz.on_init(self);
end