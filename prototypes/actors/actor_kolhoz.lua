------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Kolhoz - колхозница с серпом
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_kolhoz.guid = {0xb9409c33, 0x6eb8, 0x4b49, 0xb5, 0x96, 0xac, 0x9, 0x7e, 0x55, 0xca, 0x80};

function actor_kolhoz:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_kolhoz = utils.inherit(sv_actor_basic, actor_kolhoz);

function sv_actor_kolhoz:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_kolhoz:on_init()
	sv_actor_basic.on_init(self);
	actor_kolhoz.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_kolhoz = utils.inherit(cl_actor_basic, actor_kolhoz);

function cl_actor_kolhoz:on_init()
	cl_actor_basic.on_init(self);
	actor_kolhoz.on_init(self);
end