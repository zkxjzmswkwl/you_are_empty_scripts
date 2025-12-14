
--------------------------------------------------------------------------
point01_lens_anamorphic = 
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

--------------------------------------------------------------------------
point01_anamorphic = 
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
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
point1_yellow = 
{
	fade_table = 
	{
		fade_in_begin	= 1,
		fade_in_end		= 10,
		fade_out_begin	= 1000,
		fade_out_end	= 3000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {150, 150},
			color				= { .81, .73, .63, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_glow01.tga",
		},
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
point1_yellow_glow = 
{
	fade_table = 
	{
		fade_in_begin	= 1,
		fade_in_end		= 10,
		fade_out_begin	= 1000,
		fade_out_end	= 3000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow			= true,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {150, 150},
			color				= { .81, .73, .63, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_glow01.tga",
		},
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
cone1 = 
{
	fade_table = 
	{
		fade_in_begin	= 100,
		fade_in_end		= 210,
		fade_out_begin	= 1000,
		fade_out_end	= 3000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow				= false,
			z_align			= true,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {210, 210},
			color				= {1, 1, 1, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_cone01.tga",
		},
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
cone2 = 
{
	fade_table = 
	{
		fade_in_begin	= 170,
		fade_in_end		= 370,
		fade_out_begin	= 1000,
		fade_out_end	= 3000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow			= true,
			z_align			= true,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {490, 490},
			color				= {.49, .49, .49, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_cone02.tga",
		},
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
point1_neon = 
{
	fade_table = 
	{
		fade_in_begin	= 1,
		fade_in_end		= 10,
		fade_out_begin	= 1000,
		fade_out_end	= 3000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {150, 150},
			color				= { .31, .25, .17, 1},
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
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {250, 250},
			color				= { .31, .25, .37, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_glow01.tga",
		},
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
point1_red = 
{
	fade_table = 
	{
		fade_in_begin	= 1,
		fade_in_end		= 10,
		fade_out_begin	= 1000,
		fade_out_end	= 3000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {150, 150},
			color				= { .81, .33, .33, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_glow01.tga",
		},
	},
}
--------------------------------------------------------------------------

--------------------------------------------------------------------------
point1_blue = 
{
	fade_table = 
	{
		fade_in_begin	= 1,
		fade_in_end		= 10,
		fade_out_begin	= 1000,
		fade_out_end	= 3000,
	},

	flare_element_descriptors = 
	{
		{
			dist_invariant = false,
			glow				= false,
			z_align			= false,
			depth_test		= true,
			tex_no_mipmaps		= true,
			tex_no_compress		= true,
			tex_clampmap		= true,
			
			size				= {150, 150},
			color				= { .37, .37, .73, 1},
			blend				= FLARE_BL_ADD, --FLARE_BL_ADD, FLARE_BL_MODULATE, FLARE_BL_BLEND
			offset			= 0,
			texname			= "flare_glow01.tga",
		},
	},
}
--------------------------------------------------------------------------
