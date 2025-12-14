------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev, Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Moto - солдат в мотоциклетных очках
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- обща€ часть
actor_moto.guid = {0x42088bd5, 0x9402, 0x493f, 0x8e, 0x2f, 0x2a, 0x40, 0xcf, 0x94, 0xdd, 0xfb};

------------------------------------
function actor_moto:on_init()
end

------------------------------------
-- серверна€ часть 
sv_actor_moto = utils.inherit(sv_actor_basic, actor_moto);

------------------------------------
function sv_actor_moto:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end


------------------------------------
function sv_actor_moto:on_init()
	sv_actor_basic.on_init(self);
	actor_moto.on_init(self);
end

-------------------------------------
-- ATTACK SHOT RUN
-------------------------------------
function sv_actor_moto:on_enter_attack_shot_run()
	-- ¬стаем, если сидим
	if self.m_is_sitting then
		self:change_fsm_state(self.body_fsm, self.transition_state, true);
		return
	end
	
	sv_actor_basic.on_enter_attack_shot_run(self)
end


---------------------------------------------------------------------------
-- клиентска€
cl_actor_moto = utils.inherit(cl_actor_basic, actor_moto);

------------------------------------
function cl_actor_moto:on_init()
	cl_actor_basic.on_init(self);
	actor_moto.on_init(self);
end


-------------------------------
-- чтоб из консоли можно было добавл€ть себе друзей
-------------------------------
friend_moto = {
    classname = "actor_moto",
    props = {
        enemies_classes = " ",
        enemies_objects = "$ai_controlled_actors",
        enemies_skip_objects = " ",

        human_friendly = true,
        health = 100,
        armor = 0,
        is_enabled = true,
        allow_run = true,
        allowed_attacks = " ",
        disallowed_attacks = " ",
    },
};