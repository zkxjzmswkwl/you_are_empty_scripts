------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Stalevar - монстр сталевар
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_stalevar.guid = {0xe7c14435, 0x6c21, 0x4d42, 0xb1, 0x4, 0x54, 0x26, 0xd7, 0xb9, 0x48, 0x96};

-------------------------------------
function actor_stalevar:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_stalevar = utils.inherit(sv_actor_basic, actor_stalevar);

-------------------------------------
function sv_actor_stalevar:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

-------------------------------------
function sv_actor_stalevar:on_init()
	sv_actor_basic.on_init(self);
	actor_stalevar.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_stalevar = utils.inherit(cl_actor_basic, actor_stalevar);

function cl_actor_stalevar:on_init()
	cl_actor_basic.on_init(self);
	actor_stalevar.on_init(self);
end