------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Gomnoed - монстр плюющейся кислотой
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_gomnoed.guid = {0x7abea7a1, 0x35bf, 0x4a42, 0xbb, 0x49, 0x88, 0x51, 0xbc, 0x11, 0x50, 0xdd};

-------------------------------------
function actor_gomnoed:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_gomnoed = utils.inherit(sv_actor_basic, actor_gomnoed);

-------------------------------------
function sv_actor_gomnoed:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

-------------------------------------
function sv_actor_gomnoed:on_init()
	sv_actor_basic.on_init(self);
	actor_gomnoed.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_gomnoed = utils.inherit(cl_actor_basic, actor_gomnoed);

function cl_actor_gomnoed:on_init()
	cl_actor_basic.on_init(self);
	actor_gomnoed.on_init(self);
end