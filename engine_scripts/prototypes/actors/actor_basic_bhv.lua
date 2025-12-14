------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- физическое поведение для актера
------------------------------------------------------------------------

FORWARD = 0;
BACKWARD = 1;
STRAFE = 2;


sv_actor_basic.run_states = {
	-- forward
	{
		dir = {1, 0, 0},
		fsm_state = "forward_run",
		move_type = FORWARD,
	},
	-- backward
	{
		dir = {-1, 0, 0},
		fsm_state = "backward_run",
		move_type = BACKWARD,
	},
	-- left
	{
		dir = {0, -1, 0},
		fsm_state = "strafe_left_run",
		move_type = STRAFE,
	},
	-- right
	{
		dir = {0, 1, 0},
		fsm_state = "strafe_right_run",
		move_type = STRAFE,
	},
};

sv_actor_basic.walk_states = {
	-- forward
	{
		dir = {1, 0, 0},
		fsm_state = "forward_walk",
		move_type = FORWARD,
	},
	-- backward
	{
		dir = {-1, 0, 0},
		fsm_state = "backward_walk",
		move_type = BACKWARD,
	},
	-- left
	{
		dir = {0, -1, 0},
		fsm_state = "strafe_left_walk",
		move_type = STRAFE,
	},
	-- right
	{
		dir = {0, 1, 0},
		fsm_state = "strafe_right_walk",
		move_type = STRAFE,
	},
};

----------------------------
function sv_actor_basic:reset_legs_state(strong_reset)
		--console.print(" ==================== sv_actor_basic:reset_legs_state() ");

	self.m_last_body_state = self.m_cur_body_state;
	self:change_fsm_state(self.legs_fsm, self.empty_legs_state, strong_reset and strong_reset or false);
end

function sv_actor_basic:reset_body_state(strong_reset)
	--.hack помогает бороться с залипанием монстров
	-- когда они не оповещают контроллер о завершении атаки
	--self:end_attack();

	--console.print(" ==================== sv_actor_basic:reset_body_state() ");
	--utils.traceback();
	self:change_fsm_state(self.body_fsm, self.empty_body_state, strong_reset and strong_reset or false);
end
----------------------------


function sv_actor_basic:init_moving_states()
	assert(self.walk_states, "self.walk_states");
	assert(self.run_states, "self.run_states");
	
	self.walk_speed = {};
	self.walk_speed[FORWARD] = self:get_property_value(self.walk_forward_speed_prop);
	self.walk_speed[BACKWARD] = self:get_property_value(self.walk_backward_speed_prop);
	self.walk_speed[STRAFE] = self:get_property_value(self.walk_strafe_speed_prop);
	
	self.run_speed = {};
	self.run_speed[FORWARD] = self:get_property_value(self.run_forward_speed_prop);
	self.run_speed[BACKWARD] = self:get_property_value(self.run_backward_speed_prop);
	self.run_speed[STRAFE] = self:get_property_value(self.run_strafe_speed_prop);

		
	local moving_states = {{self.walk_states, self.walk_speed}, 
							{self.run_states, self.run_speed}};
	
	for j,w in pairs(moving_states) do
		for i,v in pairs(w[1]) do
			local info = v;
			info.fsm_state_ref = self:get_fsm_state(self.legs_fsm, info.fsm_state);
			assert(info.fsm_state_ref, " wrong state "..info.fsm_state);
			
			info.move_speed = w[2][info.move_type];
		end
	end	
end

-- вызывается после перехода из положения стоя 
-- в положения сидя
function sv_actor_basic:stay_to_sit_begin()
	--console.print(" ----------------- stay_to_sit_begin ");
	if (self.state_visual_info["transition_stay_to_sit"]) then
		self.io.m_block_movement = true;
		self:stop_movement();
		self.m_performed_down = 1;
		self:make_transition("transition_stay_to_sit", nil, self.stay_to_sit_end);
	end
end

function sv_actor_basic:stay_to_sit_end()
	--console.print(" ----------------- stay_to_sit_end ");
	self.io.m_block_movement = false;
	self:reset_body_state();
end

-- вызывается после перехода из положения сидя
-- в положение стоя
function sv_actor_basic:sit_to_stay_begin()
	--console.print(" ----------------- sit_to_stay_begin ");
	assert(self.state_visual_info["transition_sit_to_stay"], "no transition");

	self:make_transition("transition_sit_to_stay", nil, self.sit_to_stay_end);
	self.io.m_block_movement = true;
	self:stop_movement();
end

function sv_actor_basic:sit_to_stay_end()
	--console.print(" ----------------- sit_to_stay_end ");
	
	self.io.m_block_movement = false;
	self:reset_body_state();
end


-------------------------------------------
-- обновление во время состояния падения
function sv_actor_basic:bhv_fall_update(dt, bhv_state, cur_state)
	if(self:is_jumping() == true) then
		return;
	end
	--[[
	if(self:is_jumping() == true) then
		assert(self.m_jump_fall_state);
		if(self.io.m_ready_to_fall == true and 
			cur_state ~= self.m_jump_fall_state) then
			self:change_fsm_state(self.body_fsm, self.m_jump_fall_state, false);
			self.io.m_ready_to_fall = nil;
		end
		return;
	end
	--]]
	
	if(self.io.m_falling_time > self.params.falling_time) then
		if(self:is_above_ground_level(self.params.above_ground_level) == true) then
			self.m_jump_land_state = self.land_state;
			self:change_fsm_state(self.body_fsm, self.fall_state, false);
		end
		self.io.m_falling_time = 0;
	else
		self.io.m_falling_time = self.io.m_falling_time + dt;
	end
end

function sv_actor_basic:bhv_walk_update(dt, bhv_state, cur_state)
	--console.print(" =========== bhv_walk_update cur_state == "..self:get_fsm_state_name(cur_state));
	if(self:is_jumping() == true) then
		-- do nothing
		--if(self.io.m_ready_to_fall == true) then
		--	self:reset_body_state();
		--	self:finish_jump();
		--end	
		return true;
	end	
	
	-- приседание
	if(self.m_down == 1) then
		self.m_performed_down = 1;
	else
		self.m_performed_down = 0;
	end
	--[[
	if(cur_state == self.idle_state or cur_state == self.empty_body_state) then
		if(self.m_down == 1) then
			if(bhv_state == BHV_WALK or bhv_state == BHV_STAND) then
				self:stay_to_sit_begin();
				return true;
			end
		elseif(bhv_state == BHV_SIT or bhv_state == BHV_CREEP) then
			self:sit_to_stay_begin();
			return true;
		end
	end	
	--]]
		
	-- прыжок
	if(self.m_up == 1) then
		if(self:is_jumping() == false and cur_state ~= self.jump_state) then
			self:change_fsm_state(self.body_fsm, self.jump_state, false);
			return true;
		end
	elseif(self.io.m_block_movement == false) then
		--if(self:is_player_controlled() == true) then
		--	console.print(" ----------calc_relative_velocity_dot_with_dir "..val);
		--end			
		
		local moving_states;
		if(self.m_acceleration == 1) then
			move_states = self.run_states;
		else
			move_states = self.walk_states;
		end
		
		local moving_threshold = 16;
		local stop_threshold = 8;
		
		local max_val = 0;
		local fsm_move_state = 1;
		local max_info = nil;
		
		for i,v in pairs(move_states) do
			local info = v;
			
			local val = self:calc_relative_velocity_dot_with_dir(info.dir);
			if(val > max_val) then
				max_val = val;
				fsm_move_state = info.fsm_state_ref;
				max_info = info;
			end
		end
		
		--console.print("========= set walk speed"..max_info.move_speed)
		
		
		local cur_legs_state = self:get_cur_fsm_state(self.legs_fsm);
		
		if(max_val > moving_threshold) then
			
			self:set_walk_speed(max_info.move_speed * self.m_walk_speed_k);
			--console.print(" =========== calc_relative_velocity_dot_with_dir "..max_val);
			
			if(cur_legs_state ~= fsm_move_state) then
				-- если ноги уже находятся в состоянии ходьбы или бега, то
				-- не следует запускать анимацию сначала,
				-- для плавности нужно выставить процент (self.m_legs_anim_time_percent)
				-- того времени, которое уже отыгралось текущей анимации
				if(self.m_legs_walk == true) then
					local anim_cur_time = self:get_animation_time(self.m_legs_anim_idx);
					local anim_full_time = self:get_animation_length_speed(self.m_legs_anim_idx);
					self.m_legs_anim_time_percent = anim_cur_time/anim_full_time;
				end
				self:change_fsm_state(self.legs_fsm, fsm_move_state, false);
				
				if(cur_state == self.idle_state and cur_state ~= self.empty_body_state) then
					self.empty_without_anim = true;
					self:change_fsm_state(self.body_fsm, self.empty_body_state, false);
				end
			end
			return true;
		elseif(max_val < stop_threshold) then
			if(cur_legs_state ~= self.empty_legs_state) then
				self:reset_legs_state();
			end
		end
	end
	return false;
end



-- вызывается когда персонаж стоит на земле и больше ничего не делает
function sv_actor_basic:stand_idle_update(dt, cur_state)
	if(self.m_idle_time_left > 0) then
		self.m_idle_time_left = self.m_idle_time_left - dt;
	else
		self:set_idle("idle", 0)
	end

	if(cur_state == self.empty_body_state and cur_state ~= self.idle_state and 
		self.m_in_transition ~= true) then
		--console.print(" ============== switch to idle");
		self:change_fsm_state(self.body_fsm, self.idle_state, false);
	end	
end


function sv_actor_basic:bhv_stand_update(dt, bhv_state, cur_state)
	if(self:is_jumping() == true) then
		-- do nothing
	elseif(self.m_up == 1) then		
		-- анимация начала прыжка из состояния стоя
		if(self:is_jumping() == false and cur_state ~= self.jump_state) then
			self:change_fsm_state(self.body_fsm, self.jump_state, false);
		end
	else
		self:stand_idle_update(dt, cur_state);
	end
end


function sv_actor_basic:bhv_movement_update(dt, bhv_state, cur_state)
	if(self.io.m_block_movement == false) then
		self.m_performed_forward	= self.m_forward;
		self.m_performed_backward	= self.m_backward;
		self.m_performed_left		= self.m_left;
		self.m_performed_right		= self.m_right;
		
		--self.m_performed_up		= 0;
		--self.m_performed_down		= self.m_down;
	end
	
	-- развернуть корпус в направлении движения
	if(self.m_performed_forward == 1) then
		if(self.m_performed_left == 1) then
			self:set_property_value(self.foots_angle_prop, self.params.body_rotate_forward_strafe);
			self:set_property_value(self.head_angle_prop, -self.params.body_rotate_forward_strafe);
		elseif(self.m_performed_right == 1) then
			self:set_property_value(self.foots_angle_prop, -self.params.body_rotate_forward_strafe);
			self:set_property_value(self.head_angle_prop, self.params.body_rotate_forward_strafe);
		else
			self:set_property_value(self.foots_angle_prop, 0);
			self:set_property_value(self.head_angle_prop, 0);
		end
	else
		self:set_property_value(self.foots_angle_prop, 0);
		self:set_property_value(self.head_angle_prop, 0);
	end


	-- передать команды физическому carrier-у
	self:set_behavior_move(self.m_performed_forward, self.m_performed_backward, 
							self.m_performed_left, self.m_performed_right, 
							self.m_performed_up, self.m_performed_down);
end

-- событие приземления
function sv_actor_basic:on_bhv_land(cur_state)
	self.io.m_falling_time = 0;
	
	if(self.m_jump_land_state) then
		self:change_fsm_state(self.body_fsm, self.m_jump_land_state, false);
		self.m_jump_land_state = nil;
	end
end

-- изменение состояния carrier-а
function sv_actor_basic:on_bhv_state_change(bhv_state, bhv_prev_state)

	--console.print(" ===== !!!!!!!!!!  sv_actor_basic:on_bhv_state_change "..bhv_state.." "..bhv_prev_state);
	
	local cur_state = self:get_cur_fsm_state(self.body_fsm);

	-- начало падения
	if(bhv_state == BHV_FALL) then
		self.io.m_falling_time = 0;
		return;
	end	
	-- конец падения (приземления)
	if(bhv_prev_state == BHV_FALL or bhv_prev_state == BHV_JUMP) then
		self:on_bhv_land(cur_state);
	end
end

---------------------------------------------------------
-- 
function sv_actor_basic:on_bhv_update(dt, bhv_state, cur_state)

	self.m_cur_legs_state = self:get_cur_fsm_state(self.legs_fsm);

	self.m_cur_body_state = cur_state;
	self.m_cur_bhv_state = bhv_state;
	
	--  особый случай, если carrier находится в
	-- 	воздухе, но shapes_enabled = false
	if(bhv_state == BHV_FALL and 
		self:get_property_value(self.m_carrier_freeze_prop) == true) then 
		bhv_state = BHV_WALK;
	end	
	
	if(bhv_state == BHV_FALL or bhv_state == BHV_JUMP) then
		--console.print("================  BHV_FALL");
		self:bhv_fall_update(dt, bhv_state, cur_state);
	-- рассматривается случай, когда bhv_state == BHV_WALK, но 
	-- мы все равно движемся (нас толкают),  в таком случае тоже
	-- нужно проверять self:bhv_walk_update
	elseif(bhv_state == BHV_WALK or bhv_state == BHV_STAND
		or bhv_state == BHV_SIT or bhv_state == BHV_CREEP) then
		--.hack по другому стал работать carrier BHV_FALL включается
		-- снова после приземления
		if(cur_state == self.fall_state) then
			--console.print("================  bhv_state "..bhv_state);
			self:reset_body_state();
		end
	
		local is_walking = self:bhv_walk_update(dt, bhv_state, cur_state);
		if(is_walking == false) then
			self:bhv_stand_update(dt, bhv_state, cur_state);
		end	
	end
	
	self:bhv_movement_update(dt, bhv_state, cur_state);
end