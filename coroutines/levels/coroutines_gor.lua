-------------------------------------------------------------------------------

-- Начало уровня
-------------------------------------------------------------------------------
function coroutines.gor.on_level_start:init()
	engine.set_var("r_ll_scale", 1)
	engine.set_var("r_ll_scale_value", 1.5)
end

-------------------------------------------------------------------------------
function coroutines.gor.on_level_start:run()

	-- Фейд
	local pp_id = engine.get_post_process_id("fade_out_long");
	if pp_id ~= -1 then
		g_actor_player:apply_post_process(pp_id)
	end
	
	coroutines.levels_common.on_level_start.run(self)
end

