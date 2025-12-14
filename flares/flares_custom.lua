

--------------------------------------------------------------------------
meat_m06_tunnel_end = 
{
	fade_table = 
	{
		fade_in_begin	= 100,
		fade_in_end		= 210,
		fade_out_begin	= 700,
		fade_out_end	= 1000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant		= false,
			glow			= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {200, 21},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_anamorphic01.tga",
		},
	},
}
--------------------------------------------------------------------------
