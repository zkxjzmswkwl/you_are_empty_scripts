-------------------------------------------------------------------------------
COROUTINE_ANIMATION_SCENE(kolhoz, startup_animation, "pobeda_enter", "Operatciya_Poezd", true)
COROUTINE_VIDEO_CLIP(kolhoz_part2, final_video, "avi_childhood", "detstvo", 0, "fade_in", nil, 1500)

-------------------------------------------------------------------------------
--Видео в конце уровня
-------------------------------------------------------------------------------
function coroutines.kolhoz_part2.on_level_end:run()
	-- Запускаем видеоролик
	execute_coroutine("kolhoz_part2.final_video")
end

-------------------------------------------------------------------------------
function coroutines.kolhoz_part2.final_video.m_on_end_cinema()

	coroutines.levels_common.on_level_end.run(self)
end

-- Начало уровня(fade_out)
-------------------------------------------------------------------------------
function coroutines.kolhoz.on_level_start:run()

	-- Фейд
	local pp_id = engine.get_post_process_id("fade_out_long");
	if pp_id ~= -1 then
		g_actor_player:apply_post_process(pp_id)
	end
	
	coroutines.levels_common.on_level_start.run(self)
end
-------------------------------------------------------------------------------
-- Начало уровня
-------------------------------------------------------------------------------
function coroutines.kolhoz.on_level_start:run()
	-- сообщаем о том, что началась игра
	engine.game_start();

	-- Запускаем анимационную сцену
	execute_coroutine("kolhoz.startup_animation")
end

-------------------------------------------------------------------------------
function coroutines.kolhoz.startup_animation.m_on_begin_cinema()
	-- запуск параллельно включение взрывов поезда
	execute_coroutine("kolhoz.explosion_sounds")
end

-------------------------------------------------------------------------------
function coroutines.kolhoz.startup_animation.m_on_end_cinema()
	signal_entity("RIGID_pobeda", "show")
	signal_entity("RIGID_pobeda", "enable")

	signal_entity("DOOR_vor1", "show")
	signal_entity("DOOR_vor1", "enable")
	signal_entity("DOOR_vor1", "lock")
	
	signal_entity("DOOR_vor2", "show")
	signal_entity("DOOR_vor2", "enable")
	signal_entity("DOOR_vor2", "lock")
	
	coroutines.levels_common.on_level_start.run(self)
end

-------------------------------------------------------------------------------
-- прибытие
-------------------------------------------------------------------------------
coroutines.kolhoz.explosion_sounds = {}

function coroutines.kolhoz.explosion_sounds:run()
	wait(7300)
	local ent1 = engine.get_entities_by_name("EXPLOID_vagon01")[1]
	ent1:signal("activate", nil, {reset = true})
	wait(500)
	local ent2 = engine.get_entities_by_name("EXPLOID_vagon")[1]
	ent2:signal("activate", nil, {reset = true})
	wait(100)
	local ent3 = engine.get_entities_by_name("EXPLOID_vagon02")[1]
	ent3:signal("activate", nil, {reset = true})
end

-------------------------------------------------------------------------------
coroutines.kol_part1_3 = coroutines.kolhoz
