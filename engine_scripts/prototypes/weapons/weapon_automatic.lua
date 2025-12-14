------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Базовый класс для автоматов
------------------------------------------------------------------------

---------------------------------------------------------------------------
weapon_automatic = {};

---------------------------------------------------------------------------
function weapon_automatic:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_automatic = utils.inherit(sv_weapon_firearm, weapon_automatic);

---------------------------------------------------------------------------
sv_weapon_automatic.m_sit_disp_k					= 0.5	-- коэффициент масштабирования разброса в режиме сидя
sv_weapon_automatic.m_sit_recoil_k					= 0.5	-- коэффициент масштабирования отдачи в режиме сидя
sv_weapon_automatic.m_last_shots_number				= 10	-- число учитываемых последних выстрелов
sv_weapon_automatic.m_one_shot_energy				= 50	-- энергия одного выстрела
sv_weapon_automatic.m_recoil_time_correction_k_min	= 0.5	-- минимальное значение коэффициента (1 - нет коррекции)
sv_weapon_automatic.m_recoil_time_correction_k_max	= 1.5	-- максимальное значение коэффициента
sv_weapon_automatic.m_disp_time_correction_k_min	= 0.5	-- минимальное значение коэффициента (1 - нет коррекции)
sv_weapon_automatic.m_disp_time_correction_k_max	= 1.5	-- максимальное значение коэффициента

---------------------------------------------------------------------------
function sv_weapon_automatic:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_automatic:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_automatic.on_init(self);

	self.m_need_to_stop_firing = false;
end

---------------------------------------------------------------------------
function sv_weapon_automatic:event_lever1_down()

	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if self:can_fire() then
		self.m_need_to_stop_firing = false;
		if(cur_state == self.fire_finish_state and self.m_need_switch_to_idle == true) then
			self.m_need_switch_to_idle = false;
			self:change_fsm_state(self.main_fsm, self.fire_state, true);
		end
	end
	sv_weapon_firearm.event_lever1_down(self);
end

---------------------------------------------------------------------------
function sv_weapon_automatic:event_lever2_down()
end


---------------------------------------------------------------------------
function sv_weapon_automatic:event_lever1_up()
	sv_weapon_firearm.event_lever1_up(self)
	local cur_state = self:get_fsm_state_name(self:get_cur_fsm_state(self.main_fsm));
	if cur_state == "fire_state" or cur_state == "fire_finish_state" then
		self.m_need_to_stop_firing = true;
	end
end

---------------------------------------------------------------------------
function sv_weapon_automatic:on_enter_fire_finish()
	sv_weapon_firearm.on_enter_fire_finish(self);

	if(self.m_shot_time ~= nil) then
		self:set_fsm_update_time(self.main_fsm, self.m_shot_time);
	end
end
   
---------------------------------------------------------------------------
function sv_weapon_automatic:on_update_fire_finish()
	if (self:can_fire() and self.m_need_to_stop_firing == false) then
		self:change_fsm_state(self.main_fsm, self.fire_state, true, true);
	else

		if(self.m_need_switch_to_idle == true) then
			self.m_need_to_stop_firing = false;
			self.m_need_switch_to_idle = false;
			sv_weapon_firearm.on_update_fire_finish(self);
		else
			local shot_time = 0;
			if(self.m_shot_time) then
				shot_time = self.m_shot_time;
			end
			self:set_fsm_update_time(self.main_fsm, self.m_current_anim_length - shot_time);
			self.m_need_switch_to_idle = true;
		end
	end
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_automatic = utils.inherit(cl_weapon_firearm, weapon_automatic);

function cl_weapon_automatic:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_automatic.on_init(self);
end
