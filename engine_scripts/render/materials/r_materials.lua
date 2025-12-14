-- ===========================================================================
-- materials

vis_materials = {}

-- ===========================================================================
-- generic light interaction material

vis_materials["lint_generic"] = 
{
	template_params = 
	{
		diffuse_texture = { "string" },
		light_type		= { "int" },
		skinned_mesh	= { "bool" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			render_state = 
			{
				-- additive blending
				blend_src = "ONE",
				blend_dst = "ONE",
				depth_func = "lequal",
			},
			
			
			shader_defs		= { LIGHT_TYPE = "#light_type", SKINNED_MESH = "#skinned_mesh"},
			
			vertex_shader	= { name = "lint_generic", profile = "vp_arb1" },
			pixel_shader	= { name = "lint_generic", profile = "fp_arb1" },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
			},

			vertex_declaration = 
      		{
      			{
      				conditions = { skinned_mesh = true },
      				
      				{
						position		= { "position",		3 },
						uv0				= { "texcoord0",	2 },
						normal			= { "normal",		3 },
						bone_indices	= { "texcoord2",	4 },
						bone_weights	= { "texcoord3",	4 },
					}
      				
      			
      			},
      			{
      				conditions = { skinned_mesh = false },
      				
      				{
						position	= { "position", 3 },
						uv0			= { "texcoord0", 2 },
						normal		= { "normal", 3 },
					}
      			}
			}
        }
	}
}



-- ===========================================================================
-- ordinary ( not sknned ) model
vis_materials["test_model"] = 
{
	template_params = 
	{
		diffuse_texture = { "string"		},
	},
	
	sort_value = 1,

	passes = 
	{
		{
			vertex_shader = { name = "test_model", profile = "vp_arb1" },
			pixel_shader = 	{ name = "test_model", profile = "fp_arb1" },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
       		},

       		vertex_declaration = 
       		{
				position	= { "position",		3 },
				normal		= { "normal",		3 },
				uv0			= { "texcoord0",	2 },
			}
        }
	}
}

-- ===========================================================================
-- sknned model

vis_materials["test_model_skinned"] = 
{
	template_params = 
	{
		diffuse_texture = { "string"		},
	},
	
	sort_value = 1,

	passes = 
	{
		{
			vertex_shader = { name = "test_model", profile = "vp_arb1", defs = { SKINNED_MESH = true } },
			pixel_shader = 	{ name = "test_model", profile = "fp_arb1" },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
       		},

       		vertex_declaration = 
       		{
				position		= { "position",		3 },
				normal			= { "normal",		3 },
				uv0				= { "texcoord0",	2 },
				bone_indices	= { "texcoord1",	4 },
				bone_weights	= { "texcoord2",	4 },
			}
        }
	}
}

-- ===========================================================================

vis_materials["lint_point_skinned"] = 
{
	template_params = 
	{
		diffuse_texture = { "string" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			render_state = 
			{
				-- additive blending
				blend_src = "ONE",
				blend_dst = "ONE",
				depth_func = "lequal",
			},
				
			vertex_shader	= { name = "lint_generic", profile = "vp_arb1", defs = { LIGHT_TYPE = 1, SKINNED_MESH = true } },
			pixel_shader	= { name = "lint_generic", profile = "fp_arb1",	defs = { LIGHT_TYPE = 1 } },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
			},

			vertex_declaration = 
      		{
				position		= { "position",		3 },
				uv0				= { "texcoord0",	2 },
				normal			= { "normal",		3 },
				bone_indices	= { "texcoord2",	4 },
				bone_weights	= { "texcoord3",	4 },
			}
        }
	}
}



-- ===========================================================================

vis_materials["lint_spot"] = 
{
	template_params = 
	{
		diffuse_texture = { "string" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			render_state = 
			{
				-- additive blending
				blend_src = "ONE",
				blend_dst = "ONE",
				depth_func = "lequal",
			},
				
			vertex_shader	= { name = "lint_generic", profile = "vp_arb1", defs = { LIGHT_TYPE = 2 } },
			pixel_shader	= { name = "lint_generic", profile = "fp_arb1",	defs = { LIGHT_TYPE = 2 } },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
			},

			vertex_declaration = 
      		{
				position	= { "position", 3 },
				uv0			= { "texcoord0", 2 },
				normal		= { "normal", 3 },
				--tangent		= { "texcoord1", 3 },
				--binormal	= { "texcoord2", 3 },
			}
        }
	}
}


-- ===========================================================================

vis_materials["lint_point"] = 
{
	template_params = 
	{
		diffuse_texture = { "string" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			render_state = 
			{
				-- additive blending
				blend_src = "ONE",
				blend_dst = "ONE",
				depth_func = "lequal",
			},
				
			vertex_shader	= { name = "lint_generic", profile = "vp_arb1", defs = { LIGHT_TYPE = 1 } },
			pixel_shader	= { name = "lint_generic", profile = "fp_arb1",	defs = { LIGHT_TYPE = 1 } },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
			},

			vertex_declaration = 
      		{
				position	= { "position", 3 },
				uv0			= { "texcoord0", 2 },
				normal		= { "normal", 3 },
				--tangent		= { "texcoord1", 3 },
				--binormal	= { "texcoord2", 3 },
			}
        }
	}
}


-- ===========================================================================


vis_materials["test_li_point"] = 
{
	template_params = 
	{
		diffuse_texture = { "string" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			render_state = 
			{
				blend_src = "ONE",
				blend_dst = "ONE",
				depth_func = "lequal",
			},
				
			vertex_shader	= { name = "test_li_point", profile = "vp_arb1"	},
			pixel_shader	= { name = "test_li_point", profile = "fp_arb1" },
		
			parameters = 
			{
				--tex_diffuse 	= "#diffuse_texture",
				--tex_normalmap	= "wallbump.tga",--"stonebump.tga"
				tex_diffuse 	= "rockwall.tga",
				tex_normalmap	= "rockwall_normal.tga",
				tex_heightmap	= "rockwall_height.tga"
			},

			vertex_declaration = 
      		{
				position	= { "position", 3 },
				uv0			= { "texcoord0", 2 },
				normal		= { "normal", 3 },
				tangent		= { "texcoord1", 3 },
				--binormal	= { "texcoord2", 3 },
			}
        }
	}
}

-- ===========================================================================
vis_materials["test_vx_trans"] = 
{
	template_params = 
	{
		diffuse_texture = { "string", "prop_clock_01.tga" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			render_state = 
			{
				blend_src = "SRC_ALPHA",
				blend_dst = "ONE_MINUS_SRC_ALPHA"
			},
				
			vertex_shader = 
			{ 
				name		= "test_vx", 
				profile		= "vp_arb1",
			},
			
			pixel_shader = { name = "test_vx", profile = "fp_arb1" },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
			},

			vertex_declaration = 
      		{
				position	= { "position", 3 },
				uv0			= { "texcoord0", 2 },
				color		= { "color", 4 },
			}
        }
	}
}

-- ===========================================================================

vis_materials["test_vx"] = 
{
	template_params = 
	{
		diffuse_texture = { "string", "prop_clock_01.tga" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			vertex_shader = 
			{ 
				name		= "test_vx", 
				profile		= "vp_arb1",
			},
			
			pixel_shader = { name = "test_vx", profile = "fp_arb1" },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
			},

			vertex_declaration = 
      		{
				position	= { "position", 3 },
				uv0			= { "texcoord0", 2 },
				color		= { "color", 4 },
			}
        }
	}
}

vis_materials["test_vx_add"] = 
{
	template_params = 
	{
		diffuse_texture = { "string", "prop_clock_01.tga" },
	},
	
	sort_value = 1,

	passes = 
	{
		{
			render_state = 
			{
				blend_src = "ONE",
				blend_dst = "ONE",
				depth_func = "lequal",
			},
		
			vertex_shader = 
			{ 
				name		= "test_vx", 
				profile		= "vp_arb1",
			},
			
			pixel_shader = { name = "test_vx", profile = "fp_arb1" },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
			},

			vertex_declaration = 
      		{
				position	= { "position", 3 },
				uv0			= { "texcoord0", 2 },
				color		= { "color", 4 },
			}
        }
	}
}

-- ===========================================================================

vis_materials["test_lm"] = 
{
	template_params = 
	{
		diffuse_texture = { "string" },
		lightmap_texture = { "string" }
	},
	
	sort_value = 1,

	passes = 
	{
		{
			vertex_shader = { name = "test_lm", profile = "vp_arb1" },
			pixel_shader = 
			{	name = "test_lm", 
				profile = "fp_arb1", -- if profile less than 2.0 can run on GeForce 4 (or even less !) use fallback materials!
				
				constants	= 
				{
					vt = 321.31
				},
				
				defs = 
				{
					ls_cast_shadows = 1,
				}
			},
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
				--tex_diffuse 	= "klaska",
				tex_lm			= "#lightmap_texture",
       		},

       		vertex_declaration = 
       		{
				position = { "position", 3 },
				uv0	 = { "texcoord0", 2 },
				uv_lm	 = { "texcoord1", 2 },
			}
        }
	}
}

-- ===========================================================================

vis_materials["test1"] = 
{
	template_params = 
	{
		diffuse_texture = { "string", "prop_clock_01.tga" }
	},
	
	sort_value = 1,

	passes = 
	{
		{
			vertex_shader = { name = "test0", profile = "vp_arb1" },
			pixel_shader = { name = "test0", profile = "fp_arb1" },
		
			parameters = 
			{
				tex_diffuse 	= "#diffuse_texture",
--				color_modulator = { 1.0, 0.0, 0.0, 1.0 },
--				tex_shared0 	= "oknograz",
			},

			vertex_declaration = 
        		{
				position = { "position", 3 },
				uv0	 = { "texcoord0", 2 },
			}
         }
	}
}

-- ===========================================================================

vis_materials["test_xxx"] = 
{

	template_params =
	{
		diffuse_texture = { "string", "notexture" },
		bump_texture 	= { "string", "notexture" },
		lightmap_scale  = { "float", 1.0 },
	},

	sort_value = 244,

	
	passes = 
	{
		{

			vertex_shader = { name = "skinning_test", profile = "vp_arb1", entry_func = "main" },
			pixel_shader = {  name =  "skinning_test", profile = "fp_arb1", entry_func = "main" },

			--definitions for shaders

			shader_defs = 
			{
				light_cast_hadows	= 1,
			
			},

			-- parameters for shader
			parameters = 
			{
--				cam_pos = { 1.0, 121.0, 311.0 },
--				param_float2 = { 1.0 },
--				param_float = false
--				param_lmscale = "#lightmap_scale"
		
			},

			render_state = 
			{

				blend_src = "one",
				blend_dst = "zero",
	
				atest_func = "greater",
				atest_ref = 1.4,
				
				cull_face = true,
				cull_face_func = "back",
				front_face = "ccw",
				
				depth_mask = true,
				depth_test = true,
				depth_func = "greater",
				polygon_offset = true,
				polygon_offset_factor = 0.2,
				polygon_offset_units = 0.5,
			},			
	
	                                                                                       
			vertex_declaration = 
        		{
				position = { "position", 3 },
				uv0	 = { "texcoord0", 2 },
				normal   = { "normal",	  3 },
				uv_lm	 = { "texcoord1", 2 }
			}
		},
	},
}

