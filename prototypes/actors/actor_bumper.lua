------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Bumper - монстр катается по уровню и бодает игрока
------------------------------------------------------------------------


---------------------------------------------------------------------------------
-- общая часть
actor_bumper.guid = {0xbf8b904f, 0x78fc, 0x451e, 0x90, 0x45, 0x9a, 0x43, 0x21, 0x4c, 0xee, 0xb0};

-------------------------------------
function actor_bumper:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_bumper = utils.inherit(sv_actor_basic, actor_bumper);

-------------------------------------
function sv_actor_bumper:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

-------------------------------------
function sv_actor_bumper:on_init()
	sv_actor_basic.on_init(self);
	actor_bumper.on_init(self);
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_bumper = utils.inherit(cl_actor_basic, actor_bumper);

function cl_actor_bumper:on_init()
	cl_actor_basic.on_init(self);
	actor_bumper.on_init(self);
end