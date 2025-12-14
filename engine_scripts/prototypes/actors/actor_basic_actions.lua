------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Описание actions - действий, выполняемых по запросу присоединенного
-- контроллера
------------------------------------------------------------------------

-------------------------------------
-- ACTION_MOVE действие передвижения
-------------------------------------
function sv_actor_basic:action_move(id, input_params, output_params)

	forward, backward, left, right, up, down, acceleration, deceleration = engine.data_stream_parse(input_params, actor.get_action_input_types(id));

	self.m_forward = forward;
	self.m_backward = backward;
	self.m_left = left;
	self.m_right = right;
	self.m_up = up;
	self.m_down = down;
	self.m_acceleration = self:get_property_value(self.m_allow_run) and acceleration or 0;
	self.m_deceleration = deceleration;
	

	----------------------------------------
--[[
	if(forward == 1) then
		if(self.m_acceleration == 1) then
			self.m_action_move_speed = self:get_property_value(self.run_forward_speed_prop);
		else
			self.m_action_move_speed = self:get_property_value(self.walk_forward_speed_prop);
		end
	elseif(backward == 1) then
		if(self.m_acceleration == 1) then
			self.m_action_move_speed = self:get_property_value(self.run_backward_speed_prop);
		else
			self.m_action_move_speed = self:get_property_value(self.walk_backward_speed_prop);
		end
	elseif(left == 1 or right == 1) then
		if(self.m_acceleration == 1) then
			self.m_action_move_speed = self:get_property_value(self.run_strafe_speed_prop);
		else
			self.m_action_move_speed = self:get_property_value(self.walk_strafe_speed_prop);
		end
	end
	--]]
end

-------------------------------------
-- ACTION_ATTACK действие атаки
-------------------------------------
function sv_actor_basic:action_attack(id, input_params, output_params)
	target_id, attack_type = engine.data_stream_parse(input_params, actor.get_action_input_types(id));
	
	-- текущая атака должна быть завершена
	if(attack_type == "halt_attack") then
		self:halt_attack();
		engine.data_stream_load(output_params, actor.get_action_output_types(id), false);
		--console.print(" ========== halt attack");
		return;
	end
	
	-- для игрока, получаем команды от кнопок мыши
	if(self:is_player_controlled()) then
		if(attack_type == ATTACK_PRIMARY) then
			if(self.params.attack_info[0] == nil) then
				local idx, value = next(self.params.attack_info);
				attack_type = idx;
			else
				attack_type = 0;
			end	
		elseif(attack_type == ATTACK_SECONDARY) then
			if(self.params.attack_info[1] == nil) then
				local idx1, value1 = next(self.params.attack_info);
				local idx2, value2 = next(self.params.attack_info, idx1);
				attack_type = idx2;
			else
				attack_type = 1;
			end	
		else
			return;
		end
		if(attack_type == nil) then return end
	end
	

	local attack_result = false;

	if(self.m_in_transition ~= true and
		 self:is_attack_began() == false and 
		self.io.m_wait_for_requested_attack ~= true) then
	
		local attack_info = self.params.attack_info[attack_type]; 
		local cur_state = self:get_cur_fsm_state(self.body_fsm);
		assert(attack_info, " incorrect attack id "..attack_type.."!");
	
		local attack_allowed = false;
		local bhv_state = self:get_behavior_state();
		for i,v in ipairs(attack_info.allowed_bhv) do
			if(bhv_state == v) then 
				attack_allowed = true;
				break;
			end
		end	
		
		
		if(attack_allowed == true and cur_state ~= self.reload_state) then
			self.io.m_requested_attack_idx = attack_type;
			self.io.m_wait_for_requested_attack = true;
		
			self.m_attack_target_id = target_id;
			
			local state = self:get_cur_fsm_state(self.body_fsm);
			local name = self:get_fsm_state_name(state);
			--console.print(" ========== ATTACK BEGIN sv_actor_basic:action_attack cur_state "..name.."  attack__idx "..self.io.m_requested_attack_idx);
			
			self:change_fsm_state(self.body_fsm, attack_info.fsm_state_ref, false);
		
			attack_result = true;
		end
	end	
		
	engine.data_stream_load(output_params, actor.get_action_output_types(id), attack_result);
end

function sv_actor_basic:attack_primary(target_id)
	self.m_attack_type = ATTACK_PRIMARY;
	local bhv_state = self:get_behavior_state();	
	if(bhv_state == BHV_WALK or bhv_state == BHV_STAND) then
		self.m_attack_target_id = target_id;
		self:change_fsm_state(self.body_fsm, self.attack_state, false);
	end
end

function sv_actor_basic:attack_secondary(target_id)
	self.m_attack_type = ATTACK_SECONDARY;
end


-------------------------------------
-- ACTION_ALERT
-------------------------------------
function sv_actor_basic:action_alert(id, input_params, output_params)
	target_id, info = engine.data_stream_parse(input_params, actor.get_action_input_types(id));
	
	local enemy = nil;
	
	if(target_id == 0) then
		-- we have no enemy any more
		--console.print("===== we '"..self:get_name().."'have no enemy any more")
	else
		enemy = engine.get_entity_by_id(target_id)
		self:emit_signals(self.out_alert, enemy);
		--console.print("===== we '"..self:get_name().."' have an enemy!!! "..enemy:get_name());
	end	
	
	self:set_idle("idle_alert", self.params.aggresive_stance_time)
	
	-- Переход в агрессивное состояние
	local custom_trans_to_alert_state_name = self:get_property_value(self.m_custom_transition_to_alert_prop);
	if(custom_trans_to_alert_state_name == "?" or custom_trans_to_alert_state_name == " " or custom_trans_to_alert_state_name == "") then
		self:set_property_value(self.m_stop_during_transition_to_alert_prop, false);
		if(self.state_visual_info["transition_to_alert"]) then
			-- устанавливаем activator, тем самым эмулируем
			-- крик от врага а не от самих себя, для того чтоб наши
			-- союзники тоже узнали о существовании врага
			self.m_ai_sound_activator = target_id;

			if(self.state_visual_info["transition_to_alert"].without_anims == true) then
				self:visualize_state(nil, self.state_visual_info, "transition_to_alert", nil, nil, IGNORE_TRANSITION);
			else
				self:transition_to_alert_begin();
				self:make_transition("transition_to_alert", nil, self.transition_to_alert_end);
			end	
		else
			self:transition_to_alert_end();
		end
	else
		self:transition_to_alert_begin();
		self:make_transition(custom_trans_to_alert_state_name, nil, self.transition_to_alert_end);
	end
end

function sv_actor_basic:transition_to_alert_begin()
	if(self:get_property_value(self.m_stop_during_transition_to_alert_prop) == true) then
		self.io.m_block_movement = true;
		self:block_carrier_movement(true);
		self:block_carrier_turn(true);
		self:stop_movement();
	end	
end

function sv_actor_basic:transition_to_alert_end()

	self:set_property_value(self.m_custom_idle_prop, "?");
	self:set_property_value(self.m_custom_transition_to_alert_prop, "?");
	
	self.io.m_in_custom_idle = nil;
	
	self:set_idle("idle_alert", self.params.aggresive_stance_time);
	
	if(self:get_property_value(self.m_stop_during_transition_to_alert_prop) == true) then
		self:block_carrier_movement(false);
		self:block_carrier_turn(false);
		self.io.m_block_movement = false;
	end	
	
	self:signal("enable_carrier", self);
	self:signal("unfreeze_carrier", self);
end

-------------------------------------
-- ACTION_RELOAD
-------------------------------------
function sv_actor_basic:action_reload(id, input_params, output_params)
	
	if(self.io.m_current_clip_size > 0) then return end
	
	self:end_attack();

	--console.print("================== ACTION RELOAD");
	if(self.state_visual_info["reload"] == nil) then
		return;
	end
	
	local bhv_state = self:get_behavior_state();
	local cur_state = self:get_cur_fsm_state(self.body_fsm);
	
	if(cur_state ~= self.reload_state and 
		(bhv_state == BHV_WALK or bhv_state == BHV_STAND)) then
		self:change_fsm_state(self.body_fsm, self.reload_state, false);
	end
end


-------------------------------------
-- ACTION_GET_ATTACK_PARAMS - параметры допустимых атак у актера 
-------------------------------------
function sv_actor_basic:action_get_attack_params(id, input_params, output_params)
	engine.data_stream_load(output_params, actor.get_action_output_types(id), self.params.attack_info);
end