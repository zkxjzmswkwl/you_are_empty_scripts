------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Zhlob - монстр дорожный рабочий
------------------------------------------------------------------------


---------------------------------------------------------------------------------
-- общая часть
actor_zhlob.guid = {0xc8ff5a9a, 0x5225, 0x4686, 0xa0, 0x55, 0x9d, 0x56, 0xac, 0xc5, 0x74, 0xcc};

function actor_zhlob:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_zhlob = utils.inherit(sv_actor_basic, actor_zhlob);

-------------------------------------
function sv_actor_zhlob:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

-------------------------------------
function sv_actor_zhlob:on_init()
	sv_actor_basic.on_init(self);
	actor_zhlob.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_zhlob = utils.inherit(cl_actor_basic, actor_zhlob);

function cl_actor_zhlob:on_init()
	cl_actor_basic.on_init(self);
	actor_zhlob.on_init(self);
end