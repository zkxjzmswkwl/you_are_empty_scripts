------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Worker - рабочий с молотом - "Рамштайн"
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_worker.guid = {0x39a141db, 0xbc68, 0x4769, 0xb9, 0x12, 0xf8, 0x4, 0xa9, 0xe8, 0x9, 0x8a};

function actor_worker:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_worker = utils.inherit(sv_actor_basic, actor_worker);

function sv_actor_worker:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_worker:on_init()
	sv_actor_basic.on_init(self);
	actor_worker.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_worker = utils.inherit(cl_actor_basic, actor_worker);

function cl_actor_worker:on_init()
	cl_actor_basic.on_init(self);
	actor_worker.on_init(self);
end