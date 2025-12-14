------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- ai controller attack, функции для атаки противника
------------------------------------------------------------------------

-------------------------------------------------------------------------------------
-- у актера может быть несколько видов атак
function sv_ai_controller_basic:read_attacks_params()

	-- таблица с описанием 
		
	local output_params = self:execute_action(ACTION_GET_ATTACK_PARAMS);
	if(output_params == nil) then return; end
	
	self.m_attack_infos = engine.data_stream_get_luaobject(output_params);

	for i,v in pairs(self.m_attack_infos) do

		local attack_info = v;
		attack_info.attack_id = i;
						
		-- дополнительный статус, который описывает как будет использоваться атака
		-- 0 - вкл., 1 - вкл. экслюзивно, 2 - выкл.
		attack_info.status = 0;
		
		attack_info.attacks_in_row = 0;
		attack_info.attacks_begin_time = 0;
		
		if(attack_info.type == ATTACK_MELEE) then
			attack_info.evaluator = self.attack_melee_evaluator;
		elseif(attack_info.type == ATTACK_JUMP) then
			attack_info.evaluator = self.attack_jump_evaluator;
			--attack_info.jump_height = engine.data_stream_get_float(output_params);
		elseif(attack_info.type == ATTACK_DISTANT) then
			attack_info.evaluator = self.attack_distant_evaluator;
		else
			assert(false, "unknown attack type!");
		end

		-- здесь запомним время когда последний раз была произведена атака
		attack_info.last_attack_time = 0;
	end
	data_stream_release(output_params);
		
	--assert(attack_index > 0, "no attacks available");

--[[
	local allowed_attacks = " +++++ read attack params";	
	for i,v in pairs(self.m_attack_infos) do 
			if(v.not_allowed ~= true) then
				allowed_attacks	= allowed_attacks..i;
			end	
	end
	console.print(allowed_attacks);
--]]

end
-------------------------------------------------------------------------------------

-- проверяет применимость атаки 
function sv_ai_controller_basic:general_attack_evaluator(info_index)

	local attack_info = self.m_attack_infos[info_index];
	
	if(attack_info.not_allowed == true) then
		return false;
	end
		
	if(attack_info.stop_during_attack == 0) then
		if(self.io.m_is_actor_movement_blocked == true) then
			return false;
		end	
	else
		if(self.io.stop_during_attack_allowed == false) then
			return false;
		end
	end
	
	
	-- выдержать паузу между атаки одного типа, если
	-- заданы соответствующие параметры
	if(attack_info.next_attack_time) then
		if(attack_info.attacks_in_row > 0) then
			if(engine.get_game_time() > attack_info.next_attack_time) then
				attack_info.attacks_in_row = 0;
			else
				return false;
			end
		end
	end
	--[[	
	if(attack_info.pause_between_attacks) then
	--console.print(" attack_info.attacks_in_row "..attack_info.attacks_in_row.."  attack_info.attacks_begin_time "..attack_info.attacks_begin_time);
		if(attack_info.attacks_in_row > 0) then
			if((engine.get_game_time() - attack_info.attacks_begin_time) > attack_info.pause_between_attacks) then
				attack_info.attacks_in_row = 0;
			else
				return false;
			end
		end
	end	
	--]]

	return true;
end


function sv_ai_controller_basic:attack_melee_evaluator(info_index)
	local attack_info = self.m_attack_infos[info_index];
	
	if(self:general_attack_evaluator(info_index) == false) then
		return -1.0;
	end
		

	local dist_to_enemy = self:dist_to_enemy();
	if(dist_to_enemy < attack_info.desired_max_dist) then
		if(dist_to_enemy >= attack_info.desired_min_dist) then
			if(dist_to_enemy >= attack_info.dist and
				self:cant_find_way_to_enemy()) then
				return 0.1;
			else
				return 1.0;
			end				
		else
			return 0.2;
		end
	else
		return 0.05;
	end	
end

-------------------------------------------------------------------------------------
function sv_ai_controller_basic:attack_jump_evaluator(info_index)
	local attack_info = self.m_attack_infos[info_index];
	
	if(self:general_attack_evaluator(info_index) == false) then
		return -1.0;
	end

	local dist_to_enemy = self:dist_to_enemy();
	
	if(self:vertical_dist_to_enemy() < attack_info.jump_height) then
		if(dist_to_enemy < attack_info.desired_max_dist) then
			if(dist_to_enemy >= attack_info.desired_min_dist) then
				return 1.0;
			else
				return 0.2;
			end
		else
			return 0.01;
		end	
	end
	return 0.0;
end
-------------------------------------------------------------------------------------
function sv_ai_controller_basic:attack_distant_evaluator(info_index)
	local attack_info = self.m_attack_infos[info_index];
	
	if(self:general_attack_evaluator(info_index) == false) then
		return -1.0;
	end

	
	local dist_to_enemy = self:dist_to_enemy();
	
	--if(self.io.m_last_attack_type == attack_info.type) then
	--	if (attack_info.attacks_in_row >= attack_info.attacks_in_row_allowed) then
	--		if((engine.get_game_time() - self.io.m_last_attack_time_end) >= 3000) then
	--			attack_info.attacks_in_row = 0;
	--		else
	--			return 0.01;
	--		end	
	--	end
	--end
	
	-- мы не можем двигаться и цель за пределами досягаемости
	if(self.io.m_is_actor_movement_blocked == true and 
		dist_to_enemy > attack_info.dist) then
			return 0.0;
	end	

	
	if((attack_info.critical_min_dist == nil or 
		dist_to_enemy > attack_info.critical_min_dist) and 
		dist_to_enemy < attack_info.desired_max_dist) then
		if(dist_to_enemy >= attack_info.desired_min_dist) then
			return 1.0;
		else
			return 0.2;
		end
	else
		return 0.0;
	end
end


function sv_ai_controller_basic:update_current_attack()
	if(self.m_reloading == true) then return; end
	
	local attack_info = self.m_attack_infos[self.io.m_last_selected_attack];
	
	if(attack_info.stop_during_attack == 1 or
		self:yaw_to_enemy() > attack_info.max_angle) then
		self:actor_stop();
		self:turn_to_enemy();
	end
end

-------------------------------------------------------------------------------------
function sv_ai_controller_basic:process_attack(dt)
	--do return end
	
	-- выбрать наиболее подходящую атаку
	local selected_attack = nil;
	local max_desire = 0;
	
	if(self.io.m_attack_started ~= true) then
		for i,v in pairs(self.m_attack_infos) do
			-- атака включена эксклюзивно
			if(self.m_attack_infos[i].status == 1) then
				selected_attack = i;
				break;
			-- атака выключена
			elseif(self.m_attack_infos[i].status == 2) then
				continue;
			end
				
			local cur_desire = v.evaluator(self, i);
			
			--if(cur_desire > -1) then
			--	local cur_priority = self.m_attack_infos[i].priority and self.m_attack_infos[i].priority or 0;
			--	console.print(self.m_actor:get_name().." attack "..i.." desire "..cur_desire.." max_desire "..max_desire.." cur priority "..cur_priority);
			--end	
			
			if(cur_desire > max_desire) then
				max_desire = cur_desire;
				selected_attack = i;
			elseif(cur_desire == max_desire) then
				local selected_priority = self.m_attack_infos[selected_attack].priority and self.m_attack_infos[selected_attack].priority or 0;
				local cur_priority = self.m_attack_infos[i].priority and self.m_attack_infos[i].priority or 0;
				if(selected_priority < cur_priority) then
					selected_attack = i;
				end	
			end
		end
	else
		selected_attack = self.io.m_last_selected_attack;
		max_desire = 1;
	end	
	
	--assert(selected_attack ~= -1, "no attack selected!");
	if(selected_attack == nil or max_desire < 0) then return end
	
	local attack_info = self.m_attack_infos[selected_attack];
	
	if(attack_info.not_allowed == true) then 
		--engine.warning(" ==========   attack_info.not_allowed but selected "..selected_attack);
		return 
	end
	
	self.io.m_last_selected_attack = selected_attack;
	
	--console.print(" ========== self.io.m_last_selected_attack "..self.io.m_last_selected_attack);
	--console.print(" ===================== cur has_attacked "..(self.io.m_attack_started and "true" or "false"));
	
	if(attack_info.turn_body_to_enemy == 1) then
		self.m_actor:set_property_value(self.m_actor.turn_body_to_entity_with_id_prop, self:get_enemy_id());
	else
		self.m_actor:set_property_value(self.m_actor.turn_body_to_entity_with_id_prop, -1);
	end
	
	--console.print(" self:is_enemy_visible() "..(self:is_enemy_visible() and " true " or " false "));
	--console.print(" self:is_enemy_shootable() "..(self:is_enemy_shootable() and " true " or " false "));
	--console.print(" self:is_enemy_in_fov() "..(self:is_enemy_in_fov() and " true " or " false "));
	--console.print(" self:dist_to_enemy() "..self:dist_to_enemy().." yaw "..self:yaw_to_enemy().."   "..attack_info.max_angle);
	
	------------------------------------------------
	if(self.io.m_attack_started == true) then
		--console.print(" self.io.m_attack_started == true ");
		self:update_current_attack();
	elseif((self:is_blind_attack_allowed() == true or self:is_enemy_visible()) and
		(self:dist_to_enemy() < attack_info.dist)) then
		
		--console.print(" self:dist_to_enemy() "..self:dist_to_enemy().." yaw "..self:yaw_to_enemy().."   "..attack_info.max_angle);

		--if(attack_info.stop_during_attack == 1) then
		--	self:actor_stop();
		--end
		
		if(self.io.m_need_to_relocate_after_attack ~= true and
			self.io.m_attack_started == false and	
			self:yaw_to_enemy() < attack_info.max_angle) then
			
			--if(attack_info.type ~= ATTACK_MELEE) then
			--self:block_movement(true);
			--end
			
			--console.print(" ==========  !!!   sv_ai_controller_basic:process_attack      +++  attack "..attack_info.attack_id);
			
			local input_params = data_stream();
			engine.data_stream_load(input_params, 
				actor.get_action_input_types(ACTION_ATTACK), self:get_enemy_id(), attack_info.attack_id);
			local output_params = self:execute_action(ACTION_ATTACK, input_params);
			data_stream_release(input_params);
			
			
			assert(output_params ~= nil);
			self.io.m_attack_started = engine.data_stream_parse(output_params, actor.get_action_output_types(ACTION_ATTACK));
			--console.print(" sv_ai_controller_basic:process_attack(dt) "..attack_info.attack_id.." self.io.m_attack_started "..(self.io.m_attack_started and "true" or "false"));
		end
	end
end

-- остановка выполняемой атаки
function sv_ai_controller_basic:halt_attack()

	if(self.io.m_attack_started == true and self.m_reloading ~= true) then
		local input_params = data_stream();
		engine.data_stream_load(input_params, 
			actor.get_action_input_types(ACTION_ATTACK), 0, "halt_attack");
		local output_params = self:execute_action(ACTION_ATTACK, input_params);
		data_stream_release(input_params);
	end	
end