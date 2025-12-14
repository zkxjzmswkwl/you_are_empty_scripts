------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Electro - монстр электрик
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть

actor_electro.guid = {0x86f27096, 0xaba6, 0x4b47, 0xb6, 0x30, 0x97, 0x7f, 0x80, 0x87, 0xb7, 0x4b};

function actor_electro:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_electro = utils.inherit(sv_actor_basic, actor_electro);

function sv_actor_electro:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_electro:on_init()
	sv_actor_basic.on_init(self);
	actor_electro.on_init(self);
end


function sv_actor_electro:on_enter_attack()
	sv_actor_basic.on_enter_attack(self);
	
	if(self.io.m_current_attack_idx == 1) then
	
		-- загружаем эффект выстрела (только при первом выстреле)
		if self.m_current_attack_info.effect_handle == nil then
			if self.m_current_attack_info.shoot_effect then
				self.effect_handle = self:load_shoot_effect(self.m_current_attack_info.shoot_effect);
			end
		end
		
		-- Отображаем эффект выстрела
		if self.m_current_attack_info.effect_handle then
			self:visualize_shoot_effect(self.m_current_attack_info.effect_handle);
		end

	end

end

function sv_actor_electro:on_update_attack()
	sv_actor_basic.on_update_attack(self);
end

----------------------------------------
function sv_actor_electro:on_exit_attack()
	sv_actor_basic.on_exit_attack(self)
	
	-- Выключаем эффект
	if(self.io.m_current_attack_idx == 1) then
		if self.m_current_attack_info.effect_handle then
			self:deactivate_shoot_effect(self.m_current_attack_info.effect_handle);
		end
	end	
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_electro = utils.inherit(cl_actor_basic, actor_electro);
	
function cl_actor_electro:on_init()
	cl_actor_basic.on_init(self);
	actor_electro.on_init(self);
end