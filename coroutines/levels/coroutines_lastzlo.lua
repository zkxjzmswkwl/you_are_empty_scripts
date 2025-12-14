-------------------------------------------------------------------------------
COROUTINE_VIDEO_CLIP(lastzlo, game_final_video, "avi_outro", "outro", 0, "nil", nil, 1500)

-- Начало уровня
-------------------------------------------------------------------------------
function coroutines.lastzlo.on_level_start:run()

	-- Фейд
	local pp_id = engine.get_post_process_id("fade_out_long");
	if pp_id ~= -1 then
		g_actor_player:apply_post_process(pp_id)
	end
	
	coroutines.levels_common.on_level_start.run(self)
end


-- Конец игры
-------------------------------------------------------------------------------
coroutines.lastzlo.end_game = {}

-------------------------------------------------------------------------------
function coroutines.lastzlo.end_game:run()

	-- Запускаем видеоролик
	execute_coroutine("lastzlo.game_final_video")
end

-------------------------------------------------------------------------------
function coroutines.lastzlo.game_final_video.m_on_end_cinema()
	
	-- Выходим в меню
	g_world_props:signal("disconnect")
end

