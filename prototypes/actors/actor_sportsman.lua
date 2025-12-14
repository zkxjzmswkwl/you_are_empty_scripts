------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Sportsman - монстр спортсмен
------------------------------------------------------------------------


---------------------------------------------------------------------------------
-- общая часть
actor_sportsman.guid = {0x63fa7cfa, 0x397c, 0x4516, 0xb3, 0xfd, 0x4e, 0x94, 0xd2, 0x19, 0x3, 0xe0};

function actor_sportsman:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_sportsman = utils.inherit(sv_actor_basic, actor_sportsman);

-------------------------------------
function sv_actor_sportsman:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

-------------------------------------
function sv_actor_sportsman:on_init()
	sv_actor_basic.on_init(self);
	actor_sportsman.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_sportsman = utils.inherit(cl_actor_basic, actor_sportsman);

function cl_actor_sportsman:on_init()
	cl_actor_basic.on_init(self);
	actor_sportsman.on_init(self);
end