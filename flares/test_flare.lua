
--------------------------------------------------------------------------
my_flare = 
{
	fade_table = 
	{
		fade_in_begin	= 0,
		fade_in_end		= 0,
		fade_out_begin	= 999999,
		fade_out_end	= 999999,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = true,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {0.2, 0.2},
			color				= {1, .1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_test01.tga",
		},
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
flare_test01 = 
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
			dist_invariant = false,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {100, 100},
			color				= {.3, .3, .3, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_glow01.tga",
		},
		{
			dist_invariant = false,
			glow				= false,
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
		{
			dist_invariant = false,
			glow				= true,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {21, 21},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_glow01.tga",
		},
		{
			dist_invariant = true,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			
			size				= {.5, .5},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= -.7,
			texname			= "flare_refl01.tga",
		},
		{
			dist_invariant = true,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {.03, .03},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= .7,
			texname			= "flare_refl02.tga",
		},
		{
			dist_invariant = true,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {.2, .2},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 1.3,
			texname			= "flare_refl03.tga",
		},
		{
			dist_invariant = true,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {.1, .1},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 1.7,
			texname			= "flare_refl05.tga",
		},
	},
}

--------------------------------------------------------------------------

flare_test02 = 
{
	fade_table = 
	{
		fade_in_begin	= 0,
		fade_in_end		= 0,
		fade_out_begin	= 999999,
		fade_out_end	= 999999,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress	= false,
			tex_clampmap		= true,
			
			size				= {21, 21},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_test01.tga",
		},
	},
}
--------------------------------------------------------------------------
