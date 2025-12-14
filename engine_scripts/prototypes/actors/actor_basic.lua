------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Basic, скриптовое представление для базового актера.
-- загружает анимации для передвижения
------------------------------------------------------------------------


-- таблица с описанием визуального представления состояния FSM
-- инициализируется в отдельном файле, который редактируется дизайнерами
--[[
states_design["имя состояния fsm"] = {
			-- таблица с описанием различных анимаций для данного состояния	
			{{anim = "имя анимации 1", anim_speed = скорость_анимации, anim_bone_group = "имя группы костей", snd = "имя звука 1", snd_vol = громкость_звука, weight = вес (вероятность),},
			 {anim = "имя анимации 2", anim_speed = скорость_анимации, snd = "имя звука 2", snd_vol = громкость_звука, weight = вес (вероятность),},
			 ...,},};
--]]

-- значение для звуков актера по умолчанию
SND_ACTOR_MIN_DIST = 5;
SND_ACTOR_MAX_DIST = 15;
-- 
SND_ACTOR_SHOT_VOL = 0;
SND_ACTOR_SHOT_MIN_DIST = 10;
SND_ACTOR_SHOT_MAX_DIST = 50;

SND_RESOURCE_VOICE = 1;
SND_RESOURCE_WEAPON = 2;
SND_RESOURCE_STEPS = 4;

--
snd_actor_attack = {
	min_dist = 5,
	max_dist = 25,
	priority = 2,
	resource = engine.bitwise_or(SND_RESOURCE_VOICE, SND_RESOURCE_STEPS),
};

snd_actor_shot = {
	min_dist = SND_ACTOR_SHOT_MIN_DIST,
	max_dist = SND_ACTOR_SHOT_MAX_DIST,
	priority = 2,
	resource = SND_RESOURCE_WEAPON, 
};

snd_actor_reload = {
	min_dist = 2,
	max_dist = 15,
	priority = 3,
	resource = SND_RESOURCE_WEAPON, 
};

snd_actor_common = {
	min_dist = 5,
	max_dist = 25,
	priority = 0,
	resource = SND_RESOURCE_VOICE,
};

snd_actor_alert = {
	min_dist = 5,
	max_dist = 30,
	priority = 3,
	resource = SND_RESOURCE_VOICE, 

	ai_min_dist = 5,
	ai_max_dist = 15,
	ai_type = AI_SOUND_DANGER,
};

snd_actor_pain = {
	min_dist = 5,
	max_dist = 15,
	priority = 1,
	resource = SND_RESOURCE_VOICE, 
	
	ai_min_dist = 5,
	ai_max_dist = 15,
	ai_type = AI_SOUND_DANGER,
};

snd_actor_death = {
	min_dist = 5,
	max_dist = 35,
	priority = 30,
	resource = SND_RESOURCE_VOICE, 
	
	play_once = true,
	
	ai_min_dist = 5,
	ai_max_dist = 15,
	ai_type = AI_SOUND_DANGER,
};


snd_actor_steps_walk = {
};

snd_actor_steps_run = {
	min_dist = 2,
	max_dist = 15,

	priority = 2,
	resource = SND_RESOURCE_STEPS,

	ai_min_dist = 2,
	ai_max_dist = 6,
	ai_type = AI_SOUND_DANGER,
};

-- группы костей для анимаций персонажа
LEGS_BONE_GROUP = "nogi";
TORSO_BONE_GROUP = "upper_model";
BODY_BONE_GROUP = {"nogi", "upper_model"};
--

-- состояние в котором может находится модель тела актера
NORMAL_BODY_STATE = 0;
SIT_BODY_STATE = 1;
LEFT_SLOPE_BODY_STATE = 2;
RIGHT_SLOPE_BODY_STATE = 3;

--
actor_basic = {};

-- множители-модификаторы на различные типы повреждений
actor_basic.damage_types_k = {
	[g_damage_type.GUNSHOT] = 1,
	[g_damage_type.FALL] = 1,
	[g_damage_type.KNOCK] = 1,
	[g_damage_type.BLAST] = 1,
	[g_damage_type.BURN] = 1,
};
--[[
actor_basic.damage_types_k = {};
actor_basic.damage_types_k[g_damage_type.GUNSHOT] = 1;
actor_basic.damage_types_k[g_damage_type.FALL] = 1;
actor_basic.damage_types_k[g_damage_type.KNOCK] = 1;
actor_basic.damage_types_k[g_damage_type.BLAST] = 1;
actor_basic.damage_types_k[g_damage_type.BURN] = 1;
--]]

-- настройки пропертей для базового актера
actor_basic.properties_design = {
    -- имя класса используемого ИИ контроллера
	{ "ai_controller_name",			"ai_controller_basic" },
    -- материалы на carrier и ragdoll
	{ "material_body_default",		"mat_actor_body"	},
	{ "material_carrier_default",	"mat_actor_carrier"	},
	-- разлет крови
	{ "bloodmark_effect",			"wall_blood.lua"	},
	{ "bloodmark_dispersion_angle",	120					},
	{ "bloodmark_hit_threshold", 10						},
	-------------------------------
	-- настройки сенсоров осязания
	-------------------------------
	-- FOV зрения
	{ "view_fov",					90 },
	-- макс. дистанция зрения 
	{ "view_dist",					25 },	
	
	
	--{ "material_steps",				"mat_actor_human_steps"	},
	
	-- порог слышимости звука
	-- минимальная громкость звука (0 - слышит все, до >1 - не слышит ничего),
	-- на которую срабатывает сенсор слуха
	-- { "sensor_sound_threshold",		0  },	
	-- параметры повреждения
	-- мин. размер хита и импульса чувствительные для сенсора повреждения
	-- { "sensor_damage_hit_threshold",	 0  },
    -- { "sensor_damage_impulse_threshold", 0  },
    -- сенсор столкновения (вкл/выкл)
    -- { "sensor_collision",		true    },
        
    -- макс. угол поворота головы, который можно делать свлева на вправо и наоборот
    { "head_yaw_max",			45 },
    { "head_pitch_min",			-10 },
    { "head_pitch_max",			60 },
    { "torso_yaw_max",			45 },
    { "torso_pitch_min",		-10 },
    { "torso_pitch_max",		45 },
    { "turn_hands",				0 },	--// 0 - none, 1 - right, 2 - left, 3 - both
    { "allow_head_turn",		false },
    -- настройки для памяти ИИ
	{ "track_pos_time",					2000 },
	{ "forget_nonsensed_entity_time",	120000 },
	{ "vision_fade_in_time",			0 },
    { "vision_fade_out_time",			0 },
};

actor_basic.params = {};

-- боль
-- порог, выше которого отыгрывается анимация боли
actor_basic.params.pain_threshold = 1;
-- анимация боли будет отыгрываться на все тело, монстр при этом остановится
actor_basic.params.pain_for_full_body = false;
-- боль может прерывать атаку
actor_basic.params.pain_can_disrupt_attack = false;

-- пороговое значение суммарного импульса, если
-- при привышение которого не будет отыгрываться анимация смерти,
-- а просто проспавниться регдол
actor_basic.params.death_impulse_threshold = 3.0;

-- настройки для взрыва регдола, после смерти - 
-- разлета кусков после сильного повреждения
actor_basic.params.death_explosion_impulse_threshold = nil;
actor_basic.params.death_explosion_damage_threshold = nil;
-- настроки для взрыва регдола
actor_basic.params.death_explosion_effect = "Rat_Blood.lua";
actor_basic.params.death_explosion_model_name = "rat";
actor_basic.params.death_explosion_debris_model = "rat_debris";
actor_basic.params.death_explosion_debris_scattering = 200000;

-- параметры для перемещения во время боя
-- расстояние ближе которого, актер начинает отступать
actor_basic.params.retreat_dist = 0;
-- расстояние до которого, актер преследует игрока
actor_basic.params.chase_dist = 0;
-- расстояние на которое актер стрейфится во время боя
actor_basic.params.dodge_dist = 5;
-- время которое актер тратит на стрейф в одну сторону
actor_basic.m_actor.params.dodge_time = 1000;



----------------------------------------------------------------------
function actor_basic:prepare_visual_state_info()
	-- таблица в которую будут записаны индексы для проинициализированных
	-- анимаций и звуков
	self.state_visual_info = {};
	
	-- предварительная обработка таблицы описания состояний
	for i,v in pairs(self.states_design) do
		assert(type(v) == "table", self.class_name.." state '"..i.."' is not a table");
		
		
		self.state_visual_info[i] = {};
		
		self.state_visual_info[i].without_anims = true;
		self.state_visual_info[i].without_sounds = true;
		
		-- запомнить состояние тела, для которого прописывается
		-- визуальное состояние
		if(self:is_server_object()) then
			self.state_visual_info[i].body_state = v.body_state;
		
			if(self.state_visual_info[i].body_state == nil) then
				self.state_visual_info[i].body_state = NORMAL_BODY_STATE;
			end	
			
			self.state_visual_info[i].primary_bone_group = v.primary_bone_group;
			-- только для reload
			self.state_visual_info[i].block_movement = v.block_movement;
		end
		
		
		local total_weight = 0;
		for j,w in ipairs(v) do
			self.state_visual_info[i][j] = {};
			
			-- проинициализировать различные варианты визуализации
			if(w.anim ~= nil) then
			
				self.state_visual_info[i].without_anims = false;
									
				local anim_speed = v.anim_speed and v.anim_speed or 1;
				if(w.anim_speed ~= nil) then
					anim_speed = w.anim_speed;
				end
			
				local anim_playback = v.anim_playback and v.anim_playback or ANIM_PB_ONCE;
				if(w.anim_playback ~= nil) then
					anim_playback = w.anim_playback;
				end

				local anim_bone_group = v.anim_bone_group;
				if(w.anim_bone_group ~= nil) then
					anim_bone_group = w.anim_bone_group;
				else
					anim_bone_group = BODY_BONE_GROUP;
				end
			
				local anim_info = {};
				
				if(type(anim_bone_group) ~= "table") then
					local bone_group_name = anim_bone_group;
					anim_bone_group = {};
					table.insert(anim_bone_group, bone_group_name);
				end
				
				local anim_blend_in_time = v.anim_blend_in_time;
				if(w.anim_blend_in_time ~= nil) then
					anim_blend_in_time = w.anim_blend_in_time;
				end
			
				local anim_blend_out_time = v.anim_blend_out_time;
				if(w.anim_blend_out_time ~= nil) then
					anim_blend_out_time = w.anim_blend_out_time;
				end			

				anim_info.anim_name = w.anim;
				anim_info.anim_playback = anim_playback;
				anim_info.anim_speed = anim_speed;

				-- создать отдельные анимации для каждой группы костей
				anim_info.anims = {};			
				for ii,vv in pairs(anim_bone_group) do
					
					local animation = {};	
					
					-- вычисляем index по имени группы костей,
					-- это будет self.m_legs_bones или self.m_torso_bones
					local bone_group_idx = self:add_bones_group(self.m_model_body, vv);
					animation.anim_bone_group = bone_group_idx;
					animation.anim = self:add_animation(self.m_model_body, w.anim, anim_playback, anim_speed, animation.anim_bone_group, anim_blend_in_time, anim_blend_out_time);

					table.insert(anim_info.anims, animation);
				end
				
				self.state_visual_info[i][j].anim_info = anim_info;
			end
			
			
			if(w.snd ~= nil) then
			
				self.state_visual_info[i].without_sounds = false;
				local snd_params = v.snd_params;
				snd_params = w.snd_params and w.snd_params or snd_params;
				if(snd_params == nil) then 
					snd_params = snd_actor_common; 
				end
				w.snd_params = snd_params;
				local snd_idx = self:read_sound(w, false, 0, 1, SND_ACTOR_MIN_DIST, SND_ACTOR_MAX_DIST);
				self.state_visual_info[i][j].snd = snd_idx;
				self.state_visual_info[i][j].snd_play_once = w.snd_play_once;
			end	

		
			local weight = 1;
			if(w.weight ~= nil) then weight = w.weight; end
			total_weight = total_weight + weight;
		end
		
		-- перевести веса в соответствующие
		-- разбиения отрезка от 0 до 1
		for j,w in ipairs(v) do
		
			local weight = 1;
			if(w.weight ~= nil) then weight = w.weight; end	
		
			local distribution = weight/total_weight;
			if(j > 1) then
				distribution = distribution + self.state_visual_info[i][j-1].distribution;
			end
			self.state_visual_info[i][j].distribution = distribution;
		end
	end
end


-- общая часть
function actor_basic:register_properties(prop_registry)
	self.m_model_body_prop = self:register_property(prop_registry, "model_name", "?");
	self.m_custom_idle_prop = self:register_property(prop_registry, "custom_idle", "?");
	self.m_custom_transition_to_alert_prop = self:register_property(prop_registry, "custom_transition_to_alert", "?");
	self.m_stop_during_transition_to_alert_prop = self:register_property(prop_registry, "stop_during_transition_to_alert", true);
	self.m_allow_run = self:register_property(prop_registry, "allow_run", true);
	
	self.m_seek_dist = self:register_property(prop_registry, "seek_dist", 15);

	-- атаки, которые изначально разрешены и запрещены	
	self.m_allowed_attacks_prop = self:register_property(prop_registry, "allowed_attacks", " ");
	self.m_disallowed_attacks_prop = self:register_property(prop_registry, "disallowed_attacks", " ");
	-- visual config
	self.m_visual_config_prop = self:register_property(prop_registry, "visual_config", "?");
end


	
function actor_basic:on_init()
	---------------------------------------
	-- модель тела актера
	---------------------------------------
	
	local model_name = self:get_property_value(self.m_model_body_prop);
	if(self:is_server_object()) then
		-- если прописаны альтернативы модели, сделать случайный выбор
		if(type(self.params.model_variants) == "table") then
			local table_n = table.getn(self.params.model_variants);
			local rnd = math.random(table_n);
			model_name = self.params.model_variants[rnd];
			assert(type(model_name) == "string");
			self:set_property_value(self.m_model_body_prop, model_name);
			self:set_property_value_by_name("rag_doll_model", model_name.."_rd");
		end
	end	

	self.m_model_body = self:add_model(model_name, false );
	--self:hide_model(self.m_model_body, false);

	self.m_legs_bones = self:add_bones_group(self.m_model_body, LEGS_BONE_GROUP);
	self.m_torso_bones = self:add_bones_group(self.m_model_body, TORSO_BONE_GROUP);

	-- FSM, который описывает состояние тела, 
	-- состояния вызывают проигрывание анимаций и звуков
	self.body_fsm = self:add_fsm("body_fsm");
	self.legs_fsm = self:add_fsm("legs_fsm");
	
	-- состояния пустышки, которые ничего не делают
	self.empty_body_state = self:add_fsm_state(self.body_fsm, "empty", self.on_enter_empty_body, self.on_update_empty_body, self.on_exit_empty_body, self.is_finished_empty_body);
	self.empty_legs_state = self:add_fsm_state(self.legs_fsm, "empty", self.on_enter_empty_legs, self.on_update_empty_legs, self.on_exit_empty_legs, self.is_finished_empty_legs);
	-- idle states
	self.idle_state	= self:add_fsm_state(self.body_fsm, "idle", self.on_enter_idle, self.on_update_idle, self.on_exit_idle, self.is_finished_idle);
	-- pain
	self.pain_state	= self:add_fsm_state(self.body_fsm, "pain", self.on_enter_pain, self.on_update_pain, self.on_exit_pain, self.is_finished_pain);
	-- death
	self.death_state = self:add_fsm_state(self.body_fsm, "death", self.on_enter_death, self.on_update_death, self.on_exit_death, self.is_finished_death);
	-- walk states
	self.forward_walk_state	= self:add_fsm_state(self.legs_fsm, "forward_walk", self.on_enter_forward_walk, self.on_update_forward_walk, self.on_exit_forward_walk, self.is_finished_forward_walk);
	self.backward_walk_state = self:add_fsm_state(self.legs_fsm, "backward_walk", self.on_enter_backward_walk, self.on_update_backward_walk, self.on_exit_backward_walk, self.is_finished_backward_walk);
	self.strafe_left_walk_state = self:add_fsm_state(self.legs_fsm, "strafe_left_walk", self.on_enter_strafe_left_walk, self.on_update_strafe_left_walk, self.on_exit_strafe_left_walk, self.is_finished_strafe_left_walk);
	self.strafe_right_walk_state = self:add_fsm_state(self.legs_fsm, "strafe_right_walk", self.on_enter_strafe_right_walk, self.on_update_strafe_right_walk, self.on_exit_strafe_right_walk, self.is_finished_strafe_right_walk);
	-- run states
	self.forward_run_state	= self:add_fsm_state(self.legs_fsm, "forward_run", self.on_enter_forward_run, self.on_update_forward_run, self.on_exit_forward_run, self.is_finished_forward_run);
	self.backward_run_state = self:add_fsm_state(self.legs_fsm, "backward_run", self.on_enter_backward_run, self.on_update_backward_run, self.on_exit_backward_run, self.is_finished_backward_run);
	self.strafe_left_run_state = self:add_fsm_state(self.legs_fsm, "strafe_left_run", self.on_enter_strafe_left_run, self.on_update_strafe_left_run, self.on_exit_strafe_left_run, self.is_finished_strafe_left_run);
	self.strafe_right_run_state = self:add_fsm_state(self.legs_fsm, "strafe_right_run", self.on_enter_strafe_right_run, self.on_update_strafe_right_run, self.on_exit_strafe_right_run, self.is_finished_strafe_right_run);
	-- jump state
	self.jump_state = self:add_fsm_state(self.body_fsm, "jump", self.on_enter_jump, self.on_update_jump, self.on_exit_jump, self.is_finished_jump);
	-- fall state
	self.fall_state = self:add_fsm_state(self.body_fsm, "fall", self.on_enter_fall, self.on_update_fall, self.on_exit_fall, self.is_finished_fall);
	-- land state
	self.land_state = self:add_fsm_state(self.body_fsm, "land", self.on_enter_land, self.on_update_land, self.on_exit_land, self.is_finished_land);
	
	
	-- различные варианты атаки
	-- на месте
	self.attack_state = self:add_fsm_state(self.body_fsm, "attack", self.on_enter_attack, self.on_update_attack, self.on_exit_attack, self.is_finished_attack);
	-- на бегу
	self.attack_run_state = self:add_fsm_state(self.body_fsm, "attack_run", self.on_enter_attack_run, self.on_update_attack_run, self.on_exit_attack_run, self.is_finished_attack_run);
	-- после прыжка
	self.attack_jump_state = self:add_fsm_state(self.body_fsm, "attack_jump", self.on_enter_attack_jump, self.on_update_attack_jump, self.on_exit_attack_jump, self.is_finished_attack_jump);
	self.attack_jump_fall_state = self:add_fsm_state(self.body_fsm, "attack_jump_fall", self.on_enter_attack_jump_fall, self.on_update_attack_jump_fall, self.on_exit_attack_jump_fall, self.is_finished_attack_jump_fall);
	self.attack_jump_land_state = self:add_fsm_state(self.body_fsm, "attack_jump_land", self.on_enter_attack_jump_land, self.on_update_attack_jump_land, self.on_exit_attack_jump_land, self.is_finished_attack_jump_land);
	-- выстрел	
	self.attack_shot_state = self:add_fsm_state(self.body_fsm, "attack_shot", self.on_enter_attack_shot, self.on_update_attack_shot, self.on_exit_attack_shot, self.is_finished_attack_shot);
	-- стрельба очередью
	self.attack_shot_burst_state = self:add_fsm_state(self.body_fsm, "attack_shot_burst", self.on_enter_attack_shot_burst, self.on_update_attack_shot_burst, self.on_exit_attack_shot_burst, self.is_finished_attack_shot_burst);
	-- выстрел на бегу
	self.attack_shot_run_state = self:add_fsm_state(self.body_fsm, "attack_shot_run", self.on_enter_attack_shot_run, self.on_update_attack_shot_run, self.on_exit_attack_shot_run, self.is_finished_attack_shot_run);
	-- перезарядка оружия
	self.reload_state = self:add_fsm_state(self.body_fsm, "reload", self.on_enter_reload, self.on_update_reload, self.on_exit_reload, self.is_finished_reload);
	-- вместо атаки отыгрываем одну анимацию
	self.attack_anim_state = self:add_fsm_state(self.body_fsm, "attack_anim", self.on_enter_attack_anim, self.on_update_attack_anim, self.on_exit_attack_anim, self.is_finished_attack_anim);
	
	-- переход из одного положения в другое
	self.transition_state = self:add_fsm_state(self.body_fsm, "transition", self.on_enter_transition, self.on_update_transition, self.on_exit_transition, self.is_finished_transition);
	
	self:prepare_visual_state_info();
	
end



function actor_basic:is_player_controlled()
	return self:get_property_value(self.m_is_player_controlled_prop);
end

function actor_basic:is_sitting()
	return self:get_property_value(self.m_is_sitting_prop);
end



------------------------------------
-- серверная часть 
sv_actor_basic = utils.inherit(sv_game_object, actor_basic);

function sv_actor_basic:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	actor_basic.register_properties(self, prop_registry);

	-- Входящие слоты	
	self.in_set_guard_slot = self:register_input_slot("set_guard", self.set_guard, "target = \"name_of_entity\", time = -1, radius = 3, ignore_enemies = true, run = 1");
	self.in_reset_guard_slot = self:register_input_slot("reset_guard", self.reset_guard);
	self.in_set_attack_type_slot = self:register_input_slot("set_attack_type", self.set_attack_type, "attack_type = 1, status = 0");
	self.in_ignore_enemies = self:register_input_slot("ignore_enemies", self.ignore_enemies, "ignore = true");
			
	-- Исходящие слоты
	self.out_alert = self:register_output_slot("on_alert", nil);
	------------------------
	self.m_block_movement_prop	= self:get_property_by_name("block_movement");
	self.m_block_turn_prop	= self:get_property_by_name("block_turn");
	self.m_is_dead_prop = self:get_property_by_name("is_dead");
end

function sv_actor_basic:is_dead()
	return self:get_property_value(self.m_is_dead_prop);
end


--------------------------------------
-- обработчики слотов
--------------------------------------
function sv_actor_basic:set_guard(sender, activator, input_data)
	self:send_callback(CALLBACK_GUARD, 1, input_data);
end

function sv_actor_basic:reset_guard(sender, activator, input_data)
	self:send_callback(CALLBACK_GUARD, 0, nil);
end

function sv_actor_basic:set_attack_type(sender, activator, input_data)
	self:send_callback(CALLBACK_SET_ATTACK_TYPE, input_data.attack_type, input_data.status);
end

-- установка эксклюзивного режима атаки при вызове команды set_enemy
function sv_actor_basic:in_set_enemy(sender, activator, input_data)
	if(input_data.attack_type > 0) then
		self:send_callback(CALLBACK_SET_ATTACK_TYPE, input_data.attack_type, 1);
	end	
end

function sv_actor_basic:ignore_enemies(sender, activator, input_data)
	if(input_data.ignore == true) then
		self:send_callback(CALLBACK_IGNORE_ENEMIES, 1);
		self:set_idle("idle", 0)
	else
		self:send_callback(CALLBACK_IGNORE_ENEMIES, 0);	
	end
end

--------------------------------------
function sv_actor_basic:block_carrier_movement(is_true)
	if(self.io.m_original_block_carrier_movement ~= true) then
		self:set_property_value(self.m_block_movement_prop, is_true);
	end	
end

function sv_actor_basic:block_carrier_turn(is_true)
	if(self.io.m_original_block_carrier_turn ~= true) then
		self:set_property_value(self.m_block_turn_prop, is_true);
	end	
end

---------------------------------------
function sv_actor_basic:stop_movement()
	self.m_performed_forward = 0;
	self.m_performed_backward = 0;
	self.m_performed_left = 0;
	self.m_performed_right = 0;
	self.m_performed_up = 0;
	self.m_performed_down = 0;
end

-- функции нужно вызвать при начале и завершении атаки
function sv_actor_basic:begin_attack()
	--if(self.io.m_attack_has_begin == true) then
	--	engine.warning(" attack has already started!!!! "..self:get_name());
	--end	
	
	
	--if(self.params.attack_info[self.io.m_requested_attack_idx].not_allowed == true) then
	--	engine.warning(" attack not_allowed "..self:get_name().."  "..self.io.m_requested_attack_idx);
	--end	

	self.io.m_current_attack_idx = self.io.m_requested_attack_idx;
	self.m_current_attack_info = self.params.attack_info[self.io.m_requested_attack_idx];
	
	self.m_attack_selected_visual_idx = nil;
	
	--console.print(" ------------ begin_attack self.io.m_current_attack_idx "..self.io.m_current_attack_idx.."   actor name "..self:get_name());
	
	self.io.m_wait_for_requested_attack = false;
	
	self.io.m_attack_has_begin = true;
	self:send_callback(CALLBACK_ACTION_BEGIN, ACTION_ATTACK);
	
	--console.print(" ++++++++ begin_attack")
end

function sv_actor_basic:end_attack()
	--if(self:is_attack_began() or self.io.m_wait_for_requested_attack == true)then
		self.io.m_attack_has_begin = false;
		self.io.m_wait_for_requested_attack = false;

		self:send_callback(CALLBACK_ACTION_END, ACTION_ATTACK);
		--console.print(" ++++++++ end attack")
	--end	
	--[[
	if(self.io.m_current_attack_idx) then
		console.print(" ------------ end_attack self.io.m_current_attack_idx "..self.io.m_current_attack_idx.."   actor name "..self:get_name());
		utils.traceback();
		console.print(" ------------ end_attack ");
	end
	--]]
	
	--self.io.m_current_attack_idx = nil;
	--self.m_current_attack_info = nil;
	
end


-- сигнал о том, что текущая атака должна быть резко завершена
function sv_actor_basic:halt_attack()
	if(self:is_jumping()) then return end
		
	self:end_attack();
	self:reset_body_state(true);
	--self:reset_legs_state(true);
end

function sv_actor_basic:is_attack_began()
	return self.io.m_attack_has_begin == true;
end

--------------------------------------------------
function sv_actor_basic:add_hitboxes_info()
	if(self.params.hitboxes ~= nil) then
		for i,v in ipairs(self.params.hitboxes) do
			self:add_hitbox_info(i, v.name, v.damage_k);
		end
	end
end

--------------------------------------------------
function sv_actor_basic:add_odd_ragdolls()
	if(self.params.odd_ragdolls ~= nil) then
		for i,v in ipairs(self.params.odd_ragdolls) do
			self:add_hitbox_ragdoll(v.hitbox, v.damage, v.ragdoll);
		end
	end
end

--------------------------------------------------
function sv_actor_basic:on_init()
	self:init_properties_from_table(self.properties_design);
	
	sv_game_object.on_init(self);
	actor_basic.on_init(self);

	self:hide_model(self.m_model_body, false);
	
	-- команды управления	
	self.m_forward = 0;
	self.m_backward = 0;
	self.m_left = 0;
	self.m_right = 0;
	self.m_up = 0;
	self.m_down = 0;
	self.m_acceleration = 0;
	self.m_deceleration = 0;
	
	self:stop_movement();
	
	-- запомнить ссылки на properties для быстрого доступа к ним
	self.run_forward_speed_prop		= self:get_property_by_name("run_forward_speed");
	self.run_backward_speed_prop	= self:get_property_by_name("run_backward_speed");
	self.run_strafe_speed_prop		= self:get_property_by_name("run_strafe_speed");
	self.walk_forward_speed_prop	= self:get_property_by_name("walk_forward_speed");
	self.walk_backward_speed_prop	= self:get_property_by_name("walk_backward_speed");
	self.walk_strafe_speed_prop		= self:get_property_by_name("walk_strafe_speed");
	
	self.foots_angle_prop			= self:get_property_by_name("foots_angle");
	self.torso_angle_prop			= self:get_property_by_name("torso_angle");
	self.head_angle_prop			= self:get_property_by_name("head_angle");
	
	self.turn_head_to_entity_with_id_prop = self:get_property_by_name("turn_head_to_entity_with_id");
	self.turn_body_to_entity_with_id_prop = self:get_property_by_name("turn_body_to_entity_with_id");
	
	self.m_is_player_controlled_prop = self:get_property_by_name("is_player_controlled");
	self.m_is_sitting_prop = self:get_property_by_name("is_sitting");
	
	self.m_carrier_freeze_prop = self:get_property_by_name("carrier_freeze");
	
	-- время в падении, нужно для в включения соответствующей анимации
	self.io.m_falling_time = 0;
	-- блокирование управлением carrier-ом в update
	self.io.m_block_movement = false;
	-- разрешение отыгрывания анимации pain
	self.io.m_pain_allowed = true;
	
	-- индекс текущей атаки
	self.io.m_current_attack_idx = nil;
	self.m_current_attack_info = nil;
	
	-- Текущая idle-анимация
	self.m_cur_idle_name = "idle";
	-- Время, в течение которого будет активна текущая idle-анимация
	-- Если время равно нулю, то активной становится анимация с именем "idle"
	self.m_idle_time_left = 0;
	
	-- коэффициент на скорость перемещения
	self.m_walk_speed_k = 1;
	
	
	-- поддерживаемые callbacks	
	self:register_callback(CALLBACK_WALK_HERE);
	self:register_callback(CALLBACK_GUARD);
	self:register_callback(CALLBACK_NEED_TO_RELOAD);
	self:register_callback(CALLBACK_SET_ATTACK_TYPE);
	self:register_callback(CALLBACK_IGNORE_ENEMIES);
	
	self:add_hitboxes_info();
	
	self:add_odd_ragdolls();
	
	-- Таблица для хранения эффектов выстрела
	self.m_shoot_effects = {}
	
	self:init_attacks();
	self:init_moving_states();
	self:init_inventory();
	
	--.hack чтобы reset_legs_state смог сбросить анимацию ног
	self.m_legs_anim_idx = 0

	--self:reset_legs_state();
	--self:reset_body_state();
	
	-- callback для проигрывания звука шагов
	if(self.params.states_with_step_callbacks) then
		for i,v in pairs(self.params.states_with_step_callbacks) do 
			self:set_callback_on_visual_state(v, nil, "step1", self.step_callback, {});
			self:set_callback_on_visual_state(v, nil, "step2", self.step_callback, {});
		end
	end	

	-- актер находится в некоторой начальной позе
	local custom_trans_to_alert_state_name = self:get_property_value(self.m_custom_transition_to_alert_prop);
	if(custom_trans_to_alert_state_name == "?" or custom_trans_to_alert_state_name == " " or custom_trans_to_alert_state_name == "") then
		self.io.m_in_custom_idle = nil;
		self:reset_legs_state();
		self:reset_body_state();
	else
		self.io.m_in_custom_idle = true;
		self.io.m_pain_allowed = false;
		--self:reset_body_state();
		local custom_idle_state_name = self:get_property_value(self.m_custom_idle_prop);
		if(custom_idle_state_name ~= "?" and custom_idle_state_name ~= " " and custom_idle_state_name ~= "") then
			self:set_idle(custom_idle_state_name, 0);
		end

		self:reset_legs_state();
		self:reset_body_state();
		self:set_idle("idle", 0);
	end

	-- перключиться в другой визуальный режим	
	local visual_config = self:get_property_value(self.m_visual_config_prop);
	if(visual_config ~= "?" and visual_config ~= " " and visual_config ~= "") then
		self:activate_state_config(visual_config);
	end
end

--------------------------------------------------
function sv_actor_basic:step_callback(marker_name, data)
	--console.print(" ++++++++  make a step "..marker_name);
	self:make_actor_steps();
end

-- восстановление загруженного состояния
-- put_bool, put_int, put_float, put_string
-- get_bool, get_int, get_float, get_string

function sv_actor_basic:on_load_state(dreader)
	sv_game_object.on_load_state(self,  dreader);
	
	if (dreader == nil) then 
		self.io.m_original_block_carrier_movement = self:get_property_value(self.m_block_movement_prop);
		self.io.m_original_block_carrier_turn = self:get_property_value(self.m_block_turn_prop);
	end
	
	if(self.io.m_current_attack_idx) then
		self.m_current_attack_info = self.params.attack_info[self.io.m_current_attack_idx];
	end
	
	if(self.params.death_explosion_impulse_threshold or	self.params.death_explosion_damage_threshold) then
		self:init_ragdoll_bomb(dreader);
	end
	
	-- текущее состояние тела
	if(self.io.m_current_body_state == nil) then
		self.io.m_current_body_state = NORMAL_BODY_STATE;
	end	
end

-- запись текущего состояния
function sv_actor_basic:on_save_state(dwriter)
	sv_game_object.on_save_state(self,  dwriter);
end

--------------------------------------------------
function sv_actor_basic:post_load_init()
	if(self.io.m_bomb_id) then
		self.m_bomb = engine.get_entity_by_id(self.io.m_bomb_id);
		assert(self.m_bomb, "bomb must be created!\nid: "..self.io.m_bomb_id.."\n");
	end	
end


--------------------------------------------------
function sv_actor_basic:get_walk_forward_speed()
	return self:get_property_value(self.walk_forward_speed_prop);
end
function sv_actor_basic:get_run_forward_speed()
	return self:get_property_value(self.run_forward_speed_prop);
end

--------------------------------------------------
-- Задает текущую idle-анимацию
--		idle_name	- имя idle'а в таблице states_design
--		time		- время, в течение которого данный idle будет активным
function sv_actor_basic:set_idle(idle_name, time)
	self.m_cur_idle_name = idle_name
	self.m_idle_time_left = time
end

--------------------------------------------------
-- Проигрывает анимацию прехода из одного положения в другое
--		anim_name	- имя transition'а в таблице states_design
--		next_state	- состояние в которое будет переведен FSM, после отыгрывания анимации.
--					  Если параметр не указан, то возвращаемся в то состояние, в котором находились.
--		callback	- функция, будет вызвана, после завешения перехода
--		brute_transition	- если true, то прерывает текущее состояние, не дожидаясь его завершения
function sv_actor_basic:make_transition(anim_name, next_state, callback, brute_transition)
	
	self.m_transition_anim_name = anim_name;
	
	self.io.m_pain_allowed = false;
	--console.print(" in_transition  make_transition")
	self.m_in_transition = true;
	
	local cur_state = self:get_cur_fsm_state(self.body_fsm);
	if(next_state == nil) then
		-- чтоб не было зацикливания
		if(cur_state == self.transition_state) then 
			self.m_after_transition_state = self.empty_body_state;
		else
			self.m_after_transition_state = cur_state;
		end	
	else
		self.m_after_transition_state = next_state;
	end
	
	self.m_after_transition_callback = callback;
	self:change_fsm_state(self.body_fsm, self.transition_state, brute_transition and brute_transition or false);
end

function sv_actor_basic:make_transition_without_fsm(anim_name, next_state, callback)

	self.m_transition_anim_name = anim_name;
	
	--console.print(" in_transition  make_transition_without_fsm"..anim_name)
	self.m_in_transition = true;
	
	self.m_after_transition_without_fsm_state = next_state;
	self.m_after_transition_without_fsm_callback = callback;
	
	self.io.m_pain_allowed = false;
	
	--if(self.io.m_block_movement == false) then
	--	self.io.m_block_movement = true;
	--	self.io.m_transition_block_movement = true;
	--	self:stop_movement();
	--end	

	local visual_idx, anim_length, anim_idx = self:visualize_state(nil, self.state_visual_info, self.m_transition_anim_name, nil, nil, IGNORE_TRANSITION);
	self:set_animation_end_callback(anim_idx, self.transition_end);
		
	return visual_idx, anim_length, anim_idx;
end


function sv_actor_basic:transition_end()

	
	self:reset_animation_end_callback();
	
	self.m_in_transition = false;
	
	self.io.m_pain_allowed = true;
	
	if(self.io.m_transition_block_movement == true) then
		self.io.m_block_movement = false;
		self.m_transition_block_movement = nil;
	end	
	
	if self.m_after_transition_without_fsm_state then
		self:change_fsm_state(self.body_fsm, self.m_after_transition_state, false);		
		self.m_transition_finished = true;
	end
	
	if self.m_after_transition_without_fsm_callback then
		self.m_after_transition_without_fsm_callback(self);
	end
end


-- callback на завершение анимации
function sv_actor_basic:set_animation_end_callback(anim_idx, callback_func)
	assert(callback_func ~= nil, "callback_func func must not be nil");
	self.m_callback_anim_idx = anim_idx;
	self.m_callback_anim_func = callback_func;
end

function sv_actor_basic:reset_animation_end_callback()
	self.m_callback_anim_idx = nil;
	self.m_callback_anim_func = nil;
end

function sv_actor_basic:on_animation_end(anim_idx)
	if(self.m_callback_anim_idx == anim_idx) then
		self.m_callback_anim_func(self, anim_idx);
	end
end


--------------------------------------------------
-- инициализация параметров различных видов атаки
function sv_actor_basic:init_attacks()
	assert(self.params.attack_info, "self.params.attack_info")
	

	local dissallowed_attacks_str = self:get_property_value(self.m_disallowed_attacks_prop);
	if(dissallowed_attacks_str == "all") then
		for i,v in pairs(self.params.attack_info) do v.not_allowed = true; end
	else
		local disallowed_attacks = utils.create_table_from_string(dissallowed_attacks_str);
		for i,v in pairs(disallowed_attacks) do
			local actor_attack_info = self.params.attack_info[v];
			if(actor_attack_info ~= nil) then
				--console.print(" ===== disallowed "..v);
				actor_attack_info.not_allowed = true;
			end	
		end
	end	
	
	local allowed_attacks_str = self:get_property_value(self.m_allowed_attacks_prop);
	if(allowed_attacks_str == "all") then
		for i,v in pairs(self.params.attack_info) do v.not_allowed = false; end
	else
		local allowed_attacks = utils.create_table_from_string(allowed_attacks_str);
		for i,v in pairs(allowed_attacks) do
			local actor_attack_info = self.params.attack_info[v];
			if(actor_attack_info ~= nil) then
				actor_attack_info.not_allowed = false;
			end	
		end	
	end	


	for i,v in pairs(self.params.attack_info) do
		local actor_attack_info = v;
		
		assert(actor_attack_info.allowed_bhv);
		actor_attack_info.fsm_state_ref = self:get_fsm_state(self.body_fsm, actor_attack_info.fsm_state);
		assert(actor_attack_info.fsm_state_ref);
	end
end

-------------------------------------
-- Инициализация инвентаря актера
function sv_actor_basic:init_inventory()

	local inventory = self.params.inventory
	
	local inv_str = self:get_property_value_by_name("inventory_items")
	for token in string.gfind(inv_str, "[_%w]+") do 
		-- Добавляем предметы, указанные в параметре "inventory_items" в инвентарь актера.
		local entity = engine.spawn_entity(token);
		engine.add_entity_to_world(entity);
		self:add_to_inventory(entity);
	end
	
	-- Если в свойстве "inventory_items" актера что-то указано
	-- или нет таблицы инвентаря, то ничего в инвентарь не добавляем.	
	if (inv_str ~= " ") or (type(inventory) ~= "table") then
		return
	end
	
	-- Определяем общий вес всех записей таблицы
	local total_weight = 0;
	for i, v in pairs(inventory) do
		total_weight = total_weight + (v.weight or 1);
	end
	
	-- Переводим веса в соответствующие разбиения отрезка от 0 до 1
	for i, v in ipairs(inventory) do
	
		local distribution = (v.weight or 1)/total_weight;
		if(i > 1) then
			distribution = distribution + inventory[i-1].distribution;
		end
		inventory[i].distribution = distribution;
		
	end
	
	-- Выбираем одну из записей используя вероятность
	local rnd = math.random();
	
	local selected_idx
	for i,v in ipairs(inventory) do
		selected_idx = i
		if(rnd < v.distribution) then break; end
	end
	
	-- Добавляем предметы полученного набора в инвентарь актера.
	for i, v in pairs(inventory[selected_idx].items) do
		local entity = engine.spawn_entity(v);
		engine.add_entity_to_world(entity);
		self:add_to_inventory(entity);
	end
	
end

-------------------------------------
-- создает бомбу для взрыва регдола после смерти
function sv_actor_basic:init_ragdoll_bomb(dreader)
	if(dreader == nil) then
		local bomb = engine.spawn_entity("Bomb");
		bomb:set_property_value_by_name("model_name", self.params.death_explosion_model_name);
		bomb:set_property_value_by_name("is_visible", false);
		
		bomb:set_property_value_by_name("shape", "sphere");
		bomb:set_property_value_by_name("radius", 1);
		
		bomb:set_property_value_by_name("effect", self.params.death_explosion_effect);
		bomb:set_property_value_by_name("debris_model", self.params.death_explosion_debris_model);
		
		bomb:set_property_value_by_name("auto_fall_apart", true);
		bomb:set_property_value_by_name("debris_scattering", self.params.death_explosion_debris_scattering);
		
		engine.add_entity_to_world(bomb);

		bomb:signal("hide", self);
		bomb:signal("disable_shapes", self);
		bomb:signal("disable", self);
		bomb:set_pos(self:get_pos());
		
		self.io.m_bomb_id = bomb:get_id();
	end
end

function sv_actor_basic:explode_ragdoll_bomb()
	assert(self.m_bomb);

	self.m_bomb:signal("enable", self);
	self.m_bomb:signal("show", self);
	self.m_bomb:signal("enable_shapes", self);
	
	local explode_pos;
	if(self.params.death_explosion_pos == "view") then
		explode_pos = self:get_view_pos();
	else
		explode_pos = self:get_pos();
	end	
	--explode_pos = self:get_pos();
	self.m_bomb:set_pos(explode_pos);
	
	
	self.m_bomb:set_property_value_by_name("init_object", self:get_id());
	self.m_bomb:signal("explode", self);
	self.m_bomb = nil;
	
	engine.destroy_entity(self)
end


function sv_actor_basic:remove_ragdoll_bomb()
	if(self.m_bomb) then
		--engine.destroy_entity(self.m_bomb);
		self.m_bomb = nil;	
	end
end

-------------------------------------
function sv_actor_basic:on_event(event_id, event)
	if (event_id == EVENT_WALK_HERE) then
		local pos = parse_event(event);		
		self:send_callback(CALLBACK_WALK_HERE, pos);
	end
end


function sv_actor_basic:is_pain_allowed()
	-- будем атаковать
	if(self.params.pain_can_disrupt_attack == false and
			(self.io.m_wait_for_requested_attack == true or
			self:is_attack_began())) then 
			return false;
	end
	
	local bhv_state = self:get_behavior_state();	
	if(bhv_state == BHV_WALK or bhv_state == BHV_STAND) then
		if(self.io.m_pain_allowed == true) then
			return true;
		end	
	end
	return false;
end

function sv_actor_basic:on_damage(damage, damage_type, who_id)
	self.io.m_who_did_last_damage = who_id;
	self.io.m_last_damage = damage;
	self.io.m_last_damage_type = damage_type;
	
	if(self:is_dead() == false and damage > self.params.pain_threshold) then
		local bhv_state = self:get_behavior_state();	

		if(self.state_visual_info["pain"] ~= nil) then
			
			if(self.state_visual_info["pain"].without_anims == true) then
				self.m_ai_sound_activator = who_id;
				self:visualize_state(nil, self.state_visual_info, "pain", nil, nil, IGNORE_TRANSITION);
			elseif(self:is_pain_allowed()) then
				self.m_ai_sound_activator = who_id;
				self:change_fsm_state(self.body_fsm, self.pain_state, true);
			end
		end
	end
end

--
function sv_actor_basic:on_update(dt)

	if(self.io.m_we_dead == true) then return end

	sv_game_object.on_update(dt);

	local bhv_state = self:get_behavior_state();	
	local cur_state = self:get_cur_fsm_state(self.body_fsm);
	
	if(self.io.m_in_custom_idle == true) then
		self:stand_idle_update(dt, cur_state);
		return;
	end

	self:on_bhv_update(dt, bhv_state, cur_state);
end


--------------------------------------------------------
-- запустить анимацию и звук, ассоцированные с текущим записью в таблице
function sv_actor_basic:body_state_transition_end()
	if(self.m_body_state_transition) then
		self:visualize_state(self.m_body_state_transition.fsm,
				self.m_body_state_transition.states_visual_info_table,
				self.m_body_state_transition.state_name,
				self.m_body_state_transition.visual_idx,
				self.m_body_state_transition.bone_group,
				nil, true);
		self.m_body_state_transition = nil;	
	end	
end


function sv_actor_basic:state_exists(state_name)
	return type(self.state_visual_info[state_name]) == "table";
end

-- команды, регулирущие переход состояний модели тела
ALLOW_TRANSITION = 0;
IGNORE_TRANSITION = 1;
ALLOW_TRANSITION_WITHOUT_ORIGINAL_STATE = 2;

--------------------------------------------
-- анимация и звук для состояния модели
-- переключает body_fsm
-- return visual_idx, anim_length, anim_idx;

function sv_actor_basic:visualize_state(fsm, 
					states_visual_info_table, 
					state_name, visual_idx, 
					bone_group, 
					transition_status,
					priority_for_body_group)
					
					
	local visual_info = states_visual_info_table[state_name];
	
	if(visual_info.without_anims == true) then
		transition_status = IGNORE_TRANSITION;
	end
		
	--
	if(priority_for_body_group == true) then
--		engine.warning("! "..(visual_info.primary_bone_group and visual_info.primary_bone_group or "FFF"));
		if(visual_info.primary_bone_group == TORSO_BONE_GROUP) then
			return self:visualize_state_torso(states_visual_info_table, state_name, visual_idx, transition_status);
		elseif(visual_info.primary_bone_group == LEGS_BONE_GROUP) then
			return self:visualize_state_legs(states_visual_info_table, state_name, visual_idx, transition_status);
		end
	end

	--console.print("=== visualize_state name: "..state_name.." bone_group "..(bone_group and bone_group or ""));
	--console.print("=================== visualize_state name: "..state_name.." time "..engine.get_game_time().." in transition "..(self.m_in_transition and "true" or "false"));
	

	if(type(visual_info) ~= "table") then
		--engine.warning("visual_info for state:"..state_name.." is not table,  actor name "..self:get_name());
		if(fsm) then self:set_fsm_update_time(fsm, 1); end	
		return 1, 1, 1;
	end	
	
	-- блокируем последовательное появление двух одинаковых анимаций
	local block_doubles = (visual_info.block_doubles == nil) and true or visual_info.block_doubles;

	-- выбрать одну из записей используя вероятность
	local rnd = math.random();
	
	if(visual_idx == nil) then
		local visuals_size = table.getn(visual_info);
		for i,v in ipairs(visual_info) do
			visual_idx = i;
			if(rnd < v.distribution) then 
			
				if(block_doubles == true and visual_idx == visual_info.last_visual_idx) then
					-- с вероятностью 1/2 выбираем предыдущею или следующею анимацию
					if(math.random() > 0.5) then
						visual_idx = ((i - 1) > 1) and (i - 1) or 1;
					else
						visual_idx = ((i + 1) < visuals_size) and (i+1) or visuals_size;
					end
				end
				break; 
			end
		end
	else
		if(visual_idx > table.getn(visual_info) or visual_idx < 1) then
			--engine.warning(" wrong visual_idx "..visual_idx..", for visualize_state name: "..state_name);
			visual_idx = 1;
		end	
	end
	visual_info.last_visual_idx = visual_idx;
	
	
	
	--.hack кто-то сбрасывает self.io.m_current_body_state в nil
	if(self.io.m_current_body_state == nil) then 
		self.io.m_current_body_state = NORMAL_BODY_STATE;
	end
	-- если прописан переход в другое состояние модели - включить его
	local transition = self.params.body_states_transistions[self.io.m_current_body_state][visual_info.body_state];
	if(transition_status ~= IGNORE_TRANSITION and transition) then
		assert(self.io.m_current_body_state ~= visual_info.body_state);
		--console.print(" transition "..transition.." cur "..self.io.m_current_body_state.." new "..visual_info.body_state);
 		--engine.warning(" transition "..transition.." cur "..self.io.m_current_body_state.." new "..visual_info.body_state.." trans "..transition);
	
		local anim_idx, anim_length = 0;
		
		self.io.m_current_body_state = visual_info.body_state;
		local trans_visual_idx, trans_anim_length, trans_anim_idx = self:make_transition_without_fsm(transition, nil, self.body_state_transition_end);
				
		local anim_info = visual_info[visual_idx].anim_info;
		if(anim_info) then
			--console.print(" == transition  to anim_info.anim_name "..anim_info.anim_name.." "..table.getn(anim_info.anims));
			--engine.warning(" == transition  to anim_info.anim_name "..anim_info.anim_name.." "..table.getn(anim_info.anims));
			local i,v = next(anim_info.anims);
			anim_idx = v.anim;
			anim_length = self:get_animation_length_speed(anim_idx);
		end
		
		-- показываем только переход, но не запрошенный state
		if(transition_status == ALLOW_TRANSITION_WITHOUT_ORIGINAL_STATE) then
			anim_length = trans_anim_length;
			self.m_body_state_transition = nil;
		else
			-- .hack разобраться почему нужно проверять на nil trans_anim_length и anim_length
			trans_anim_length = trans_anim_length and trans_anim_length or 0;
			anim_length = anim_length and anim_length or 0;
			
			anim_length = anim_length + trans_anim_length;
			self.m_body_state_transition = {};
			self.m_body_state_transition.fsm = fsm;
			self.m_body_state_transition.states_visual_info_table = states_visual_info_table;
			self.m_body_state_transition.state_name = state_name;
			self.m_body_state_transition.visual_idx = visual_idx;
			self.m_body_state_transition.bone_group = bone_group;
		end	
		
		if(fsm) then
			self:set_fsm_update_time(fsm, anim_length);
		end
		
		return visual_idx, anim_length, anim_idx;
	else
		if(self.m_body_state_transition and
			self.m_body_state_transition.bone_group == bone_group) then
			self.m_body_state_transition = nil;
		end	
		--self.m_in_transition = false;
	end
	
	
	local anim_length, anim_idx;
	local anim_info = visual_info[visual_idx].anim_info;
	
	if(anim_info) then
		--engine.warning(" ===================== "..state_name);
		--console.print(" ===================== ");
		--console.print(" == "..state_name.." anim_info.anim_name "..anim_info.anim_name.." time "..engine.get_game_time());
			
		local last_anim;
		for i,v in pairs(anim_info.anims) do
			last_anim = v;
			--console.print(" -- try  v.anim "..v.anim);
			-- если задана bone group, то отыгрываем анимацию только на ней
			if(bone_group == nil or v.anim_bone_group == bone_group) then
	
				if(anim_info.anim_playback == ANIM_PB_ONCE or
					self:is_animation_playing(v.anim) == false) then
					--console.print(" == playing v.anim "..v.anim.." bone group "..(bone_group and bone_group or "nil"));
					self:play_animation(v.anim);
				end
			end
		end
		
		-- возвращаем все параметры относительно последней анимации,
		-- подразумевается, что все запущенные анимации одинаковые по времени
		assert(last_anim);
		anim_idx = last_anim.anim;
		anim_length = self:get_animation_length_speed(anim_idx);
	else
		anim_length = 1;
	end	
	
	if(fsm) then
		self:set_fsm_update_time(fsm, anim_length);
	end	
	
	if(self.m_dont_visualize_sound ~= true and visual_info[visual_idx].snd ~= nil) then
		self:play_sound(visual_info[visual_idx].snd,
						self.m_ai_sound_activator,
						visual_info[visual_idx].snd_play_once);
		self.m_ai_sound_activator = nil;
	end
	
	self.m_dont_visualize_sound = nil;
	
	--console.print("-- visualize_state name: "..state_name.." anim length "..anim_length);

	return visual_idx, anim_length, anim_idx;
end


function sv_actor_basic:set_callback_on_visual_state(state_name, visual_idx, marker, callback_func, user_data)
	local visual_info = self.state_visual_info[state_name];
	assert(type(visual_info) == "table", "visual_info for state:"..state_name.." is not table");
	
	if(visual_idx == nil) then
		for i,v in ipairs(visual_info) do
			local anim_info = visual_info[i].anim_info;
			for j,w in pairs(anim_info.anims) do
				self:set_anim_callback(w.anim, marker, callback_func, user_data);
			end
		end
	else
		self:set_anim_callback(visual_info[visual_idx].anim_info, marker, callback_func, user_data);
	end
end


--------------------------------------------------
--[[	Загружает эффект, появляющийся при выстреле

Возвращает:
	handle эффекта (НЕ effect_id !), который впоследствии может быть передан функции
	visualize_shoot_effect для отображения эффекта.
	
	-1, если эффект не был загружен.
--]]
function sv_actor_basic:load_shoot_effect(shoot_effect)

	local effect_handle = -1
	
	assert(type(shoot_effect) == "table", "shoot_effect is not a table");
	
	-- Таблица, которая хранит id загруженных эффектов.
	-- Будет добавлена в m_shoot_effects, если все эффекты будут 
	-- успешно загружены.
	local effect_tbl = {}
	
	-- Перебираем точки привязки
	for ref_point_name, effects in pairs(shoot_effect) do
	
		assert(type(ref_point_name) == "string", "ref_point_name is not a string");
		assert(type(effects) == "table", "effects must form a table");
		
		-- Таблица эффектов, соответствующих данному ref_point'у
		effect_tbl[ref_point_name] = {}
		
		-- Перебираем эффекты данной точки привязки
		for i, v in pairs(effects) do
			assert(type(v) == "string", "effect name is not a string");
			local template_id = self:add_effect_template(v)
			local effect_id = self:create_effect(template_id, self.m_model_body, ref_point_name)
			if effect_id == -1 then
				engine.warning("cannot create effect: " .. v);
			else
				table.insert(effect_tbl[ref_point_name], effect_id)
			end
		end
		
	end
	
	-- Добавляем в конец таблицы загруженных эффектов
	table.insert(self.m_shoot_effects, effect_tbl)
	effect_handle = table.getn(self.m_shoot_effects)
	
	return effect_handle
end

--------------------------------------------------
-- Отображает эффект, появляющийся при выстреле
function sv_actor_basic:visualize_shoot_effect(effect_handle)

	local effect_tbl = self.m_shoot_effects[effect_handle]
	assert(effect_tbl, "wrong effect_handle")
	
	-- Отображаем эффекты для каждой точки привязки
	for ref_point_name, effects in pairs(effect_tbl) do
	
		local effects_count = table.getn(effects)
		if effects_count ~= 0 then
			-- Выбираем один из эффектов, соответствующих данной точке привязки и отображаем его
			local rnd = math.random( 1, effects_count );
			
			-- Непосредственно отображаем эффект.
			self:reset_effect(effects[rnd])
		end
		
	end
end

--------------------------------------------------
-- Деактивирует эффекты, появляющийся при выстреле
function sv_actor_basic:deactivate_shoot_effect(effect_handle)

	local effect_tbl = self.m_shoot_effects[effect_handle]
	assert(effect_tbl, "wrong effect_handle")
	
	-- Деактивируем эффекты для каждой точки привязки
	for ref_point_name, effects in pairs(effect_tbl) do
		for i, effect_id in pairs(effects) do
			self:deactivate_effect(effect_id)
		end
	end
end

----------------------------------------------------------------
-- различные варианты атаки
----------------------------------------------------------------

function sv_actor_basic:perform_attack_trace(attack_info)
	assert(attack_info);

	-- Если есть shoot_point, то используем его вместо смещения
	local shoot_point_pos;
	if(attack_info.shoot_point_tag) then
		local tag_info = self:get_tag_point_pos(attack_info.shoot_point_tag, self.m_model_body);
		shoot_point_pos = tag_info.pos;
	end
	
	local attack_offset_pos = shoot_point_pos or attack_info.offset_pos;
	local attack_dir = self:calc_target_dir(attack_offset_pos, 
											self.m_attack_target_id, 
											TARGET_TOP, 0.0);
											
	local min_dist;
	local max_dist;
	if(attack_info.real_min_dist ~= nil) then
		min_dist = attack_info.real_min_dist;
		max_dist = attack_info.real_max_dist;
	else
		min_dist = attack_info.dist;
		max_dist = attack_info.dist;
	end
	
	-- Уменьшаем обойму на количество патронов, необходимых для выстрела
	if self.io.m_current_clip_size then
		self.io.m_current_clip_size = self.io.m_current_clip_size - 1
	end
	
	-- кол-во дробинок в выстреле
	local bullets_in_shot = 1;
	if(attack_info.bullets_in_shot ~= nil) then
		bullets_in_shot = attack_info.bullets_in_shot;
	end
	
	for i = 1, bullets_in_shot, 1 do 
		self:fire_trace(attack_offset_pos,
						attack_dir, 
						min_dist, 
						max_dist,
						attack_info.damage, 
						attack_info.damage_type,
						attack_info.impulse,
						attack_info.dispersion,
						attack_info.trace_bullet_effect,
						attack_info.hit_material);
	end	
	
	-- загружаем эффект выстрела (только при первом выстреле)
	if self.m_current_attack_info.effect_handle == nil then
		if(self.m_current_attack_info.shoot_effect ~= nil) then
			self.m_current_attack_info.effect_handle = self:load_shoot_effect(self.m_current_attack_info.shoot_effect);
		end
	end
		
	-- Отображаем эффект выстрела
	if self.m_current_attack_info.effect_handle then
		self:visualize_shoot_effect(self.m_current_attack_info.effect_handle);
	end

end


function sv_actor_basic:perform_attack_missile(attack_info)
	assert(attack_info);
	
	-- Если есть shoot_point, то используем его вместо смещения
	local shoot_point_pos
	if(attack_info.shoot_point_tag) then
		local tag_info = self:get_tag_point_pos(attack_info.shoot_point_tag, self.m_model_body);
		shoot_point_pos = tag_info.pos;
	end
	
	local attack_offset_pos = shoot_point_pos or attack_info.offset_pos;
	local height_offset =  -0.30;
	
	
	-- для коррекция прицеливания при стрельбе по параболе
	if(attack_info.height_offset) then
		local dist_to_target = self:calc_target_dist(self.m_attack_target_id);
		local k = (dist_to_target - attack_info.height_offset.min_dist) / 
					(attack_info.height_offset.max_dist - attack_info.height_offset.min_dist);
		
		k = k > 1 and 1 or k;
		k = k < 0 and 0 or k;
		
		height_offset = attack_info.height_offset.min_height + 
				(attack_info.height_offset.max_height - attack_info.height_offset.min_height) * k * k;
		
		--console.print(" ------ dist_to_target "..dist_to_target.." height_offset "..height_offset)
	end
		
	local attack_dir = self:calc_target_dir(attack_offset_pos, 
											self.m_attack_target_id, 
											TARGET_TOP, height_offset);
	self:fire_missile(attack_offset_pos, attack_dir, 
					attack_info.missile, 
					attack_info.dispersion,
					attack_info.missile_velocity,
					attack_info.missile_angular_velocity);
					
	-- загружаем эффект выстрела (только при первом выстреле)
	if self.m_current_attack_info.effect_handle == nil then
		if(self.m_current_attack_info.shoot_effect ~= nil) then
			self.m_current_attack_info.effect_handle = self:load_shoot_effect(self.m_current_attack_info.shoot_effect);
		end
	end
		
	-- Отображаем эффект выстрела
	if self.m_current_attack_info.effect_handle then
		self:visualize_shoot_effect(self.m_current_attack_info.effect_handle);
	end
end

--------------------------------------------------
-- смерть персонажа
function sv_actor_basic:death_end()
	self:activate_death(0, true);
end

--------------------------------------------------
function sv_actor_basic:on_death(who_id)
	if(self.io.m_we_dead == true) then return end
	self.io.m_we_dead = true;
	
	local total_impulses = self:calc_total_impulses();
	local total_damage = self:calc_total_damage();
	
	-- взрыв регдола
	if((self.params.death_explosion_impulse_threshold  and 
		total_impulses > self.params.death_explosion_impulse_threshold) or 
		(self.params.death_explosion_damage_threshold  and 
		total_damage > self.params.death_explosion_damage_threshold)) then
		self:explode_ragdoll_bomb();
		self:activate_death(0, false);
		return;
	end

	-- анимация смерти
	if(self.state_visual_info["death"] and
		total_impulses < self.params.death_impulse_threshold) then
		
		self:stop_movement();
		self:block_carrier_movement(true);
		self:block_carrier_turn(true);
		
		self:reset_legs_state(true);
		self:reset_body_state(true);
	
		self.m_ai_sound_activator = who_id;
		
		if(self.state_visual_info["death"].without_anims == true) then
			self:make_transition("death", nil, nil, true);
			self:activate_death(0, true);
		else	
			self:make_transition("death", nil, self.death_end, true);
		end
	-- просто регдол
	else
		self:activate_death(0, true);
	end	
end

--------------------------------------------------
function sv_actor_basic:on_shutdown()
	sv_game_object.on_shutdown(self)
	
	-- Освобождаем эффекты
	for i, effects in pairs(self.m_shoot_effects) do
		if type(effects) == "table" then
			for k, effect_tbl in pairs(effects) do
				if type(effect_tbl) == "table" then
					for j, effect_id in pairs (effect_tbl) do
						self:release_effect(effect_id)	
					end
				end
			end
		end
	end
	
	
	self:remove_ragdoll_bomb();
end


------------------------------------
function sv_actor_basic:activate_state_config(config_name)
	if(type(self.config_states[config_name]) ~= "table") then 
		engine.warning(" activate_state_config "..(config_name and config_name or "nil").." is not a valid config!");
		return;
	end

	self.m_original_walk_speed_k = self.m_walk_speed_k;
	self.m_walk_speed_k = self.config_states[config_name].walk_speed_k and self.config_states[config_name].walk_speed_k or 1;


	self.m_original_state_visual_info = {};
	for i,v in pairs(self.config_states[config_name]) do
		self.m_original_state_visual_info[i] = self.state_visual_info[i];
		self.state_visual_info[i] = self.state_visual_info[v];
	end
end	

--------------------------------------------------
function sv_actor_basic:restore_state_config()
	if(type(self.m_original_state_visual_info) ~= "table") then return end
	
	self.m_walk_speed_k = self.m_original_walk_speed_k and self.m_original_walk_speed_k or 1;
	for i,v in pairs(self.m_original_state_visual_info) do
		self.state_visual_info[i] = v;
	end
end	


------------------------------------
-- клиентская
cl_actor_basic = utils.inherit(cl_game_object, actor_basic);

--------------------------------------------------
function cl_actor_basic:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	actor_basic.register_properties(self, prop_registry);
end

--------------------------------------------------
function cl_actor_basic:on_init()
	cl_game_object.on_init(self);
	actor_basic.on_init(self);
	self:set_model_cast_shadows(self.m_model_body, true);
end

--------------------------------------------------
function cl_actor_basic:on_post_anims_init()
	self:set_model_gross_cull(self.m_model_body, false);
end

