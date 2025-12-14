-- ===========================================================================
-- surfaces

vis_surfaces = {}

vis_surfaces["test_surface1"] =
{
	ambient = 
	{
		material = "test1",
	}
}


-- ----------------------------------------------------------

vis_surfaces["model_surf"] =
{
	ambient = 
	{
		material = "test_model",
	},
}

-- ----------------------------------------------------------

vis_surfaces["model_surf_skinned"] =
{
	ambient = 
	{
		material = "test_model_skinned",
	},

	light_interactions =
	{
		point = 
		{	
			material = "lint_generic",
			{
				light_type = 1,
				skinned_mesh = true
			}
		},
	}
}

-- ----------------------------------------------------------

vis_surfaces["lm_surf"] =
{
	ambient = 
	{
		material = "test_lm",
	},


	light_interactions =
	{
		point = 
		{	
			material = "lint_generic",
			{
				light_type = 1,
				skinned_mesh = false
			}
		},
		spot = 
		{	
			material = "lint_generic",
			{
				light_type = 2,
				skinned_mesh = false
			}
		},
	}
}
-- ----------------------------------------------------------

vis_surfaces["vx_surf"] =
{
	ambient = 
	{
		material = "test_vx",
	},
	
	light_interactions =
	{
		point = 
		{	
			--material = "test_vx_add",
			material = "lint_point",
			{
				light_type = 1,
				skinned_mesh = false
			}
		},
		spot = 
		{	
			material = "lint_generic",
			{
				light_type = 2,
				skinned_mesh = false
			}
		},
	}
}

-- ----------------------------------------------------------

vis_surfaces["vx_trans"] =
{
	transparent = 
	{
		material = "test_vx_trans",
	}
}
