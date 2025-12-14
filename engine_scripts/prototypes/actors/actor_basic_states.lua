------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- описание состояний FSM Actor Basic
------------------------------------------------------------------------

-- запустить анимацию и звук, только на ноги
function sv_actor_basic:visualize_state_legs(states_visual_info_table, state_name, visual_idx, transition_status)
	
	local cur_body_state = self:get_cur_fsm_state(self.body_fsm);
	local bone_group = self.m_legs_bones;
	if(cur_body_state == self.empty_body_state or 
		cur_body_state == self.idle_state) then
		--console.print(" == [sv_actor_basic:visualize_state_legs] bone_group = nil")
		bone_group = nil --BODY_BONE_GROUP;
	end
	
	return self:visualize_state(self.legs_fsm, states_visual_info_table, state_name, visual_idx, bone_group, transition_status);
end

-- запустить анимацию и звук, только на тело
function sv_actor_basic:visualize_state_torso(states_visual_info_table, state_name, visual_idx, transition_status)
	local bone_group = nil;
	local cur_legs_state = self:get_cur_fsm_state(self.legs_fsm);
	if(cur_legs_state ~= self.empty_legs_state) then
		bone_group = self.m_torso_bones;
	end
	self.last_torso_state = state_name;
	return self:visualize_state(self.body_fsm, states_visual_info_table, state_name, visual_idx, bone_group, transition_status);
end


-------------------------------------
-- EMPTY
-------------------------------------
function sv_actor_basic:on_enter_empty_body()

	if(self.empty_without_anim ~= true) then
	
		-- переводим тело в 1й кадр положения idle
		local visual_idx, anim_length, anim_idx =
			self:visualize_state(self.body_fsm, self.state_visual_info, self.m_cur_idle_name, 1, self.m_torso_bones);

--		self:stop_animation(anim_idx);
    else
		self.empty_without_anim = nil;
	end
					
	self:set_fsm_update_time(self.body_fsm, 0);

end

function sv_actor_basic:on_enter_empty_legs()
	if(self.m_legs_anim_idx) then
		
		self:stop_animation(self.m_legs_anim_idx);
		self.m_legs_anim_idx = nil;
		
		self.m_dont_visualize_sound = true;
		-- переводим ноги в 1й кадр положения idle
		local visual_idx, anim_length, anim_idx =
			self:visualize_state(self.legs_fsm, self.state_visual_info, 
				self.m_cur_idle_name, 1, self.m_legs_bones);
		self:stop_animation(anim_idx);
	end
	self:set_fsm_update_time(self.legs_fsm, 0);
end

-------------------------------------
-- IDLE
-------------------------------------
function sv_actor_basic:on_enter_idle()

	self:end_attack();
	self:reset_legs_state();

	local custom_idle_state_name = self:get_property_value(self.m_custom_idle_prop);
	if(custom_idle_state_name == "?" or custom_idle_state_name == " " or custom_idle_state_name == "") then
		if(self:is_sitting()) then
			self:visualize_state(self.body_fsm, self.state_visual_info, "idle_sit");
		else
			self:visualize_state(self.body_fsm, self.state_visual_info, self.m_cur_idle_name);
		end	
	else
		self:visualize_state(self.body_fsm, self.state_visual_info, custom_idle_state_name);
	end		
	
end

function sv_actor_basic:on_update_idle()
	--console.print(" ================= on_update_idle")

	self:change_fsm_state(self.body_fsm, self.idle_state, false);
	self:send_callback(CALLBACK_ANIM_END);

end

-------------------------------------
-- PAIN
-------------------------------------
function sv_actor_basic:on_enter_pain()
		
		self.m_pain_finished = false;
			
		--console.print(" ------------------ CALLBACK_ANIM_END");
		self:send_callback(CALLBACK_ANIM_END);
		
		--console.print(" ------------------ function sv_actor_basic:on_enter_pain()");
		
		-- для того чтоб сказать контроллеру, что аттака еще не начавшись
		-- прервана анимацией боли
		--if(self.io.m_wait_for_requested_attack == true) then
		--self:send_callback(CALLBACK_ACTION_END, ACTION_ATTACK);
		--self.io.m_wait_for_requested_attack = false;
		self:end_attack();
		--end
		
		if(self.params.pain_for_full_body == true) then
			self.io.m_block_movement = true;
			self:stop_movement();
			self:reset_legs_state();
			self:visualize_state(self.body_fsm, self.state_visual_info, "pain");
		else
			self:visualize_state_torso(self.state_visual_info, "pain");
		end
		
		self:set_idle("idle_alert", self.params.aggresive_stance_time);
end

function sv_actor_basic:on_update_pain()
	self.io.m_block_movement = false;
	self.m_pain_finished = true;
	self:end_attack();
	self:reset_body_state();
end

function sv_actor_basic:is_finished_pain()
	return self.m_pain_finished;
end

-------------------------------------
-- DEATH
-------------------------------------
function sv_actor_basic:on_enter_death()
	self.m_death_finished = false;
	self.io.m_block_movement = true;
	self:stop_movement();
			
	self:visualize_state(self.body_fsm, self.state_visual_info, "death");
end

function sv_actor_basic:on_update_death()
	self.m_death_finished = true;
	self:reset_body_state();
end

function sv_actor_basic:is_finished_death()
	return false;
end


-------------------------------------
-- WALK
-------------------------------------
function sv_actor_basic:begin_walk(anim_length, anim_idx)
	
	if(self.m_legs_anim_idx and anim_idx ~= self.m_legs_anim_idx) then
		self:stop_animation(self.m_legs_anim_idx);
	end	

	self.m_legs_anim_idx = anim_idx;
	self.m_legs_walk = true;
	if(self.m_legs_anim_time_percent) then
		self:set_animation_time(anim_idx, self.m_legs_anim_time_percent * anim_length);
		self.m_legs_anim_time_percent = nil;
	end
end

function sv_actor_basic:end_walk(anim_length, anim_idx)
	self.m_legs_walk = false;
end

-- если в анимации задействованны и ноги, то
-- нужно это запоминать
function sv_actor_basic:set_legs_busy(is_busy)
	self.m_legs_busy = is_busy;
end

function sv_actor_basic:is_legs_busy()
	return self.m_legs_busy;
end



-- FORWARD WALK
function sv_actor_basic:on_enter_forward_walk()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "forward_walk");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_forward_walk()
	self:change_fsm_state(self.legs_fsm, self.forward_walk_state, false);
end
function sv_actor_basic:on_exit_forward_walk()
	self:end_walk();
end

-- BACKWARD WALK
function sv_actor_basic:on_enter_backward_walk()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "backward_walk");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_backward_walk()
	self:change_fsm_state(self.legs_fsm, self.backward_walk_state, false);
end
function sv_actor_basic:on_exit_backward_walk()
	self:end_walk();
end

-- STRAFE LEFT WALK
function sv_actor_basic:on_enter_strafe_left_walk()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "strafe_left_walk");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_strafe_left_walk()
	self:change_fsm_state(self.legs_fsm, self.strafe_left_walk_state, false);
end
function sv_actor_basic:on_exit_strafe_left_walk()
	self:end_walk();
end

-- STRAFE RIGHT WALK
function sv_actor_basic:on_enter_strafe_right_walk()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "strafe_right_walk");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_strafe_right_walk()
	self:change_fsm_state(self.legs_fsm, self.strafe_right_walk_state, false);
end
function sv_actor_basic:on_exit_strafe_right_walk()
	self:end_walk();
end


-------------------------------------
-- RUN
-------------------------------------
-- FORWARD RUN
function sv_actor_basic:on_enter_forward_run()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "forward_run");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_forward_run()
	self:change_fsm_state(self.legs_fsm, self.forward_run_state, false);
end
function sv_actor_basic:on_exit_forward_run()
	self:end_walk();
end

-- BACKWARD RUN
function sv_actor_basic:on_enter_backward_run()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "backward_run");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_backward_run()
	self:change_fsm_state(self.legs_fsm, self.backward_run_state, false);
end
function sv_actor_basic:on_exit_backward_run()
	self:end_walk();
end

-- STRAFE LEFT RUN
function sv_actor_basic:on_enter_strafe_left_run()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "strafe_left_run");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_strafe_left_run()
	self:change_fsm_state(self.legs_fsm, self.strafe_left_run_state, false);
end
function sv_actor_basic:on_exit_strafe_left_run()
	self:end_walk();
end

-- STRAFE RIGHT RUN
function sv_actor_basic:on_enter_strafe_right_run()
	local visual_idx, anim_length, anim_idx = self:visualize_state_legs(self.state_visual_info, "strafe_right_run");
	self:begin_walk(anim_length, anim_idx);
end
function sv_actor_basic:on_update_strafe_right_run()
	self:change_fsm_state(self.legs_fsm, self.strafe_right_run_state, false);
end
function sv_actor_basic:on_exit_strafe_right_run()
	self:end_walk();
end

-------------------------------------
-- JUMP 
-------------------------------------
function sv_actor_basic:is_jumping()
	return (self.m_jump_began == true);
end

function sv_actor_basic:begin_jump(fall_state, land_state)
	--console.print(" begin jump")
	self.m_jump_began = true;
	self.m_jump_fall_state = fall_state;
	self.m_jump_land_state = land_state;
	self.io.m_ready_to_fall = true;
end

function sv_actor_basic:finish_jump(fall_state, land_state)
	self.m_jump_began = nil;
	self.m_jump_fall_state = nil;
	self.m_jump_land_state = nil;
	self.io.m_ready_to_fall = nil;
		
	--console.print(" jump finished")
end

function sv_actor_basic:on_enter_jump()
		
	--console.print( " ============== on_enter_jump");
	--utils.traceback();
	--console.print( " ========================");
	
	if(self:get_behavior_state() == BHV_WALK) then
		
		self.io.m_block_movement = true;
		self.m_performed_up = 1;
		
		self.io.m_jump_prepared = true;
		-- анимация начала прыжка
		self:reset_legs_state();
		self:visualize_state(self.body_fsm, self.state_visual_info, "jump_begin");
		
		self:begin_jump(self.fall_state, self.land_state);
		
	elseif(self:get_behavior_state() == BHV_STAND) then
		self.io.m_jump_prepared = false;
		-- анимация подготовки к прыжку
		self:reset_legs_state();
		self:visualize_state(self.body_fsm, self.state_visual_info, "jump_prepare");
	end
end

function sv_actor_basic:on_update_jump()
	if(self.io.m_jump_prepared == false) then
		self.io.m_jump_prepared = true;
	
		-- анимация начала прыжка
		self:visualize_state(self.body_fsm, self.state_visual_info, "jump_begin");
		
		-- команда, которая передается физическому carrier-у
		self.io.m_block_movement = true;
		self.m_performed_up = 1;
		
		self:begin_jump(self.fall_state, self.land_state);
	else
		--console.print("================== jump to FALL ");
		self.io.m_block_movement = false;
		self.m_performed_up = 0;
--		self.io.m_ready_to_fall = true;
--		self:set_fsm_update_time(self.body_fsm, 0);
-- [[		
		local bhv_state = self:get_behavior_state();	
		if(bhv_state == BHV_JUMP or bhv_state == BHV_FALL) then
			self:change_fsm_state(self.body_fsm, self.fall_state, false);
		else
			self:finish_jump();
			self:reset_body_state();
		end	
		--]]
	end
end

-------------------------------------
-- FALL 
-------------------------------------
function sv_actor_basic:on_enter_fall()
	--console.print("================== fALL begin ");
	self:visualize_state(self.body_fsm, self.state_visual_info, "fall");
	--self:reset_legs_state();
end

function sv_actor_basic:on_update_fall()
	--console.print("================== fALL update ");
	self:change_fsm_state(self.body_fsm, self.fall_state, false);
end

-------------------------------------
-- LAND
-------------------------------------
function sv_actor_basic:on_enter_land()
	--console.print(" ===================== sv_actor_basic:on_enter_land()")
	--utils.traceback();
	--console.print(" =====================")

	self.io.m_block_movement = true;
	self.io.m_landing_complete = false;
	
	if(self.m_forward == 1 and  self.m_acceleration == 1) then
		-- если после приземления мы продолжаем бежать вперед
		self:visualize_state(self.body_fsm, self.state_visual_info, "land_run");
	else
		-- в любом другом случаем мы останавливаемся и отыгрываем анимацию
		-- приземления
		self:stop_movement();
	
		self:visualize_state(self.body_fsm, self.state_visual_info, "land_stand");
	end
end

function sv_actor_basic:on_update_land()
	self.io.m_landing_complete = true;
	self.io.m_block_movement = false;
	self:reset_body_state();
end

function sv_actor_basic:on_exit_land()
	self:finish_jump(self.fall_state, self.land_state);
end

function sv_actor_basic:is_finished_land()
	return self.io.m_landing_complete;
end

-------------------------------------
-- ATTACK
-------------------------------------
function sv_actor_basic:on_enter_attack()
	--console.print("------- sv_actor_basic:on_enter_attack()")
	self:begin_attack();

	if self.m_current_attack_info.stop_during_attack == 1 then
		self.io.m_block_movement = true;
		self:stop_movement();
		self:reset_legs_state();
	end
	
	self.io.m_attack_began = false;
	self.io.m_attack_ended = false;
	
	local state_name = self.m_current_attack_info.visual_state_prefix.."_begin"
	if(self:state_exists(state_name)) then
		self.m_attack_selected_visual_idx = self:visualize_state(self.body_fsm, 
			self.state_visual_info, state_name);
	else
		--engine.warning(" attack begin doesnt exists "..state_name);
		self:set_fsm_update_time(self.body_fsm, 1);
	end
end

function sv_actor_basic:on_update_attack()
	if(self.io.m_attack_began == false) then
		self.io.m_pain_allowed = false;
		self.io.m_attack_began = true;

		self:visualize_state(self.body_fsm, self.state_visual_info, 
				self.m_current_attack_info.visual_state_prefix.."_end", self.m_attack_selected_visual_idx);
		-- произвести атаку
		
		if(self.m_current_attack_info.missile ~= nil) then
			self:perform_attack_missile(self.m_current_attack_info);
		else
			self:perform_attack_trace(self.m_current_attack_info);
		end	
	else
		self.io.m_attack_ended = true;
		self:reset_body_state();
	end
end

function sv_actor_basic:on_exit_attack()
	self.io.m_pain_allowed = true;
	self.io.m_block_movement = false;
	self:end_attack();
	self:set_idle("idle_alert", self.params.aggresive_stance_time)
end

function sv_actor_basic:is_finished_attack()
	return self.io.m_attack_ended ;
end


-------------------------------------
-- ATTACK ANIM
-------------------------------------
function sv_actor_basic:on_enter_attack_anim()
	self:begin_attack();

	self.io.m_block_movement = true;
	self:stop_movement();

	self.io.m_attack_ended = false;
	
	self.m_attack_selected_visual_idx = self:visualize_state(self.body_fsm, 
		self.state_visual_info, self.m_current_attack_info.visual_state_prefix);
end

function sv_actor_basic:on_update_attack_anim()
	if(self.io.m_attack_ended  == false) then
		self.io.m_attack_ended  = true;	
		self:reset_body_state();
	end
end

function sv_actor_basic:on_exit_attack_anim()
	self.io.m_block_movement = false;
	self:end_attack();
	--self:set_idle("idle_alert", self.params.aggresive_stance_time)
end

function sv_actor_basic:is_finished_attack_anim()
	return self.io.m_attack_ended ;
end

-------------------------------------
-- ATTACK RUN
-------------------------------------
function sv_actor_basic:on_enter_attack_run()
	self:begin_attack();
	
	self.io.m_attack_run_performed = false;
	self.io.m_attack_run_complete = false;
	self:visualize_state_torso(self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_begin");
	--self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_begin");
end

function sv_actor_basic:on_update_attack_run()
	-- произвести атаку
	if(self.io.m_attack_run_performed == false) then
		self.io.m_pain_allowed = false;
		self:perform_attack_trace(self.m_current_attack_info);
		self.io.m_attack_run_performed = true;
		self:visualize_state_torso(self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_end");
		--self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_end");
		return;
	else
		self.io.m_attack_run_complete = true;
		self:reset_body_state();
	end	
end

function sv_actor_basic:on_exit_attack_run()
	self.io.m_pain_allowed = true;
	self:end_attack();
end

function sv_actor_basic:is_finished_attack_run()
	return self.io.m_attack_run_complete;
end


-------------------------------------
-- ATTACK JUMP
-------------------------------------
function sv_actor_basic:on_enter_attack_jump()
		
	if(self:get_behavior_state() == BHV_WALK) then
		self:begin_attack();
		self:begin_jump(self.attack_jump_fall_state, self.attack_jump_land_state);

		self.io.m_block_movement = true;
		self.m_performed_up = 1;
		self.m_performed_forward = 1;
		
		self.io.m_jump_prepared = true;

		-- анимация начала прыжка
		self:reset_legs_state();		
		self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_begin");
		
	elseif(self:get_behavior_state() == BHV_STAND) then
		self:begin_attack();
	
		self.io.m_jump_prepared = false;
		-- анимация подготовки к прыжку
		self:reset_legs_state();
		self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_prepare");
	end
end

function sv_actor_basic:on_update_attack_jump()
	if(self.io.m_jump_prepared == false) then
		self.io.m_jump_prepared = true;
		
		-- анимация начала прыжка
		self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_begin");
		
		-- команда, которая передается физическому carrier-у
		self.io.m_block_movement = true;
		self.m_performed_up = 1;
		self.m_performed_forward = 1;
		
		self:begin_jump(self.attack_jump_fall_state, self.attack_jump_land_state);
	else
		self.io.m_block_movement = false;
		self.m_performed_up = 0;
		
		--self.io.m_ready_to_fall = true;
		--self:set_fsm_update_time(self.body_fsm, 0);
		--self:change_fsm_state(self.body_fsm, self.attack_jump_fall_state, false);
		
		local bhv_state = self:get_behavior_state();	
		if(bhv_state == BHV_JUMP or bhv_state == BHV_FALL) then
			self:change_fsm_state(self.body_fsm, self.attack_jump_fall_state, false);
		else
			self:finish_jump();
			self:reset_body_state();
		end	
	end
end

-- ATTACK JUMP FALL 
function sv_actor_basic:on_enter_attack_jump_fall()
	self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_fall");
	--self:reset_legs_state();
end

function sv_actor_basic:on_update_attack_jump_fall()
	self:change_fsm_state(self.body_fsm, self.attack_jump_fall_state, false);
end

-- ATTACK JUMP LAND
function sv_actor_basic:on_enter_attack_jump_land()
	self.io.m_block_movement = true;
	self.io.m_landing_complete = false;
	
	self.m_performed_forward	= 0;
	self.m_performed_backward	= 0; 
	self.m_performed_left		= 0;
	self.m_performed_right		= 0;
	self.m_performed_up			= 0;
	self.m_performed_down		= 0;
	
	self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_land_stand");
	
	-- произвести атаку
	self:perform_attack_trace(self.m_current_attack_info);

end

function sv_actor_basic:on_update_attack_jump_land()
	self.io.m_landing_complete = true;
	self.io.m_block_movement = false;
	self:reset_body_state();
end

function sv_actor_basic:on_exit_attack_jump_land()
	self:end_attack();
	self:finish_jump();
end

function sv_actor_basic:is_finished_attack_jump_land()
	return self.io.m_landing_complete;
end


-------------------------------------
-- ATTACK SHOT
-------------------------------------
function sv_actor_basic:on_enter_attack_shot()
	
	-- Если актер первый раз стреляет из данного оружия, то зарядим его.
	if(self.io.m_current_clip_size == nil) then
		self.io.m_current_clip_size = self.params.clip_size;
	end 
	
	-- Перед тем как выполнить атаку, проверяем хватит ли нам патронов на данный выстрел.
	if(self.io.m_current_clip_size == 0) then
		-- Патронов не хватает, нужно перезарядить.
		-- Заканчиваем атаку
		self.io.m_attack_ended  = true;
		
		--console.print(" ------------------ CALLBACK_NEED_TO_RELOAD 3");
		self:send_callback(CALLBACK_NEED_TO_RELOAD, {reload_begin = true});
		self:action_reload();
		return;
	end

	-- Патронов хватает, можем стрелять.
	sv_actor_basic.on_enter_attack(self);
end

-------------------------------------
function sv_actor_basic:on_update_attack_shot()

	if(self.io.m_attack_began == false) then
		
		self.io.m_pain_allowed = false;
		self.io.m_attack_began = true;

		self:visualize_state(self.body_fsm, self.state_visual_info, 
				self.m_current_attack_info.visual_state_prefix.."_end", self.m_attack_selected_visual_idx);
		
		--self:visualize_torso(self.state_visual_info, 
		--	self.m_current_attack_info.visual_state_prefix.."_end", 
		--	self.m_attack_selected_visual_idx);

		
		-- произвести атаку
		if(self.m_current_attack_info.missile ~= nil) then
			self:perform_attack_missile(self.m_current_attack_info);
		else
			self:perform_attack_trace(self.m_current_attack_info);
		end	
		
	else
		self.io.m_attack_ended  = true;
		
		-- Нужно ли перезарядиться
		if(self.io.m_current_clip_size == 0) then
		   --console.print(" ------------------ CALLBACK_NEED_TO_RELOAD 4");
			self:send_callback(CALLBACK_NEED_TO_RELOAD,  {reload_begin = true});
			self:action_reload();
		else
			self:reset_body_state();	
		end
	end
	
end

-------------------------------------
function sv_actor_basic:on_exit_attack_shot()
	sv_actor_basic.on_exit_attack(self);
end

function sv_actor_basic:is_finished_attack_shot()
	return sv_actor_basic.is_finished_attack(self);
end


-------------------------------------
-- ATTACK SHOT RUN
-------------------------------------
function sv_actor_basic:on_enter_attack_shot_run()
	
	-- Если актер первый раз стреляет из данного оружия, то зарядим его.
	if(self.io.m_current_clip_size == nil) then
		self.io.m_current_clip_size = self.params.clip_size;
	end
	
	-- Перед тем как выполнить атаку, проверяем хватит ли нам патронов на данный выстрел.
	if(self.io.m_current_clip_size == 0) then
		-- Патронов не хватает, нужно перезарядить.
		-- Заканчиваем атаку
		self.io.m_attack_ended  = true;
		--console.print(" ------------------ CALLBACK_NEED_TO_RELOAD 5");
		self:send_callback(CALLBACK_NEED_TO_RELOAD, {reload_begin = true});
		self:action_reload();
		return;
	end

	-- Патронов хватает, можем стрелять.
	sv_actor_basic.on_enter_attack_run(self);

	
end

function sv_actor_basic:on_update_attack_shot_run()

	-- произвести атаку
	if(self.io.m_attack_run_performed == false) then
		self.io.m_pain_allowed = false;
		self:perform_attack_trace(self.m_current_attack_info);
		self.io.m_attack_run_performed = true;
		self:visualize_state_torso(self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_end");
		--self:visualize_state(self.body_fsm, self.state_visual_info, self.m_current_attack_info.visual_state_prefix.."_end");
		
		return;
	else
		self.io.m_attack_run_complete = true;		
		
		-- Нужно ли перезарядиться
		if(self.io.m_current_clip_size == 0) then
		--console.print(" ------------------ CALLBACK_NEED_TO_RELOAD 6");
			self:send_callback(CALLBACK_NEED_TO_RELOAD, {reload_begin = true});
			self:action_reload();
		else
			self:reset_body_state();	
		end
	end	
	
end

function sv_actor_basic:on_exit_attack_shot_run()
	sv_actor_basic.on_exit_attack_run(self);
end

function sv_actor_basic:is_finished_attack_shot_run()
	return sv_actor_basic.is_finished_attack_run(self);
end

----------------------------------------
-- ATTACK SHOT BURST (Стрельба очередью)
----------------------------------------

function sv_actor_basic:end_attack_burst()
	self.io.m_wait_for_requested_attack = false;
	self:send_callback(CALLBACK_ACTION_END, ACTION_ATTACK);
end	

function sv_actor_basic:on_enter_attack_shot_burst()

	sv_actor_basic.on_enter_attack_shot(self);
	
	--console.print(" ------------------ begin "..self.m_current_attack_info.visual_state_prefix);
	--self._prefix = self.m_current_attack_info.visual_state_prefix;
	
	-- количество выстрелов в очереди.
	assert(self.params.burst_size);
	self.io.m_cur_burst_size = self.params.burst_size;
	
	if(self.m_current_attack_info.burst_size) then
		self.io.m_cur_burst_size = self.m_current_attack_info.burst_size;
	end
	
	if(self.m_current_attack_info.burst_size_random_add) then
		self.io.m_cur_burst_size = self.io.m_cur_burst_size +
			math.ceil(self.m_current_attack_info.burst_size_random_add * math.random());
	end	
	
	self.m_can_shoot = false;
	
end

function sv_actor_basic:on_update_attack_shot_burst()

	--console.print(" ------------------ update "..self.m_current_attack_info.visual_state_prefix);
	--console.print(" -----update burst "..self.io.m_cur_burst_size.." clip "..self.io.m_current_clip_size);
	
	--.hack
	--[[
	if(self._prefix ~= self.m_current_attack_info.visual_state_prefix) then
		--engine.warning(self._prefix.."   "..self.m_current_attack_info.visual_state_prefix);
		self:end_attack_burst();
		return;
	end--]]

	-- перед тем как выполнить атаку, проверить есть ли у нас патроны
	if(self.io.m_current_clip_size == 0) then
		self.io.m_attack_ended = true;
		self:send_callback(CALLBACK_NEED_TO_RELOAD, {reload_begin = true});
		self:action_reload();
		return;
	end



	if(self.io.m_attack_began == false) then
		-- Начинаем очередь
		self.io.m_attack_began = true;
		self.io.m_pain_allowed = false;
	else
	
		if self.io.m_cur_burst_size <= 0 then
			-- Заканчиваем очередь
			self.io.m_attack_ended = true;	
			
			self:reset_body_state();
			-- есть ли у нас патроны
			if(self.io.m_current_clip_size == 0) then
			
				--console.print("------------ CALLBACK_NEED_TO_RELOAD 7")
				self:send_callback(CALLBACK_NEED_TO_RELOAD, {reload_begin = true});
				self:action_reload();
			end	
			--self:make_transition(self.m_current_attack_info.visual_state_prefix.."_end", nil, self.end_attack_burst)
			self:end_attack_burst();
			return  -- Заканчиваем очередь
		end
	end
	
		
	if(self.m_can_shoot == true) then
		self:perform_attack_trace(self.m_current_attack_info);
		self.io.m_cur_burst_size = self.io.m_cur_burst_size - 1;
		--console.print(" ----- shot "..self.io.m_cur_burst_size.." clip "..self.io.m_current_clip_size);
	end	
	
	local visual_idx, anim_length, anim_idx;

	if self.io.m_cur_burst_size < 1 then
		-- Заканчиваем очередь
		self.io.m_attack_ended = true;	
		
		self:reset_body_state();
		-- есть ли у нас патроны
		if(self.io.m_current_clip_size == 0) then
		
			--console.print("------------ CALLBACK_NEED_TO_RELOAD 7")
			self:send_callback(CALLBACK_NEED_TO_RELOAD, {reload_begin = true});
			self:action_reload();
		end	
		--self:make_transition(self.m_current_attack_info.visual_state_prefix.."_end", nil, self.end_attack_burst)
		self:end_attack_burst();
		return  -- Заканчиваем очередь

	end

	if(self.m_current_attack_info.stop_during_attack == 1) then
		visual_idx, anim_length, anim_idx = self:visualize_state(self.body_fsm, self.state_visual_info, 
				self.m_current_attack_info.visual_state_prefix.."_shooting", 
				self.m_attack_selected_visual_idx, nil, ALLOW_TRANSITION_WITHOUT_ORIGINAL_STATE);
		self.m_can_shoot = true;
	else
		visual_idx, anim_length, anim_idx = self:visualize_state_torso(self.state_visual_info, 
				self.m_current_attack_info.visual_state_prefix.."_shooting", 
				self.m_attack_selected_visual_idx, ALLOW_TRANSITION_WITHOUT_ORIGINAL_STATE);
				
		self.m_can_shoot = true;
	end

	--console.print(" ----- time for next update "..anim_length);
end

function sv_actor_basic:on_exit_attack_shot_burst()
	sv_actor_basic.on_exit_attack_shot(self);
end

function sv_actor_basic:is_finished_attack_attack_shot_burst()
	return sv_actor_basic.is_finished_attack_shot(self);
end


-------------------------------------
-- RELOAD
-------------------------------------
function sv_actor_basic:on_enter_reload()
	--self.io.m_pain_allowed = false;
	self.m_reload_ended = false;

	--console.print(" ====== on_enter_reload actor basic");
	
	if(self.state_visual_info["reload"].block_movement == true) then
		self.io.m_block_movement = true;
		self:block_carrier_turn(true);
		self:stop_movement();
		self:reset_legs_state();
		
		self:visualize_state(self.body_fsm, self.state_visual_info, "reload");
	else
		self:visualize_state_torso(self.state_visual_info, "reload");
	end	
end

function sv_actor_basic:on_update_reload()
	--console.print("===== sv_actor_basic:on_update_reload()")
	
	self.m_reload_ended = true;	
	self.io.m_block_movement = false;
	self:block_carrier_turn(false);
	
	self.io.m_current_clip_size = self.params.clip_size;

	self:reset_body_state();
end

function sv_actor_basic:on_exit_reload()
	--self.io.m_pain_allowed = true;
	
	self:send_callback(CALLBACK_NEED_TO_RELOAD,  {reload_finish = true});
	--console.print(" ==== sv_actor_basic:on_exit_reload()");
end

function sv_actor_basic:is_finished_reload()
	return self.m_reload_ended;
end


-------------------------------------
-- TRANSITION
-------------------------------------
function sv_actor_basic:on_enter_transition()
	self.m_transition_finished = false
	
	if self.m_transition_anim_name then
		self:visualize_state(self.body_fsm, self.state_visual_info, self.m_transition_anim_name);
	end
	
end

-------------------------------------
function sv_actor_basic:on_update_transition()
	if self.m_after_transition_state then
		self:change_fsm_state(self.body_fsm, self.m_after_transition_state, false);		
		self.m_transition_finished = true
	end
	
	
	if self.m_after_transition_callback then
		self.m_after_transition_callback(self);
	end
	
end

function sv_actor_basic:on_exit_transition()
	self.m_in_transition = nil;
	self.io.m_pain_allowed = true;
end
-------------------------------------
function sv_actor_basic:is_finished_transition()
	return self.m_transition_finished;
end
