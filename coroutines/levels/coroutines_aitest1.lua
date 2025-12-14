-------------------------------------------------------------------------------
COROUTINE_VIDEO_CLIP(aitest1, startup_video, "avi_childhood", "detstvo", 0, nil, "fade_out", 1500)
COROUTINE_VIDEO_CLIP(aitest1, final_video, "avi_institute", "institut", 0, "fade_in", nil, 1500)

-- Начало уровня
-------------------------------------------------------------------------------
function coroutines.aitest1.on_level_start:run()

	-- Запускаем видеоролик
	execute_coroutine("aitest1.startup_video")
end

-------------------------------------------------------------------------------
function coroutines.aitest1.startup_video.m_on_end_cinema()
	
	coroutines.levels_common.on_level_start.run(self)
end

-- Конец уровня
-------------------------------------------------------------------------------
function coroutines.aitest1.on_level_end:run()

	-- Запускаем видеоролик
	execute_coroutine("aitest1.final_video")
end

-------------------------------------------------------------------------------
function coroutines.aitest1.final_video.m_on_end_cinema()
	coroutines.levels_common.on_level_end.run(self)
end