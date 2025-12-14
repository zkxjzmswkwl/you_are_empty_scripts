------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- ai controller anchors, работа с якорями
------------------------------------------------------------------------

function sv_ai_controller_basic:on_detach_actor()

	if(self.m_current_anchor and 
		engine.get_entity_by_id(self.m_current_anchor:get_id()) ~= nil and
		self.m_current_anchor:am_i_occupier(self)) then
		self.m_current_anchor:set_occupy(nil);
	end
end

-----------------------------------------------------
-- работа с tagpoint якорями
-----------------------------------------------------

function sv_ai_controller_basic:add_tagpoint(tagpoint)
	--console.print(".........tagpoint class "..tagpoint:get_name().." id:"..tagpoint:get_id());
	if(tagpoint.class_name == "ai_anchor") then
		if(self.m_attack_anchors == nil) then
			self.m_attack_anchors = {};
		end
		--console.print(".........attack anchor ");
		table.insert(self.m_attack_anchors, tagpoint);
	end	
end




-- применяем параметры указанные в якоре
function sv_ai_controller_basic:use_anchor(anchor, use)

	self:use_attack_anchor(anchor, use);
	self.io.m_current_anchor_used = use;

	--engine.warning(" ==== use_anchor "..anchor:get_name().." use"..(use and "true" or "false"))
	--console.print(" ==== use_anchor"..self.m_current_anchor:get_name().." use"..(use and "true" or "false"));
	
	
	if(use == false) then
		self.m_last_anchor = self.m_current_anchor;
		self.m_current_anchor = nil;
	end
	


end

function sv_ai_controller_basic:use_attack_anchor(anchor, use)
	assert(anchor);
	
	if(use == true) then
		if(anchor:is_block_movement()) then
			self.m_actor:block_carrier_movement(true);
		end	
		if(anchor:is_block_turn()) then
			self.m_actor:block_carrier_turn(true);
		end
		
		anchor:set_occupy(self);
		
		--console.print("  use == true "..self.name_in_factory.."  "..self.index_in_factory.." anchor "..anchor.name_in_factory);
	else
		self.m_actor:block_carrier_movement(false);
		self.m_actor:block_carrier_turn(false);
		
		self.io.m_current_anchor_activated = false;
		self:activate_anchor(anchor, false);
				
		--[[
		for i,v in pairs(self.m_attack_infos) do
			console.print("  ---------------- after unuse anchor use not allowed "..i);
			if(v.not_allowed == true) then
				console.print(" ------------------- true ");
			elseif(v.not_allowed == false) then
				console.print(" ------------------- false ");
			else	
				console.print(" ------------------- nil ");
			end
		end
		--]]

		
		anchor:set_occupy(nil);
		
		--console.print("  use == false "..self.name_in_factory.."  "..self.index_in_factory.." anchor "..anchor.name_in_factory);
	end
end


function sv_ai_controller_basic:activate_anchor(anchor, need_to_activate)
	assert(anchor);
	
	--console.print(" +++++ activate_anchor"..anchor:get_name().." activate  "..(need_to_activate and "true" or "false"));

	if(need_to_activate == true) then
	
		if(anchor:is_blind_attack_allowed()) then
			self:set_blind_trace_enemy_mode(true);
		end

		for i,v in pairs(self.m_attack_infos) do 
			v.original_not_allowed = v.not_allowed;
		end	

		if(anchor.m_disallowed_attacks == "all") then
			for i,v in pairs(self.m_attack_infos) do 
				v.not_allowed = true;
			end	
		else
			for i,v in pairs(anchor.m_disallowed_attacks) do
				self.m_attack_infos[v].not_allowed = true;
			end
		end	


		if(anchor.m_allowed_attacks == "all") then
			for i,v in pairs(self.m_attack_infos) do 
				v.not_allowed = false;
			end		
		else
			for i,v in pairs(anchor.m_allowed_attacks) do
				self.m_attack_infos[v].not_allowed = false;
			end	
		end
		
		
		-- включить визуальные состояния для актера
		local visual_config = anchor:get_visual_config();
		if(visual_config ~= "?" and visual_config ~= " " and
			visual_config ~= "") then
			self.m_actor:activate_state_config(visual_config);
		end

	else
	
		self:set_blind_trace_enemy_mode(false);
		
		for i,v in pairs(self.m_attack_infos) do 
			v.not_allowed = v.original_not_allowed;
		end
		
		
		-- выключить визуальные состояния для актера
		local visual_config = anchor:get_visual_config();
		if(visual_config ~= "?" and visual_config ~= " " and
			visual_config ~= "") then
			self.m_actor:restore_state_config();
		end
	end
	
	
	-- остановить уже начатую атаку, если она не разрешена
	if(self.io.m_attack_started == true and
		self.m_attack_infos[self.io.m_last_selected_attack].not_allowed == true) then
		self:halt_attack();
	end
	

	-- .hack
	-- .debug
	--for i,v in pairs(self.m_attack_infos) do 
	--	self.m_actor.attack_info[i].not_allowed = v.not_allowed;
	--end	


--[[
	local allowed_attacks = " +++  allowed_attacks:";	
	for i,v in pairs(self.m_attack_infos) do 
			if(v.not_allowed ~= true) then
				allowed_attacks	= allowed_attacks..i;
			end	
	end
	console.print(allowed_attacks);
	--]]
end


function sv_ai_controller_basic:is_blind_attack_allowed()
	local anchor_prop = false;
	if(self.m_current_anchor ~= nil and self.io.m_current_anchor_activated == true) then
		anchor_prop = self.m_current_anchor:is_blind_attack_allowed();
	end
	
	return self.io.m_blind_attack_allowed or anchor_prop;
end

-- выбор наиболее подходящего якоря для атаки, если такой есть.
-- возвращает new_anchor_selected, in_radius, in_fov, selected_anchor 
-- new_anchor_selected == true, если выбран новый якорь и надо к нему идти
-- in_radius = true - если расстояние меньше указанного в якоре значения
-- in_fov = true - если враг в заданном fov (для режима auto_activate)
function sv_ai_controller_basic:select_best_attack_anchor()
	
	local is_in_enemy_fov_of_anchor = false;
	local enemy = self:get_enemy();
	

	-- пройтись по всем известным нам якорям
	local closest_anchor = nil;
	local min_dist = nil;
	for i,v in ipairs(self.m_attack_anchors) do
		local anchor = v; 

		-- просчитать для якоря в режиме самоактивации
		-- его положение относительно врага
		if(anchor:is_enable() and anchor:is_auto_activate()) then	
			local enemy_in_fov = self:is_in_fov(anchor, enemy, anchor:get_min_dist_to_enemy(), anchor:get_max_dist_to_enemy(), anchor:get_fov_to_enemy());
			anchor:set_active(enemy_in_fov);
		end



		if(anchor:is_can_be_used() and (anchor:is_occupied() == false or anchor:am_i_occupier(self))) then

			local dist_to_anchor = self:dist_to_pos(anchor:get_pos());
			local dist_to_enemy = self:dist_to_pos(enemy:get_pos());
				
			-- если мы ближе в 2 раза к врагу, чем к якорю, 
			-- то бежать в якорь не будем
			if(2 * dist_to_enemy > dist_to_anchor) then

				local anchor_selected = false;
			
				if(closest_anchor == nil) then
					anchor_selected = true;
				else
					if(closest_anchor:get_priority() < anchor:get_priority()) then
						anchor_selected = true;
					elseif(closest_anchor:get_priority() == anchor:get_priority()) then
						if(min_dist == nil or min_dist > dist_to_anchor) then
							anchor_selected = true;
						end
					end
				end

				
				-- попытаться "забронировать" себе якорь.
				-- это получится, только в том случае если якорь еще 
				-- не был никем занят или мы ближе текущего wanter-а в 2 раза
				if(anchor_selected == true and anchor:can_be_wanter(self, dist_to_anchor)) then
					min_dist = dist_to_anchor;
					closest_anchor = anchor;
				end
			end
		end
	end
	
	if(closest_anchor) then

		closest_anchor:set_wanted(self, min_dist);	
	
		local in_radius;
		if(min_dist < closest_anchor:get_range()) then
			in_radius = true;
		else
			in_radius = false;
		end

		
		local new_selected = true;
		if(self.m_current_anchor ~= nil and 
			self.m_current_anchor.index_in_factory == closest_anchor.index_in_factory) then
			new_selected = false;
		else
			--console.print(" =========== new selected!  anchor "..closest_anchor:get_name());
		end

		local is_in_enemy_fov_of_anchor = closest_anchor:is_active();

		return new_selected, in_radius, is_in_enemy_fov_of_anchor, closest_anchor;
	else
		return false, false, is_in_enemy_fov_of_anchor, nil;
	end
end

-- оценить, какие якоря есть и какие нужно 
-- использовать в данный момент
function sv_ai_controller_basic:evaluate_attack_anchors()
	if((self.m_current_anchor or self.io.m_is_actor_movement_blocked == false) and
		self:is_enemy_present() and self.m_attack_anchors ~= nil) then
		local new_anchor_selected, in_radius, enemy_in_fov, selected_anchor = self:select_best_attack_anchor();
		
		if(new_anchor_selected == true) then
			--console.print(" ===== new_anchor_selected  "..selected_anchor:get_name().." in_radius "..(in_radius and "true" or "false"));
			
			if(self.m_current_anchor and self.io.m_current_anchor_used == true) then
				--console.print(" evaluate deselect  "..selected_anchor:get_name());
				self:use_anchor(self.m_current_anchor, false);
			end
			
			self.m_last_anchor = self.m_current_anchor;
			self.m_current_anchor = selected_anchor;
			if(in_radius == false) then
				self.io.m_activate_relocate = true;
				self.io.m_need_to_relocate = true;
				self.io.m_relocate_pos = selected_anchor:get_pos();
				self.io.m_relocate_radius = selected_anchor:get_range();
			else
				self.io.m_need_to_relocate = false;	
			end	
		elseif(selected_anchor ~= nil) then
			-- если мы вышли из зоны действия текущего якоря - вернуться обратно	
			if(in_radius == false) then
				--console.print(" ==== we've left radius for current anchor  "..selected_anchor:get_name());
				
				if(self.io.m_current_anchor_used == true) then
					--console.print("2 evaluate deselect  "..selected_anchor:get_name());
					self:use_anchor(self.m_current_anchor, false);
				end
			
				if(self.io.m_need_to_relocate == false) then
					self.io.m_activate_relocate = true;
					self.io.m_need_to_relocate = true;
					self.io.m_relocate_pos = selected_anchor:get_pos();
					self.io.m_relocate_radius = selected_anchor:get_range();
				end
			else
				--console.print(" ===== we're in radius of selected anchor  "..selected_anchor:get_name());
				
				self.io.m_need_to_relocate = false;

				if(self.io.m_current_anchor_used == false) then
					self:use_anchor(self.m_current_anchor, true);
				end
				
				
				if(enemy_in_fov == true or self.m_current_anchor:is_auto_activate() == false) then
					if(self.io.m_current_anchor_activated ~= true) then
						self.io.m_current_anchor_activated = true;
						self:activate_anchor(self.m_current_anchor, true);
					end
				else
					if(self.io.m_current_anchor_activated == true) then
						self.io.m_current_anchor_activated = false;
						self:activate_anchor(self.m_current_anchor, false);
					end
				end
			end
			
	
		else
			-- нет выбраных якорей
			if(self.m_current_anchor ~= nil) then
				if(self.io.m_current_anchor_used == true) then
					--console.print(" 3	 ==== no selected anchors")
					self:use_anchor(self.m_current_anchor, false);
				end
		
				self.m_last_anchor = self.m_current_anchor;
				self.m_current_anchor = nil;
				self.io.m_need_to_relocate = false;
			end
		end
	end
		
	return self.io.m_need_to_relocate;
end
