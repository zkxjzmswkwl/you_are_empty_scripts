------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Pig - монстр поросенок
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть

actor_pig.guid = {0x1f0f5bff, 0x58bd, 0x40e3, 0xa6, 0x3e, 0x87, 0xaa, 0xa, 0x7f, 0x68, 0x3b};

function actor_pig:on_init()	
end

------------------------------------
-- серверная часть 
sv_actor_pig = utils.inherit(sv_actor_basic, actor_pig);

function sv_actor_pig:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_pig:on_init()
	sv_actor_basic.on_init(self);
	actor_fireman.on_init(self);

end

---------------------------------------------------------------------------
-- клиентская
cl_actor_pig = utils.inherit(cl_actor_basic, actor_pig);

function cl_actor_pig:on_init()
	cl_actor_basic.on_init(self);
	actor_pig.on_init(self);
end