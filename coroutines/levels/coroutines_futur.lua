-------------------------------------------------------------------------------
COROUTINE_VIDEO_CLIP(futur, final_video, "avi_vstrecha", "vstrecha5", 0, "fade_in", nil, 1500)

-- Начало уровня
-------------------------------------------------------------------------------
function coroutines.futur.on_level_start:run()

	-- Фейд
	local pp_id = engine.get_post_process_id("fade_out_long");
	if pp_id ~= -1 then
		g_actor_player:apply_post_process(pp_id)
	end
	
	coroutines.levels_common.on_level_start.run(self)
end

-- Конец уровня
-------------------------------------------------------------------------------
function coroutines.futur.on_level_end:run()
	-- Запускаем видеоролик
	execute_coroutine("futur.final_video")
end

-------------------------------------------------------------------------------
function coroutines.futur.final_video.m_on_end_cinema()

	coroutines.levels_common.on_level_end.run(self)
end