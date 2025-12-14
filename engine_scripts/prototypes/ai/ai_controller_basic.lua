------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- ai controller basic, скриптовое представление для базового актера.
------------------------------------------------------------------------

------------------------------------------------------------------------
ai_controller_basic = {};

---------------------------------------------------------------------------------
ai_controller_basic.properties_design = {
};
---------------------------------------------------------------------------------
ai_controller_basic.params = {
	wander_play_idle_time = 1000,
};

---------------------------------------------------------------------------------
-- общая часть
ai_controller_basic.guid = {0x31856808, 0x8af8, 0x4289, 0x9e, 0x6b, 0xef, 0x70, 0x86, 0xd9, 0x72, 0xe8};

------------------------------------
-- общая часть
function ai_controller_basic:register_properties(prop_registry)
end

function ai_controller_basic:on_init()
end

function ai_controller_basic:register_properties(prop_registry)
end

------------------------------------
-- серверная часть 
sv_ai_controller_basic = utils.inherit(sv_game_object, ai_controller_basic);

function sv_ai_controller_basic:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	ai_controller_basic.register_properties(self, prop_registry);
end

function sv_ai_controller_basic:on_init()
	sv_game_object.on_init(self);
	ai_controller_basic.on_init(self);
	
	self:init_properties_from_table(self.properties_design);
	
	-- получить ссылки на прототипы задачи, описаных на CPP
	self.m_goal_chase = self:get_goal_prototype("chase");
	self.m_goal_retreat = self:get_goal_prototype("retreat");
	self.m_goal_dodge = self:get_goal_prototype("dodge");
	self.m_goal_move_to_pos = self:get_goal_prototype("move_to_pos");
	
	self:add_goal_prototype(goal_attack);
	self:add_goal_prototype(goal_wander);
	self:add_goal_prototype(goal_guard);
	self.m_goal_flee_from_danger = self:add_goal_prototype(goal_flee_from_danger);
	self.m_goal_relocate = self:add_goal_prototype(goal_relocate);
	
		
	if(ai_thinking_disable == true) then
		console.print("ai_thinking_disable = true. AI will do nothing!");
	else
		if(ai_attack_disable == true) then
			console.print("ai_attack_disable == true. AI will not attack you.");
		else
			self:add_strategy_evaluator(goal_attack.id, self.attack_evaluator);			
		end
		self:add_strategy_evaluator(goal_wander.id, self.wander_evaluator);
	end
	
	self:add_strategy_evaluator("flee_from_danger", self.flee_from_danger_evaluator);
	self:add_strategy_evaluator("guard", self.guard_evaluator);
	
	-- игнорировать наличие врагов	
	self.io.m_need_to_ignore_enemies = false;	
	-- переменные атаки
	self.io.m_attack_started = false;
	self.io.m_last_attack_time = 0;
	self.io.m_last_attack_time_end = 0;
	-- режим в котором ИИ стреляет в предполагаемую
	-- позицию игрока, не проверяя is_enemy_visible
	self.io.m_blind_attack_allowed = false;
	-- переменные для guard
	self.m_guard_target = nil;
	self.m_guard_radius = 0;
	self.m_guard_ignore_enemies = false;
	self.m_guard_time = 0;
	self.m_guard_begin_time = 0;
	self.m_guard_run_mode = 0;
	
	
	self.io.m_is_actor_movement_blocked = false;
	
	--------------------
	-- параметры для режима смены позиции 
	--------------------
	-- устанавливается в evaluate_attack_anchors
	-- если выбран новый якорь, и учитывается в goal_relocate,
	-- для выбора нового маршрута
	self.io.m_activate_relocate = false;
	-- включается после выбора якоря 
	-- и до завершения выполнения goal relocate
	self.io.m_need_to_relocate = false;
	-- параметры для работы goal_relocate
	self.io.m_relocate_pos = nil;
	self.io.m_relocate_radius = 0;
	
	-- массивы в котором хранятся якоря для ИИ
	self.m_attack_anchors = nil;
	
	-- сведения о текущих якорях
	self.m_last_anchor = nil;
	self.m_current_anchor = nil;
	self.io.m_current_anchor_used = false;
	-- если false, то атаки где нужно останавливаться выбираться не будудт
	self.io.stop_during_attack_allowed = true;
end



function sv_ai_controller_basic:post_load_init()
	if(self.io.m_current_anchor_id) then
		self.m_current_anchor = engine.get_entity_by_id(self.io.m_current_anchor_id);
		--assert(self.m_current_anchor, "current anchor entity not found!");
		--console.print(".........sv_ai_controller_basic:post_load_init "..self.io.m_current_anchor_id);
		if(self.io.m_current_anchor_used == true) and self.m_actor then
			self:use_anchor(self.m_current_anchor, true);
		end
		if(self.io.m_current_anchor_activated == true) and self.m_actor then
			self:activate_anchor(self.m_current_anchor, true);
		end
	end
	
	if(self.io.m_last_anchor_id) then
		self.m_last_anchor = engine.get_entity_by_id(self.io.m_last_anchor_id);
	end	
end


function sv_ai_controller_basic:on_attach_actor()
	self:read_attacks_params();
	
	self.m_actor = self:get_attached_actor_body();
	assert(self.m_actor, "sv_ai_controller_basic works only with ESV_ActorBody inherited actors");
	
	-- включить якорь, который был сохранен	
	if(self.m_current_anchor) then
		if(self.io.m_current_anchor_used == true) then
			self:use_anchor(self.m_current_anchor, true);
		end
		if(self.io.m_current_anchor_activated == true) then
			self:activate_anchor(self.m_current_anchor, true);
		end
	end
end


function sv_ai_controller_basic:on_load_state(dreader)
	sv_game_object.on_load_state(self,  dreader);

	if (dreader == nil) then return end
end

-- запись текущего состояния
function sv_ai_controller_basic:on_save_state(dwriter)
	self.io.m_current_anchor_id = self.m_current_anchor and self.m_current_anchor:get_id() or nil;
	self.io.m_last_anchor_id = self.m_last_anchor and self.m_last_anchor:get_id() or nil;
	
	if(self.io.m_current_anchor_id) then
		--console.print(".........on_save_state "..self.io.m_current_anchor_id);
	end	

	sv_game_object.on_save_state(self,  dwriter);
end


function sv_ai_controller_basic:on_update(dt)
	sv_game_object.on_update(dt);
	
	self.io.m_is_actor_movement_blocked = self:is_actor_movement_blocked();
	
	self:update_alert_state();
end

function sv_ai_controller_basic:update_alert_state()

	if(self:is_enemy_present() == true) then
	
		if(self.io.m_need_to_ignore_enemies == false and
			self.io.actor_alereted ~= true) then
	    
			self.io.actor_alereted = true;  
			-- перейти в состояние агрессии	
			local input_params = data_stream();
			engine.data_stream_load(input_params, 
					actor.get_action_input_types(ACTION_ALERT), self:get_enemy_id(), {});
			self:execute_action(ACTION_ALERT, input_params);
			data_stream_release(input_params);
		end	
	else
		if(self.io.actor_alereted == true) then
			self.io.actor_alereted = nil;
			-- выйти из состояния агрессии
			local input_params = data_stream();
			engine.data_stream_load(input_params, 
					actor.get_action_input_types(ACTION_ALERT), 0, {});
			self:execute_action(ACTION_ALERT, input_params);
			data_stream_release(input_params);
		end	
	end	
end


-------------------------------------------------------------------------------------
function sv_ai_controller_basic:on_callback(callback_id, data_stream)
	-- для задания охраняемой точки или предмета
	if(callback_id == CALLBACK_GUARD) then
		local need_to_set = engine.data_stream_get_int(data_stream);
		
		if(need_to_set == 1) then
			local input_data = engine.data_stream_get_luaobject(data_stream);
			
			local target_entity_table = engine.get_entities_by_name(input_data.target);
			self.m_guard_target = target_entity_table[1];
			if(self.m_guard_target == nil) then
				console.warning("set guard failed, target entity "..input_data.target.." doesnt exists!");
				return;
			end
		
			self.m_guard_radius = input_data.radius;
			self.m_guard_time = input_data.time;
			self.m_guard_ignore_enemies = input_data.ignore_enemies;
			self.m_guard_run_mode = input_data.run;
			self.m_guard_begin_time = engine.get_game_time();
		else
			--console.print("----------- reset guard");
			self.m_guard_target = nil;	
		end	
	-- установка принудительно параметров для атаки
	elseif(callback_id == CALLBACK_SET_ATTACK_TYPE) then	
		local attack_index = engine.data_stream_get_int(data_stream);
		local status = engine.data_stream_get_int(data_stream);
		local attack_info = self.m_attack_infos[attack_index];
	
		if(attack_info ~= nil) then
			attack_info.status = status;
		end
	elseif(callback_id == CALLBACK_IGNORE_ENEMIES) then	
		local need_to_ignore = engine.data_stream_get_int(data_stream);
		if(need_to_ignore == 1) then
			self.io.m_need_to_ignore_enemies = true;
		else
			self.io.m_need_to_ignore_enemies = false;
		end

	elseif(callback_id == CALLBACK_ACTION_BEGIN) then
		local action_id = engine.data_stream_get_int(data_stream);
		--assert(nil, "goal_attack:on_callback");
		if(action_id == ACTION_ATTACK) then
			--console.print("================== CALLBACK_ACTION_BEGIN  self.io.m_attack_started = true;");
			self.io.m_attack_started = true;
			--self:block_movement(true);

			-- вычислить информацию необходимую для отслеживания когда
			-- и какого типа мы производили атаки
			assert(self.io.m_last_selected_attack, "m_last_selected_attack is nil");
			local attack_info = self.m_attack_infos[self.io.m_last_selected_attack];

			attack_info.last_attack_time = engine.get_game_time();
			attack_info.next_attack_time = nil;
			
			if(attack_info.attacks_in_row > 0 and
				self.io.m_last_attack_type == attack_info.type) then
				attack_info.attacks_in_row = attack_info.attacks_in_row + 1;
			else
				attack_info.attacks_in_row = 1;
				attack_info.attacks_begin_time = attack_info.last_attack_time;

				local pause_add = attack_info.pause_between_attacks and attack_info.pause_between_attacks or 0;
				local random_add = attack_info.pause_between_attacks_random_add and
					(attack_info.pause_between_attacks_random_add * math.random()) or 0;
				attack_info.next_attack_time = attack_info.attacks_begin_time + pause_add + random_add;
			end	
			
			self.io.m_last_attack_time = attack_info.last_attack_time;
			self.io.m_last_attack_type = attack_info.type;
			self.io.m_last_attack_index = self.io.m_last_selected_attack;
					
			return true;
		end
	elseif(callback_id == CALLBACK_ACTION_END) then
		local action_id = engine.data_stream_get_int(data_stream);
		if(action_id == ACTION_ATTACK) then
			--if(self.io.m_attack_started == false) then
			--	console.warning("ACTION_ATTACK CALLBACK_ACTION_END without CALLBACK_ACTION_BEGIN");
			--end
			
			--console.print("================== goal_attack:on_callback(callback_id, data_stream) CALLBACK_ACTION_END");
			self.io.m_last_attack_time_end = engine.get_game_time();
			
			if(self.io.m_last_attack_type == ATTACK_DISTANT) then
				local attack_info = self.m_attack_infos[self.io.m_last_attack_index];
				-- если атак было больше чем дозволеных на одну,
				-- то осуществляем редислокацию (если столько же,
				-- то выбираем другой тип атаки, если такой есть)
				if(attack_info.attacks_in_row_allowed and attack_info.attacks_in_row > attack_info.attacks_in_row_allowed) then
					self.io.m_need_to_relocate_after_attack = true;
				end
			end	
			
			--console.print("================== CALLBACK_ACTION_END  self.io.m_attack_started = false");
			self.io.m_attack_started = false;
			
			--self:block_movement(false);
		
			return true;
		end
	elseif(callback_id == CALLBACK_NEED_TO_RELOAD) then
		local data = engine.data_stream_get_luaobject(data_stream);
		if(data.reload_begin == true) then
			--self.io.m_attack_started = false;
			self.m_reloading = true;
			--console.print("==================  goal_attack data.reload_begin == true, self.io.m_attack_started = false; ");
		elseif(data.reload_finish == true) then
			self.m_reloading = false;
			--console.print("================== goal_attack data.reload_finish == true");
		end
	end

end





-----------------------------------
-- клиентская
cl_ai_controller_basic = utils.inherit(cl_game_object, ai_controller_basic);

function cl_ai_controller_basic:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	ai_controller_basic.register_properties(self, prop_registry);
end

function cl_ai_controller_basic:on_init()
	cl_game_object.on_init(self);
	ai_controller_basic.on_init(self);
end