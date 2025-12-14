------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Prima - монстр прима
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть для актера
---------------------------------------------------------------------------------
actor_prima.guid = {0xfdfe5cdb, 0x7a23, 0x4d1c, 0x9c, 0xab, 0xf5, 0xd0, 0x30, 0x35, 0xec, 0x7f};

function actor_prima:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_prima = utils.inherit(sv_actor_basic, actor_prima);

function sv_actor_prima:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_prima:on_init()
	sv_actor_basic.on_init(self);
	actor_prima.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_prima = utils.inherit(cl_actor_basic, actor_prima);

function cl_actor_prima:on_init()
	cl_actor_basic.on_init(self);
	actor_prima.on_init(self);
end