------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Nail - 
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_nail.guid = {0xc09b6b6d, 0x19f0, 0x469d, 0x83, 0x4b, 0x73, 0x47, 0x35, 0x3, 0xe8, 0x77};

------------------------------------
function actor_nail:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_nail = utils.inherit(sv_actor_basic, actor_nail);

------------------------------------
function sv_actor_nail:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end


------------------------------------
function sv_actor_nail:on_init()
	sv_actor_basic.on_init(self);
	actor_nail.on_init(self);
end


---------------------------------------------------------------------------
-- клиентская
cl_actor_nail = utils.inherit(cl_actor_basic, actor_nail);

------------------------------------
function cl_actor_nail:on_init()
	cl_actor_basic.on_init(self);
	actor_nail.on_init(self);
end