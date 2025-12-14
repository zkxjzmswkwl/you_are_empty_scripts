-------------------------------------------------------------------------------
-- прототипы сопрограмм, предназначенные для наследования
-------------------------------------------------------------------------------
coroutines.prototypes = {}

-------------------------------------------------------------------------------
-- анимационная сцена
-------------------------------------------------------------------------------
coroutines.prototypes.animation_scene = {}
coroutines.prototypes.animation_scene.m_scene = nil					-- имя файла с описанием сцены
coroutines.prototypes.animation_scene.m_sound = nil					-- имя файла звука
coroutines.prototypes.animation_scene.m_fade_time = 1500			-- время фейда
coroutines.prototypes.animation_scene.m_start_immediately = false	-- если true, то начинать сразу синематику, без начального фейда
coroutines.prototypes.animation_scene.m_on_begin_cinema = nil		-- callback на старт анимации
coroutines.prototypes.animation_scene.m_on_end_cinema = nil			-- callback на конец анимации

function coroutines.prototypes.animation_scene:init()
	assert(self.m_scene)

	self.m_pp_fade_in		= engine.get_post_process_id("fade_in")
	self.m_pp_fade_in_inf	= engine.get_post_process_id("fade_in_inf")
	self.m_pp_fade_out		= engine.get_post_process_id("fade_out")

	-- спавним анимацию
	self.m_anim = engine.spawn_entity("AnimationScene")
	self.m_anim:set_property_value_by_name("ds2sn_file", self.m_scene)
	self.m_anim:set_property_value_by_name("self_control", false)
	self.m_anim:set_property_value_by_name("hud_hide", false)
	engine.add_entity_to_world(self.m_anim)
	
	-- спавним звук
	self.m_snd = nil
	if self.m_sound then
		self.m_snd = engine.spawn_entity("SoundSource")
		self.m_snd:set_property_value_by_name("filename0", self.m_sound)
		self.m_snd:set_property_value_by_name("head_mode", true)
		engine.add_entity_to_world(self.m_snd)
	end
end

function coroutines.prototypes.animation_scene:run()
	assert(self.m_scene)

	g_world_props:signal("lock_players")
	
	if self.m_start_immediately == false and g_actor_player then
		-- уход в черное
		g_actor_player:apply_post_process(self.m_pp_fade_in)
		wait(self.m_fade_time)
	end
	
	-- начало проигрывания	
	if self.m_on_begin_cinema ~= nil then self.m_on_begin_cinema() end
	engine.set_var("hud_render", 0)
	self.m_anim:signal("play")
	if self.m_snd then self.m_snd:signal("play", nil, {fade_time = self.m_fade_time}) end

	-- выход в светлое
	self.m_anim:apply_post_process(self.m_pp_fade_out)

	-- ждем пока доиграет почти до конца, когда надо включать постпроцесс
	local anim_time = self.m_anim:get_property_value_by_name("anim_time")
	wait(anim_time-self.m_fade_time)

	-- уход в черное и затихание звука	
	self.m_anim:apply_post_process(self.m_pp_fade_in_inf)
	if self.m_snd then self.m_snd:signal("stop", nil, {fade_time = self.m_fade_time}) end
	wait(self.m_fade_time)

	-- конец проигрывания
	if self.m_on_end_cinema ~= nil then self.m_on_end_cinema() end
	engine.set_var("hud_render", 1)
	g_world_props:signal("unlock_players")

	-- выход в светлое
	if g_actor_player then
		g_actor_player:apply_post_process(self.m_pp_fade_out)
	end
end

function coroutines.prototypes.animation_scene:shutdown()
	-- удалим объекты
	engine.destroy_entity(self.m_anim)
	if self.m_snd then engine.destroy_entity(self.m_snd) end
end

-------------------------------------------------------------------------------
-- MAP		- имя карты
-- NAME		- имя сопрограммы
-- SCENE	- имя файла синематики
-- SOUND	- имя файла звука
-- IMM		- стартовать сразу синематику, без начального фейда
-------------------------------------------------------------------------------
#define_begin COROUTINE_ANIMATION_SCENE(MAP, NAME, SCENE, SOUND, IMM)
	if coroutines.MAP == nil then
		coroutines.MAP = {}
	end
	
	coroutines.MAP.NAME = utils.inherit(coroutines.prototypes.animation_scene)
	function coroutines.MAP.NAME:init()
		self.m_scene = SCENE
		self.m_sound = SOUND
		self.m_start_immediately = IMM
		coroutines.prototypes.animation_scene.init(self)
	end
#define_end

-------------------------------------------------------------------------------
-- видео ролик
-------------------------------------------------------------------------------
coroutines.prototypes.video_clip = {}
coroutines.prototypes.video_clip.m_preset_name = nil			-- имя пресета для проигрывания видео
coroutines.prototypes.video_clip.m_sound = nil					-- имя файла звука
coroutines.prototypes.video_clip.m_sound_volume = 0				-- громкость звука
coroutines.prototypes.video_clip.m_fade_in_name = "fade_in"		-- имя начального постпроцесса
coroutines.prototypes.video_clip.m_fade_out_name = "fade_out"	-- имя конечного постпроцесса 
coroutines.prototypes.video_clip.m_fade_time = 1500				-- длительность постпроцесса

coroutines.prototypes.video_clip.m_on_begin_cinema = nil		-- callback на старт анимации
coroutines.prototypes.video_clip.m_on_end_cinema = nil			-- callback на конец анимации

function coroutines.prototypes.video_clip:init()

	if self.m_fade_in_name then
		self.m_pp_fade_in_id = engine.get_post_process_id(self.m_fade_in_name);
	end
	
	if self.m_fade_out_name then
		self.m_pp_fade_out_id = engine.get_post_process_id(self.m_fade_out_name);
	end
	
end

function coroutines.prototypes.video_clip:run()

	-- Постпроцесс в начале проигрывания видео		
	if self.m_fade_in_name and self.m_pp_fade_in_id ~= -1 then
		g_actor_player:apply_post_process(self.m_pp_fade_in_id)
		
		-- Ждем, пока закончится проигрываться постпроцесс
		wait(self.m_fade_time)
	end
	
	-- Постпроцесс в конце проигрывания видео		
	if self.m_fade_out_name and self.m_pp_fade_out_id ~= -1 then
		-- Постпроцесс будет назначен, но проиграется только после завершения play_video. 
		-- play_video ставит игру на паузу. Постпроцесс начнет отыгрываться 
		-- только когда игра будет снята с паузы. А это произодет после завершения play_video.
		g_actor_player:apply_post_process(self.m_pp_fade_out_id)
	end
	
	-- Проигрываем видео
	if self.m_preset_name then
		engine.play_video(self.m_preset_name, self.m_sound, self.m_sound_volume)
	end
	
	-- После вызова play_video игровое время ставится на паузу
	-- и снимается с паузы после того, как видео перестанет проигрываться.
	-- Делаем вызов функции wait для того, чтобы код продолжил выполнение
	-- с этого места, после окончания проигрывания видео.
	wait(0)
	
	-- конец проигрывания
	if self.m_on_end_cinema ~= nil then 
		self.m_on_end_cinema() 
	end
end

function coroutines.prototypes.video_clip:shutdown()
end

-------------------------------------------------------------------------------
-- MAP				- имя карты
-- NAME				- имя сопрограммы
-- PRESET			- имя пресета для проигрывания 
-- SOUND			- имя файла звука
-- SOUND_VOLUME		- громкость звука
-- FADE_IN_NAME		- имя начального постпроцесса
-- FADE_OUT_NAME	- имя конечного постпроцесса 
-- FADE_TIME		- длительность постпроцесса
-------------------------------------------------------------------------------
#define_begin COROUTINE_VIDEO_CLIP(MAP, NAME, PRESET, SOUND, SOUND_VOLUME, FADE_IN_NAME, FADE_OUT_NAME, FADE_TIME)
	if coroutines.MAP == nil then
		coroutines.MAP = {}
	end
		
	coroutines.MAP.NAME = utils.inherit(coroutines.prototypes.video_clip)
	
	function coroutines.MAP.NAME:init()
		self.m_preset_name = PRESET
		self.m_sound = SOUND or "no_sound"
		self.m_sound_volume = SOUND_VOLUME
		self.m_fade_in_name = FADE_IN_NAME
		self.m_fade_out_name = FADE_OUT_NAME
		self.m_fade_time = FADE_TIME

		coroutines.prototypes.video_clip.init(self)
	end
	
#define_end


---------------------------------------------------------------------------
-- Провал миссии
---------------------------------------------------------------------------
coroutines.prototypes.mission_failed = {}

-- 0мс: Смерть, упала камера на землю 
-- 0мс: Сразу (в течении 500мс) наступает fade_in
-- 500мс: появляется надпись в нижней части экрана "Вы не успели сделать то что надо..." (появлять ее в течении 1500мс)
-- 2000мс: появляется окно on_death_меню...

---------------------------------------------------------------------------
function coroutines.prototypes.mission_failed:init()	
end 

---------------------------------------------------------------------------
function coroutines.prototypes.mission_failed:run()

	-- Постпроцесс
	if self.m_fade_in_name ~= nil then
		g_world_props:signal("apply_single_player_pp", nil, {pp_name = ""..self.m_fade_in_name})
		wait(self.m_fade_in_time)
	end
	
	g_world_props:signal("mission_failed", nil, {description = ""..self.m_description})
	
	-- Замедляем игровое время
	g_world_props:signal("set_time_scale", nil, {target_scale = self.m_time_scale, time_in = self.m_time_in, duration = 0, time_out = 0})
	
end 

-------------------------------------------------------------------------------
-- Шаблон подпрограммы mission_failed
-------------------------------------------------------------------------------
-- NAMESPACE		- имя пространства имен
-- NAME				- имя сопрограммы
-- FADE_IN_NAME		- имя проигрываемого постпроцесса
-- FADE_IN_TIME		- длительность постпроцесса в мс, как она указана в postprocesses.lua
-- TIME_SCALE		- коэффициент масштабирования игрового времени
-- TIME_IN			- время, в течение которого выполняется переход к TIME_SCALE
-- DESCRIPTION		- причина провала миссии. Строка из ui_strings.txt
-------------------------------------------------------------------------------
#define_begin COROUTINE_MISSION_FAILED(NAMESPACE, NAME, FADE_IN_NAME, FADE_IN_TIME, TIME_SCALE, TIME_IN, DESCRIPTION)
	if coroutines.NAMESPACE == nil then
		coroutines.NAMESPACE = {}
	end
	
	coroutines.NAMESPACE.NAME = utils.inherit(coroutines.prototypes.mission_failed)
	
	function coroutines.NAMESPACE.NAME:init()
		self.m_fade_in_name = FADE_IN_NAME
		self.m_fade_in_time = FADE_IN_TIME
		self.m_time_scale	= TIME_SCALE
		self.m_time_in		= TIME_IN
		self.m_description	= DESCRIPTION
		coroutines.prototypes.mission_failed.init(self)
	end
#define_end


-------------------------------------------------------------------------------
-- комикс
-------------------------------------------------------------------------------
coroutines.prototypes.comics = {}
coroutines.prototypes.comics.m_comics_filename = nil		-- имя комикса
coroutines.prototypes.comics.m_show_controls = true			-- отображать ли кнопки управления
coroutines.prototypes.comics.m_fade_in_name = "fade_in"		-- имя начального постпроцесса
coroutines.prototypes.comics.m_fade_out_name = "fade_out"	-- имя конечного постпроцесса 
coroutines.prototypes.comics.m_fade_time = 1500				-- длительность постпроцесса

coroutines.prototypes.comics.m_on_begin_comics = nil		-- callback на старт комикса
coroutines.prototypes.comics.m_on_end_comics = nil			-- callback на конец комикса

function coroutines.prototypes.comics:init()

	if self.m_fade_in_name then
		self.m_pp_fade_in_id = engine.get_post_process_id(self.m_fade_in_name);
	end
	
	if self.m_fade_out_name then
		self.m_pp_fade_out_id = engine.get_post_process_id(self.m_fade_out_name);
	end

end

function coroutines.prototypes.comics:run()

	-- Постпроцесс в начале проигрывания комикса		
	if self.m_fade_in_name and self.m_pp_fade_in_id ~= -1 then
		g_actor_player:apply_post_process(self.m_pp_fade_in_id)
		
		-- Ждем, пока закончится проигрываться постпроцесс
		wait(self.m_fade_time)
	end
	
	-- Постпроцесс в конце проигрывания комикса		
	if self.m_fade_out_name and self.m_pp_fade_out_id ~= -1 then
		-- Постпроцесс будет назначен, но проиграется только после завершения play_comics. 
		-- play_comics ставит игру на паузу. Постпроцесс начнет отыгрываться 
		-- только когда игра будет снята с паузы. А это произодет после завершения play_comics.
		g_actor_player:apply_post_process(self.m_pp_fade_out_id)
	end

	-- Проигрываем видео
	if self.m_comics_filename then
		engine.play_comics(self.m_comics_filename, self.m_show_controls)
	end
	
	-- После вызова play_comics игровое время ставится на паузу
	-- и снимается с паузы после того, как комикс перестанет проигрываться.
	-- Делаем вызов функции wait для того, чтобы код продолжил выполнение
	-- с этого места, после окончания проигрывания комикса.
	wait(0)
	
	-- конец проигрывания
	if self.m_on_end_comics ~= nil then 
		self.m_on_end_comics() 
	end
end

function coroutines.prototypes.comics:shutdown()
end

-------------------------------------------------------------------------------
-- MAP				- имя карты
-- NAME				- имя сопрограммы
-- FILENAME			- имя комикса
-- SHOW_CONTROLS	- отображать ли кнопки управления
-- FADE_IN_NAME		- имя начального постпроцесса
-- FADE_OUT_NAME	- имя конечного постпроцесса 
-- FADE_TIME		- длительность постпроцесса
-------------------------------------------------------------------------------
#define_begin COROUTINE_COMICS(MAP, NAME, FILENAME, SHOW_CONTROLS, FADE_IN_NAME, FADE_OUT_NAME, FADE_TIME)
	if coroutines.MAP == nil then
		coroutines.MAP = {}
	end
		
	coroutines.MAP.NAME = utils.inherit(coroutines.prototypes.comics)
	
	function coroutines.MAP.NAME:init()
		self.m_comics_filename = FILENAME
		self.m_show_controls = SHOW_CONTROLS
		self.m_fade_in_name = FADE_IN_NAME
		self.m_fade_out_name = FADE_OUT_NAME
		self.m_fade_time = FADE_TIME

		coroutines.prototypes.comics.init(self)
	end
	
#define_end

-------------------------------------------------------------------------------
-- test
-------------------------------------------------------------------------------
COROUTINE_ANIMATION_SCENE(aitest1, anim_test, "test_scene", nil, true)

--[[
coroutines.aitest1.on_level_start = {}
function coroutines.aitest1.on_level_start:init()
	g_world_props:signal("execute_coroutine", nil, {name = "aitest1.anim_test"})
end

function coroutines.aitest1.anim_test.m_on_begin_cinema()
--	engine.warning("m_on_begin_cinema")
end

function coroutines.aitest1.anim_test.m_on_end_cinema()
--	engine.warning("m_on_end_cinema")
end
--]]
 