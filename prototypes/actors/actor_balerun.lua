------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Balerun - NPC балерун
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_balerun.guid = {0xfc215dfe, 0x7332, 0x4ea9, 0x91, 0x3, 0x70, 0x2c, 0x93, 0x4a, 0xd, 0xdf};

function actor_balerun:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_balerun = utils.inherit(sv_actor_basic, actor_balerun);

-------------------------------------
function sv_actor_balerun:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

-------------------------------------
function sv_actor_balerun:on_init()
	sv_actor_basic.on_init(self);
	actor_balerun.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_balerun = utils.inherit(cl_actor_basic, actor_balerun);

function cl_actor_balerun:on_init()
	cl_actor_basic.on_init(self);
	actor_balerun.on_init(self);
end