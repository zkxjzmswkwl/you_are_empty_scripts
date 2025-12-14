------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Karl - летающий монстр карлсон
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_karl.guid = {0x37c6e8ae, 0x2d84, 0x4422, 0xb0, 0x53, 0x79, 0xbd, 0xd9, 0xf0, 0xdd, 0xd8};

function actor_karl:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_karl = utils.inherit(sv_actor_basic, actor_karl);

function sv_actor_karl:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_karl:on_init()
	sv_actor_basic.on_init(self);
	actor_karl.on_init(self);
	-- чтобы монстр не убивался при прыжках с большой высоты	
	self:set_fall(1000, 0);
	
		
	if self:get_property_value_by_name("is_enabled") == true then
		self:on_inslot_enable()
	end
end


----------------------------------------
-- Обработка эффектов при enable/disable
----------------------------------------
function sv_actor_karl:on_inslot_disable(sender, activator, input_data)

	-- Выключаем все эффекты.
	if self.m_nozzle_effect then
		self:deactivate_effect(self.m_nozzle_effect)
	end
	
end

----------------------------------------
function sv_actor_karl:on_inslot_enable(sender, activator, input_data)
	
	-- Загружаем эффект горелки (только при первом enable)
	if self.m_nozzle_effect == nil then
		template_id = self:add_effect_template(self.params.nozzle_effect_name)
		effect_id = self:create_effect(template_id, self.m_model_body, self.params.nozzle_point)
		if effect_id == -1 then
			assert(nil, "cannot create effect: " .. self.params.nozzle_effect_name);
		else
			self.m_nozzle_effect = effect_id
		end
	end
	-- Включаем эффект горелки
	self:activate_effect(self.m_nozzle_effect)
end

----------------------------------------
function sv_actor_karl:on_shutdown()
	sv_actor_basic.on_shutdown(self);
	
	-- Освобождаем эффект
	if self.m_nozzle_effect then
		self:release_effect(self.m_nozzle_effect)
	end
end


---------------------------------------------------------------------------
-- клиентская
cl_actor_karl = utils.inherit(cl_actor_basic, actor_karl);

function cl_actor_karl:on_init()
	cl_actor_basic.on_init(self);
	actor_karl.on_init(self);
end