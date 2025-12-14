------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- ai controller basic, скриптовое представление для базового актера.
------------------------------------------------------------------------

-------------------------------------------------------------------------------------
-- эвалуаторы для выбора стратегии поведения
-------------------------------------------------------------------------------------
function sv_ai_controller_basic:attack_evaluator()
	if(self:is_enemy_present() == true) then
		--if(self.io.m_attack_started == true) then
		--	return 10.0;
		--elseif(self.io.m_need_to_ignore_enemies == false) then
			return 1.0;
		--end	
	else
		return -1.0;
	end	
end

function sv_ai_controller_basic:wander_evaluator()
	return 0.0;
end

function sv_ai_controller_basic:guard_evaluator()
	
	if(self.m_guard_target ~= nil and self.m_guard_target:is_destroyed()) then
		self.m_guard_target = nil;
	end
	
	if(self.m_guard_target ~= nil) then
		if(self:dist_to_pos(self.m_guard_target:get_pos()) > self.m_guard_radius and
			self.io.m_attack_started == false) then
			if(self.m_guard_ignore_enemies == true or self:is_enemy_present() == false) then
				if(self.m_guard_time > 0  and (engine.get_game_time() - self.m_guard_begin_time) > self.m_guard_time) then
					self.m_guard_target = nil;
					return;
				else
					return 2.0;
				end
			end
		end	
	end
	return -1.0;
end


function sv_ai_controller_basic:relocate_evaluator()
--[[	
	self:evaluate_attack_anchors();

	if(self.io.m_need_to_relocate == true) then
		return 2.0;
	else
		return -1.0;
	end	
	--]]
	return -1.0;
end

-- опасность от которой можно только убегать
function sv_ai_controller_basic:flee_from_danger_evaluator()
	if(self:is_enemy_present() == true and
		self:is_enemy_insuperable_danger() == true) then
		
		if(self.m_owner.io.m_attack_started == true) then
			self.m_owner:halt_attack();
			return -1.0;
		else
			return 3.0;
		end	
	else
		return -1.0;
	end	

end