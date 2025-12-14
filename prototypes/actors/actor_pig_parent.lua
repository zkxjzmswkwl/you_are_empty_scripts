------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Pig Parent - монстр свиноматка
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть

actor_pig_parent.guid = {0xdc68413d, 0x15f5, 0x41cf, 0xbc, 0xac, 0x5e, 0x5, 0xd5, 0x46, 0x16, 0x3b};

---------------------------------------------------------------------------
function actor_pig_parent:on_init()	
end

---------------------------------------------------------------------------
-- серверная часть 
sv_actor_pig_parent = utils.inherit(sv_actor_basic, actor_pig_parent);

---------------------------------------------------------------------------
function sv_actor_pig_parent:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_actor_pig_parent:on_init()
	sv_actor_basic.on_init(self);
	actor_pig.on_init(self);
end


function sv_actor_pig_parent:death_end()
	
	
	-- Создаем бомбу
	local bomb = engine.spawn_entity("Bomb")
	bomb:set_property_value_by_name("model_name", "svin")
	bomb:set_property_value_by_name("shape", "sphere")
	bomb:set_property_value_by_name("radius", 250)
	
	bomb:set_property_value_by_name("effect", "pfx_pig_expl.lua")
	bomb:set_property_value_by_name("debris_model", "pig_ragdoll")
	bomb:set_property_value_by_name("auto_fall_apart", true)
	bomb:set_property_value_by_name("debris_scattering", 300000)
	
	bomb:set_pos(self:get_pos())
	engine.add_entity_to_world(bomb)
	
	-- Взрываем бомбу
	bomb:signal("explode", self);


	sv_actor_basic.death_end(self);
end


function sv_actor_pig_parent:on_update_attack()
	if(self.io.m_attack_began == false) then
		self.io.m_attack_began = true;

		self:visualize_state(self.body_fsm, self.state_visual_info, 
				self.m_current_attack_info.visual_state_prefix.."_end", self.m_attack_selected_visual_idx);
		
		-- Самоубийство
		self:set_health(-1)
--[[
		-- Рожает поросенка
		local svin = engine.spawn_entity("actor_pig")
		local new_tm = self:get_offsetted_tm(self.m_current_attack_info.offset_pos)
		svin:set_tm(new_tm)
		engine.add_entity_to_world(svin)
		svin:post_load_init()
--]]

	else
		self.io.m_attack_ended  = true;
		self:reset_body_state();
	end
end

function sv_actor_pig_parent:on_death()
	sv_actor_basic.on_death(self)
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_pig_parent = utils.inherit(cl_actor_basic, actor_pig_parent);

function cl_actor_pig_parent:on_init()
	cl_actor_basic.on_init(self);
	actor_pig_parent.on_init(self);
end