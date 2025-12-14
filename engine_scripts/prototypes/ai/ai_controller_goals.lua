------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- ai controller goals, прототипы задач ИИ
------------------------------------------------------------------------

------------------------------------
-- задачи
------------------------------------
goal_abstract = {};

function goal_abstract:clone()
	local owner = self.m_owner;
	-- чтоб не копировать таблицу m_owner мы временно
	-- уничтожаем ссылку на нее
	self.m_owner = nil;
	local cloned_goal = utils.clone(self);
	self.m_owner = owner;
	cloned_goal.m_owner = owner;
	-- c++ объект должен быть переназначен
	cloned_goal.__object = nil;
	return cloned_goal;
end

------------------------------------
-- атака
------------------------------------

goal_attack = utils.inherit(goal_abstract);
goal_attack.id = HUID("attack");

function goal_attack:activate()

	self:set_status(ACTIVE);
	
	self:remove_all_subgoals();
		
	self.m_owner:set_run_mode(true);

	self.m_owner.m_attack_activate_time = engine.get_game_time();
	
	self.m_owner.io.m_need_to_relocate_after_attack = false;
	
	local dist_to_enemy = self.m_owner:dist_to_enemy();
	
	local retreat_dist = self.m_owner.m_actor.params.retreat_dist;
	local chase_dist = self.m_owner.m_actor.params.chase_dist;
	local dodge_radius = self.m_owner.m_actor.params.dodge_dist;
	local dodge_time = self.m_owner.m_actor.params.dodge_time;
	
	local retreat_pause = self.m_owner.m_actor.params.retreat_pause or 0;
	local chase_pause = self.m_owner.m_actor.params.chase_pause or 0;
	
	local dodge_min_dist = chase_dist * 0.9;
	local dodge_max_dist = retreat_dist * 1.1;
		
	local want_to_attack = (self.m_owner.m_reloading == true) or 
							self.m_owner:is_enemy_shootable();
							
	self.m_owner.m_last_retreat_time = self.m_owner.m_last_retreat_time or 0;
	self.m_owner.m_last_chase_time = self.m_owner.m_last_chase_time or 0;
							
	if(self.m_owner.io.m_need_to_relocate == true) then
		--console.print("================== relocating");
		
		--.hack непонятно почему может быть не задано self.m_owner.io.m_relocate_pos
		if(self.m_owner.io.m_relocate_pos == nil or self.m_owner.io.m_relocate_radius == nil) then
			--engine.warning("actor:"..self.m_owner.m_actor:get_name().." wrong params relocating: radius "..(self.m_owner.io.m_relocate_radius and self.m_owner.io.m_relocate_radius or "nil").." pos "..(self.m_owner.io.m_relocate_pos and self.m_owner.io.m_relocate_pos.x or "nil"));
			self.m_owner.io.m_need_to_relocate = false;
		else
			local goal_relocate = self.m_owner.m_goal_relocate:clone();
			self:add_subgoal(goal_relocate);
		end	
	elseif(--[[want_to_attack and--]]
		dist_to_enemy > dodge_min_dist and dist_to_enemy < dodge_max_dist) then	
		--console.print("================== dodging "..dist_to_enemy);
		
		self.m_owner.m_last_retreat_time = engine.get_game_time();
		
		local goal_dodge = self.m_owner.m_goal_dodge:clone();
		goal_dodge:init(dodge_min_dist, dodge_max_dist, dodge_radius, dodge_time);
		self:add_subgoal(goal_dodge);
	elseif((want_to_attack and dist_to_enemy < retreat_dist)
			and ((engine.get_game_time() - self.m_owner.m_last_chase_time) > retreat_pause)) then
		--console.print("================== retreating "..dist_to_enemy);
		
		self.m_owner.m_last_retreat_time = engine.get_game_time();
		
		local goal_retreat = self.m_owner.m_goal_retreat:clone();
		goal_retreat:init(retreat_dist);
		self:add_subgoal(goal_retreat);
	elseif((dist_to_enemy > chase_dist or self.m_owner:is_enemy_shootable() ~= true)
		and ((engine.get_game_time() - self.m_owner.m_last_retreat_time) > chase_pause)) then
		--console.print("================== chasing "..dist_to_enemy);
		--console.print("================== chasing".." movement blocked:"..(self.m_owner.io.m_is_actor_movement_blocked and "true" or "false"));
		--if(self.m_owner.io.m_is_actor_movement_blocked ~= true) then
		
		self.m_owner.m_last_chase_time = engine.get_game_time();
		
		local goal_chase = self.m_owner.m_goal_chase:clone();
		local seek_dist = self.m_owner.m_actor:get_property_value(self.m_owner.m_actor.m_seek_dist);
		goal_chase:init(chase_dist, seek_dist);
		self:add_subgoal(goal_chase);
	else
		--console.print("================== just looking "..dist_to_enemy);
		self.m_owner:actor_stop();
		self.m_owner:turn_to_enemy();
		
	end	

end

function goal_attack:process(dt)
	self:activate_if_inactive();
	
	local result = self:process_subgoals(dt);
	
	if(self.m_owner.io.m_attack_started == true) then
		self.m_owner:update_current_attack();
	end
	
	--self.m_owner:process_attack(dt);
	
	--console.print("== goal_attack:process")
	self.m_owner:evaluate_attack_anchors();
	
	--if(self.m_owner.io.m_attack_started	== false) then
	--	self.m_owner:evaluate_attack_anchors();
	--end	
	

	if(self.m_owner.io.m_need_to_relocate == true and
		self.m_owner.io.m_relocating ~= true and
		self.m_owner.io.m_attack_started ~= true) then
		
		self:set_status(INACTIVE);
		return ACTIVE;
	end
	
	self.m_owner:process_attack(dt);
	

	-- если нет текущих задач, провести активацию по новой
	if(self:is_has_subgoals() == false) then
		--console.print("-- dont have subgoals")
		self:set_status(INACTIVE);
	end
		
	return ACTIVE;
end

function goal_attack:terminate()
	self.m_owner:halt_attack();
	self:set_status(INACTIVE);
	
	
	-- если мы успели выбрать якорь - отказаться от него
	if(self.m_owner.m_current_anchor and 
		self.m_owner.m_current_anchor:am_i_occupier(self.m_owner)) then
		self.m_owner:use_anchor(self.m_owner.m_current_anchor, false);
	end
end

function goal_attack:on_callback(callback_id, data_stream)
	--assert(nil, "goal_attack:on_callback");

	if(callback_id == CALLBACK_ACTION_BEGIN) then
	elseif(callback_id == CALLBACK_ACTION_END) then
		if(action_id == ACTION_ATTACK) then
			self:set_status(INACTIVE);
		end	
	elseif(callback_id == CALLBACK_NEED_TO_RELOAD) then
		self:set_status(INACTIVE);
	end

	return false;
end


------------------------------------
-- wander - хождение без дела
------------------------------------

goal_wander = utils.inherit(goal_abstract);
goal_wander.id = HUID("wander");
goal_wander.m_wait_time = 0;
goal_wander.m_need_to_wander_in_pos = -1;
goal_wander.m_pos_to_wander = {0, 0, 0};



function goal_wander:activate()
	
	--console.print(" ---------------------- goal_wander:activate() ");
	--console.print(" ---------------------- in activate self.m_need_to_wander_in_pos "..self.m_need_to_wander_in_pos);
	self.m_owner:block_movement(false);
	self.m_owner:set_run_mode(false);	
	
	self:set_status(ACTIVE);
	self:remove_all_subgoals();
	
	self.m_owner:actor_stop();

	local pos_to_go;
	
	--console.print(" ---------------------- self.m_need_to_wander_in_pos "..self.m_need_to_wander_in_pos);
	assert(self.m_need_to_wander_in_pos);
	if(self.m_need_to_wander_in_pos == 1) then
		--console.print(" ---------------------- goal_wander:activate m_pos_to_wander ");
		pos_to_go = self.m_pos_to_wander;
		self.m_need_to_wander_in_pos = 0;
		
		local goal_move_to_pos = self.m_owner.m_goal_move_to_pos:clone();
		goal_move_to_pos:init(pos_to_go, 2.5, true);
		self:add_subgoal(goal_move_to_pos);

	else
		--console.print(" ---------------------- goal_wander:activate random waypoint ");
		pos_to_go = self.m_owner:get_random_waypoint(2.5, 20);
	end
		
	self.m_wait_time = 0;

end

function goal_wander:process(dt)
	
	self:activate_if_inactive();
	local result = self:process_subgoals(dt);
	--[[
	if(result == COMPLETED) then
		self.m_wait_time = self.m_wait_time + dt;
	elseif(result == FAILED) then
		self:set_status(INACTIVE);
		return ACTIVE;
	end
	--]]

	self:set_status(ACTIVE);
	return ACTIVE;
end

function goal_wander:terminate()
end

function goal_wander:on_callback(callback_id, data_stream)
	
	local play_idle_wait_time = self.m_owner.params.wander_play_idle_time;
	-- только когда заканчивается проигрывание idle анимации
	-- мы можем двигаться в следующий waypoint	
	if(callback_id == CALLBACK_ANIM_END) then
		--console.print(" ---------------------- goal_wander:on_callback CALLBACK_ANIM_END ");
		if(self.m_wait_time > play_idle_wait_time) then
			self:activate();
			return true;
		end	
	-- для передвижения по ai_ctrl_trigger	
	elseif(callback_id == CALLBACK_WALK_HERE) then
		--console.print(" ---------------------- goal_wander:on_callback CALLBACK_WALK_HERE ");
		-- для передвижения по ai_ctrl_trigger	
		self.m_pos_to_wander = engine.data_stream_get_vec3(data_stream);
		self.m_need_to_wander_in_pos = 1;

		self:activate();
	
		return true;
	end

	return false;
end

------------------------------------
-- relocate - перемещение в точку или
-- якорь
------------------------------------

goal_relocate = utils.inherit(goal_abstract);
goal_relocate.id = HUID("relocate");

function goal_relocate:activate()

	--console.print("............. realocating to anchor ".." "..self.m_owner.m_current_anchor:get_name().."  "..(self.m_owner.io.m_is_actor_movement_blocked and "true" or "false"));
	
	--engine.warning("............. realocating to anchor ".." "..self.m_owner.m_current_anchor:get_name().."  "..(self.m_owner.io.m_is_actor_movement_blocked and "true" or "false"));
	

	self:set_status(ACTIVE);
	self:remove_all_subgoals();
	
	self.m_owner:set_run_mode(true);
	--self.m_owner:block_movement(false);
	
	self.m_owner.io.m_relocating = true;
	self.m_owner.io.m_activate_relocate = false;
	self.m_owner.io.stop_during_attack_allowed = false;
	
	assert(self.m_owner.io.m_relocate_pos and self.m_owner.io.m_relocate_radius);

	
	
	local goal_move_to_pos = self.m_owner.m_goal_move_to_pos:clone();
	goal_move_to_pos:init(self.m_owner.io.m_relocate_pos, self.m_owner.io.m_relocate_radius, true);
	self:add_subgoal(goal_move_to_pos);
	
end

function goal_relocate:process(dt)
	
	self:activate_if_inactive();
	
	if(self.m_owner.io.m_activate_relocate == true) then
		self:set_status(INACTIVE);
		return ACTIVE;
	end

	local result = self:process_subgoals(dt);
	
	--console.print("++++ realocating to anchor ".." "..self.m_owner.m_current_anchor:get_name().."  "..result);
	
	if(result == COMPLETED) then
		if(self.m_owner.io.m_need_to_relocate == true) then
			if(self:is_has_subgoals()) then
			    -- только что закончили перемещение в нужную позицию
			    self.m_owner.io.m_need_to_relocate = false;
				-- убрать все подзадачи, чтоб вызвалась функция terminate
				-- у текущего goal_move_to_pos
			    self:remove_all_subgoals();
			end
		end
	
		self:set_status(COMPLETED);
		return COMPLETED;
	end	

	self:set_status(ACTIVE);
	return ACTIVE;
end

function goal_relocate:terminate()
	self.m_owner.io.stop_during_attack_allowed = true;
	self.m_owner.io.m_relocating = nil;
end


------------------------------------
-- guard - охрана позиции или объекта
------------------------------------

goal_guard = utils.inherit(goal_abstract);
goal_guard.id = HUID("guard");

function goal_guard:activate()

	--console.print("== goal_activate")

	self:set_status(ACTIVE);
	self:remove_all_subgoals();
	
	self.m_owner:block_movement(false);
	
	self.m_owner:halt_attack();
	
	if(self.m_owner.m_guard_run_mode == 1) then
		self.m_owner:set_run_mode(true);
	elseif(self.m_owner.m_guard_run_mode == 2) then
		self.m_owner:set_run_mode(false);
	end		
	
	assert(self.m_owner.m_guard_target, "m_guard_target is not set");

	local pos_to_go;
	pos_to_go = self.m_owner.m_guard_target:get_pos();
		
	local goal_move_to_pos = self.m_owner.m_goal_move_to_pos:clone();
	goal_move_to_pos:init(pos_to_go, self.m_owner.m_guard_radius/2, true);
	self:add_subgoal(goal_move_to_pos);
	
	self.m_guard_activate_time = engine.get_game_time();
end

function goal_guard:process(dt)
	--console.print("== goal_guard")

	self:activate_if_inactive();
	local result = self:process_subgoals(dt);
	
	if(engine.get_game_time() - self.m_guard_activate_time > 750) then
		self:set_status(INACTIVE);
		return ACTIVE;
	end
	
	self:set_status(ACTIVE);
	return ACTIVE;
end

function goal_guard:terminate()
end

------------------------------------
-- беспорядочное отступление (от гранаты)
------------------------------------

goal_flee_from_danger = utils.inherit(goal_abstract);
goal_flee_from_danger.id = HUID("flee_from_danger");

function goal_flee_from_danger:activate()

	self:set_status(ACTIVE);
	self:remove_all_subgoals();
		
	self.m_owner:set_run_mode(true);
	self.m_owner:halt_attack();
	
	-- если мы успели выбрать якорь - отказаться от него
	if(self.m_owner.m_current_anchor and 
		self.m_owner.m_current_anchor:am_i_occupier(self.m_owner)) then
		self.m_owner:use_anchor(self.m_owner.m_current_anchor, false);
	end

	--if(self.m_owner:dist_to_enemy() < 30) then
	local goal_retreat = self.m_owner.m_goal_retreat:clone();
	goal_retreat:init(10, 3000, true);
	self:add_subgoal(goal_retreat);
	--end	
end

function goal_flee_from_danger:process(dt)
	self:activate_if_inactive();
	
	local result = self:process_subgoals(dt);
	
	-- если нет текущих задач, провести активацию по новой
	if(self:is_has_subgoals() == false) then
		self:set_status(INACTIVE);
	end
		
	return ACTIVE;
end

function goal_flee_from_danger:terminate()
	self:set_status(INACTIVE);
end

function goal_flee_from_danger:on_callback(callback_id, data_stream)
	return false;
end
