------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Kulibin - дед NPC с уровня "Колхоз"
------------------------------------------------------------------------


---------------------------------------------------------------------------------
-- общая часть
actor_kulibin.guid = {0x984a5e28, 0x2500, 0x4d57, 0xba, 0x45, 0x44, 0xee, 0x20, 0x38, 0x4f, 0xfb};

function actor_kulibin:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_kulibin = utils.inherit(sv_actor_basic, actor_kulibin);

-------------------------------------
function sv_actor_kulibin:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
	
	-- входящие слоты
	self.in_begin_talk_slot = self:register_input_slot("begin_talk", self.begin_talk);
	self.in_dont_shoot_slot = self:register_input_slot("dont_shoot", self.dont_shoot);
	-- исходящие слоты
	self.out_give_key = self:register_output_slot("on_give_key", nil);

end

-------------------------------------
function sv_actor_kulibin:on_init(dreader)
	sv_actor_basic.on_init(self);
	actor_kulibin.on_init(self);

	self:set_property_value(self.m_block_movement_prop, true);
	self:set_property_value(self.m_block_turn_prop, true);

	self:set_property_value_by_name("enemies_objects", " ");
end

function sv_actor_kulibin:on_load_state(dreader)
	sv_actor_basic.on_load_state(self, dreader);
	
	-- если загружаемся из save
	if(self.io.talk_begin == true) then
		self:emit_signals(self.out_give_key);
		self:talk_is_over();
	end	
end



function sv_actor_kulibin:post_load_init()
	self:signal("freeze_carrier");
	self:signal("disable_shapes");
end

function sv_actor_kulibin:dont_shoot(sender, activator, input_data)
	if(self.talk_has_begun == nil) then
		self:reset_body_state();
		self:make_transition("dont_shoot");
	end
end
--[[
function sv_actor_kulibin:dont_shoot_end()
	if(self.talk_has_begun == nil) then
		self.m_in_transition = nil;
		self:reset_body_state();
	end
end
--]]

function sv_actor_kulibin:begin_talk(sender, activator, input_data)
	self.talk_has_begun = true;
	self.m_in_transition = nil;
	self:reset_body_state(true);
	self:make_transition("to_talk", nil, self.talk_start);
	--console.print("================== begin talk");
	self.io.talk_begin = true;
end


function sv_actor_kulibin:talk_start()
	self:make_transition("begin_talk", nil, self.talk_finishing);
	--self:talk_finishing();
	
	--console.print("================== talk start");
end

function sv_actor_kulibin:talk_finishing()
	self:emit_signals(self.out_give_key);
	self:make_transition("finish_talk", nil, self.talk_is_over);
	
	--console.print("================== talk finishing");
end

function sv_actor_kulibin:talk_is_over()
	self:set_update_enable(false);
	self:signal("destroy");
	
	
	--console.print("================== talk is_over");
end



---------------------------------------------------------------------------
-- клиентская
cl_actor_kulibin = utils.inherit(cl_actor_basic, actor_kulibin);

function cl_actor_kulibin:on_init()
	cl_actor_basic.on_init(self);
	actor_kulibin.on_init(self);
end