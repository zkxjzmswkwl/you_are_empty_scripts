-------------------------------------------------------------------------------
COROUTINE_VIDEO_CLIP(parall_part3, final_video, "avi_work", "zavod", 0, "fade_in", nil, 1500)

-- Начало уровня
-------------------------------------------------------------------------------
function coroutines.parall.on_level_start:run()

	-- Фейд
	local pp_id = engine.get_post_process_id("fade_out_long");
	if pp_id ~= -1 then
		g_actor_player:apply_post_process(pp_id)
	end
	
	coroutines.levels_common.on_level_start.run(self)
end

-- Конец уровня
-------------------------------------------------------------------------------
function coroutines.parall_part3.on_level_end:run()
	-- Запускаем видеоролик
	execute_coroutine("parall_part3.final_video")
end

-------------------------------------------------------------------------------
function coroutines.parall_part3.final_video.m_on_end_cinema()

	coroutines.levels_common.on_level_end.run(self)
end