
ui_windows_ini = 
{
	alignment = "ALIGNMENT_NONE", 
	bottom_margin = 0, 
	class_name = "Desktop", 
	fade_in = 150, 
	fade_out = 150, 
	left_margin = 0, 
	name = "desktop", 
	right_margin = 0, 
	top_margin = 0, 
	visual_delta_bottom = 0, 
	visual_delta_left = 0, 
	visual_delta_right = 0, 
	visual_delta_top = 0, 
	fonts = 
	{
		FNT_NAME_DEFAULT = "arial_white", 
		FNT_NAME_FIXED = "courier", 
	}, 
	materials = 
	{
		MAT_NAME_BUTTON_DOWN = 
		{
			material_preset = "ui_sys_scroll_button_down_e", 
		}, 
		MAT_NAME_BUTTON_DOWN_HIGHLIGHTED = 
		{
			material_preset = "ui_sys_scroll_button_down_h", 
		}, 
		MAT_NAME_BUTTON_DOWN_PUSHED = 
		{
			material_preset = "ui_sys_scroll_button_down_p", 
		}, 
		MAT_NAME_BUTTON_LEFT = 
		{
			material_preset = "ui_sys_scroll_button_left_e", 
		}, 
		MAT_NAME_BUTTON_LEFT_HIGHLIGHTED = 
		{
			material_preset = "ui_sys_scroll_button_left_h", 
		}, 
		MAT_NAME_BUTTON_LEFT_PUSHED = 
		{
			material_preset = "ui_sys_scroll_button_left_p", 
		}, 
		MAT_NAME_BUTTON_RIGHT = 
		{
			material_preset = "ui_sys_scroll_button_right_e", 
		}, 
		MAT_NAME_BUTTON_RIGHT_HIGHLIGHTED = 
		{
			material_preset = "ui_sys_scroll_button_right_h", 
		}, 
		MAT_NAME_BUTTON_RIGHT_PUSHED = 
		{
			material_preset = "ui_sys_scroll_button_right_p", 
		}, 
		MAT_NAME_BUTTON_SCROLLER = 
		{
			material_preset = "ui_sys_button_scroller_e",
		}, 
		MAT_NAME_BUTTON_SCROLLER_HIGHLIGHTED = 
		{
			material_preset = "ui_sys_button_scroller_h",
		}, 
		MAT_NAME_BUTTON_SCROLLER_PUSHED = 
		{
			material_preset = "ui_sys_button_scroller_p",
		}, 
		MAT_NAME_BUTTON_UP = 
		{
			material_preset = "ui_sys_scroll_button_up_e",
		}, 
		MAT_NAME_BUTTON_UP_HIGHLIGHTED = 
		{
			material_preset = "ui_sys_scroll_button_up_h",
		}, 
		MAT_NAME_BUTTON_UP_PUSHED = 
		{
			material_preset = "ui_sys_scroll_button_up_p",
		}, 
		MAT_NAME_NORMAL = 
		{
			diffuse_texture = "cback.tga", 
			material_template = "ui_image", 
			color = 
			{
				a = 255, 
				b = 255, 
				g = 255, 
				r = 255, 
			}, 
			pos = 
			{
				0, 
				0, 
			}, 
			size = 
			{
				1, 
				1, 
			}, 
		}, 
	}, 
	pos = 
	{
		0, 
		0, 
	}, 
	size = 
	{
		1024, 
		768, 
	}, 
	{
		-----------------------------------------------------------------------------
		alignment = "ALIGNMENT_NONE", 
		bottom_margin = 8, 
		button_h = 20, 
		button_w = 128, 
		buttons_horizontal = true, 
		buttons_interval = 8, 
		can_drag = true, 
		can_resize = true, 
		caption = "STR_CONSOLE", 
		caption_alignment = "ALIGNMENT_LEFT", 
		caption_h = 20, 
		class_name = "Console", 
		fade_in = 100, 
		fade_out = 100, 
		is_modal = false, 
		left_margin = 4, 
		name = "console", 
		right_margin = 4, 
		top_margin = 8, 
		visual_delta_bottom = 0, 
		visual_delta_left = 0, 
		visual_delta_right = 0, 
		visual_delta_top = 0, 
		fonts = 
		{
		}, 
		materials = 
		{
			MAT_NAME_NORMAL = 
			{
				material_template = "ui_color", 
				color = 
				{
					a = 150, 
					b = 100, 
					g = 100, 
					r = 100, 
				}, 
				pos = 
				{
					0, 
					0, 
				}, 
				size = 
				{
					1, 
					1, 
				}, 
			}, 
		}, 
		pos = 
		{
			37, 
			135, 
		}, 
		size = 
		{
			473, 
			423, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_NONE", 
			border_size = 8, 
			bottom_margin = 0, 
			can_drag = true, 
			can_resize = true, 
			class_name = "Border", 
			fade_in = 100, 
			fade_out = 100, 
			is_modal = false, 
			left_margin = 0, 
			name = "border left", 
			right_margin = 0, 
			top_margin = 0, 
			type = "BORDER_LEFT", 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
				}, 
			}, 
			pos = 
			{
				0, 
				0, 
			}, 
			size = 
			{
				8, 
				423, 
			}, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_NONE", 
			border_size = 8, 
			bottom_margin = 0, 
			can_drag = true, 
			can_resize = true, 
			class_name = "Border", 
			fade_in = 100, 
			fade_out = 100, 
			is_modal = false, 
			left_margin = 0, 
			name = "border top", 
			right_margin = 0, 
			top_margin = 0, 
			type = "BORDER_TOP", 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
				}, 
			}, 
			pos = 
			{
				0, 
				0, 
			}, 
			size = 
			{
				473, 
				8, 
			}, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_NONE", 
			bottom_margin = 4, 
			can_drag = false, 
			can_resize = true, 
			class_name = "EditBox", 
			fade_in = 100, 
			fade_out = 100, 
			is_modal = false, 
			left_margin = 4, 
			name = "history", 
			right_margin = 4, 
			top_margin = 4, 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			fonts = 
			{
				FNT_NAME_DEFAULT = "courier", 
			}, 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
					material_template = "ui_color", 
					color = 
					{
						a = 150, 
						b = 15, 
						g = 15, 
						r = 15, 
					}, 
					pos = 
					{
						0, 
						0, 
					}, 
					size = 
					{
						1, 
						1, 
					}, 
				}, 
			}, 
			pos = 
			{
				4, 
				28, 
			}, 
			size = 
			{
				465, 
				367, 
			}, 
			{
				-----------------------------------------------------------------------
				alignment = "ALIGNMENT_NONE", 
				bottom_margin = 0, 
				can_drag = false, 
				can_resize = true, 
				class_name = "Caret", 
				fade_in = 100, 
				fade_out = 100, 
				is_modal = false, 
				left_margin = 0, 
				name = "caret", 
				right_margin = 0, 
				top_margin = 0, 
				visual_delta_bottom = 0, 
				visual_delta_left = 0, 
				visual_delta_right = 0, 
				visual_delta_top = 0, 
				materials = 
				{
					MAT_NAME_CHECKED = 
					{
						material_template = "ui_color", 
						color = 
						{
							a = 150, 
							b = 120, 
							g = 120, 
							r = 120, 
						}, 
						pos = 
						{
							0, 
							0, 
						}, 
						size = 
						{
							1, 
							1, 
						}, 
					}, 
					MAT_NAME_NORMAL = 
					{
					}, 
				}, 
				pos = 
				{
					4, 
					8132, 
				}, 
				size = 
				{
					3, 
					14, 
				}, 
			}, 
			{
				-----------------------------------------------------------------------
				alignment = "ALIGNMENT_NONE", 
				bottom_margin = 0, 
				can_drag = false, 
				can_resize = true, 
				class_name = "ScrollBar", 
				fade_in = 100, 
				fade_out = 100, 
				is_modal = false, 
				left_margin = 0, 
				name = "scroll bar vert", 
				right_margin = 0, 
				top_margin = 0, 
				visual_delta_bottom = 0, 
				visual_delta_left = 0, 
				visual_delta_right = 0, 
				visual_delta_top = 0, 
				fonts = 
				{
				}, 
				materials = 
				{
					MAT_NAME_NORMAL = 
					{
						material_template = "ui_color", 
						color = 
						{
							a = 50, 
							b = 52, 
							g = 52, 
							r = 52, 
						}, 
						pos = 
						{
							0, 
							0, 
						}, 
						size = 
						{
							1, 
							1, 
						}, 
					}, 
				}, 
				pos = 
				{
					449, 
					0, 
				}, 
				size = 
				{
					16, 
					367, 
				}, 
				{
					--------------------------------------------------------------------
					alignment = "ALIGNMENT_NONE", 
					bottom_margin = 0, 
					can_drag = false, 
					can_resize = true, 
					class_name = "Button", 
					fade_in = 100, 
					fade_out = 100, 
					is_modal = false, 
					left_margin = 0, 
					name = "button min", 
					right_margin = 0, 
					text = "", 
					top_margin = 0, 
					visual_delta_bottom = 0, 
					visual_delta_left = 0, 
					visual_delta_right = 0, 
					visual_delta_top = 0, 
					fonts = 
					{
					}, 
					materials = 
					{
						MAT_NAME_HIGHLIGHTED = 
						{
							material_preset = "ui_sys_scroll_button_up_h", 
						}, 
						MAT_NAME_NORMAL = 
						{
							material_preset = "ui_sys_scroll_button_up_e", 
						}, 
						MAT_NAME_PUSHED = 
						{
							material_preset = "ui_sys_scroll_button_up_p", 
						}, 
					}, 
					pos = 
					{
						0, 
						0, 
					}, 
					size = 
					{
						16, 
						16, 
					}, 
				}, 
				{
					--------------------------------------------------------------------
					alignment = "ALIGNMENT_NONE", 
					bottom_margin = 0, 
					can_drag = false, 
					can_resize = true, 
					class_name = "Button", 
					fade_in = 100, 
					fade_out = 100, 
					is_modal = false, 
					left_margin = 0, 
					name = "button max", 
					right_margin = 0, 
					text = "", 
					top_margin = 0, 
					visual_delta_bottom = 0, 
					visual_delta_left = 0, 
					visual_delta_right = 0, 
					visual_delta_top = 0, 
					fonts = 
					{
					}, 
					materials = 
					{
						MAT_NAME_HIGHLIGHTED = 
						{
							material_preset = "ui_sys_scroll_button_down_h", 
						}, 
						MAT_NAME_NORMAL = 
						{
							material_preset = "ui_sys_scroll_button_down_e", 
						}, 
						MAT_NAME_PUSHED = 
						{
							material_preset = "ui_sys_scroll_button_down_p", 
						}, 
					}, 
					pos = 
					{
						0, 
						351, 
					}, 
					size = 
					{
						16, 
						16, 
					}, 
				}, 
				{
					--------------------------------------------------------------------
					alignment = "ALIGNMENT_NONE", 
					bottom_margin = 0, 
					can_drag = true, 
					can_resize = true, 
					class_name = "Button", 
					fade_in = 100, 
					fade_out = 100, 
					is_modal = false, 
					left_margin = 0, 
					name = "button scroller", 
					right_margin = 0, 
					text = "", 
					top_margin = 0, 
					visual_delta_bottom = 0, 
					visual_delta_left = 0, 
					visual_delta_right = 0, 
					visual_delta_top = 0, 
					fonts = 
					{
					}, 
					materials = 
					{
						MAT_NAME_HIGHLIGHTED = 
						{
							material_preset = "ui_sys_button_scroller_h", 
						}, 
						MAT_NAME_NORMAL = 
						{
							material_preset = "ui_sys_button_scroller_e", 
						}, 
						MAT_NAME_PUSHED = 
						{
							material_preset = "ui_sys_button_scroller_p", 
						}, 
					}, 
					pos = 
					{
						0, 
						335, 
					}, 
					size = 
					{
						16, 
						16, 
					}, 
				}, 
			}, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_NONE", 
			border_size = 8, 
			bottom_margin = 0, 
			can_drag = true, 
			can_resize = true, 
			class_name = "Border", 
			fade_in = 100, 
			fade_out = 100, 
			is_modal = false, 
			left_margin = 0, 
			name = "border", 
			right_margin = 0, 
			top_margin = 0, 
			type = "BORDER_LEFT", 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
				}, 
			}, 
			pos = 
			{
				0, 
				0, 
			}, 
			size = 
			{
				8, 
				423, 
			}, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_NONE", 
			border_size = 8, 
			bottom_margin = 0, 
			can_drag = true, 
			can_resize = true, 
			class_name = "Border", 
			fade_in = 100, 
			fade_out = 100, 
			is_modal = false, 
			left_margin = 0, 
			name = "border right", 
			right_margin = 0, 
			top_margin = 0, 
			type = "BORDER_RIGHT", 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
				}, 
			}, 
			pos = 
			{
				465, 
				0, 
			}, 
			size = 
			{
				8, 
				423, 
			}, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_NONE", 
			border_size = 8, 
			bottom_margin = 0, 
			can_drag = true, 
			can_resize = true, 
			class_name = "Border", 
			fade_in = 100, 
			fade_out = 100, 
			is_modal = false, 
			left_margin = 0, 
			name = "border bottom", 
			right_margin = 0, 
			top_margin = 0, 
			type = "BORDER_BOTTOM", 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
				}, 
			}, 
			pos = 
			{
				0, 
				415, 
			}, 
			size = 
			{
				473, 
				8, 
			}, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_NONE", 
			bottom_margin = 4, 
			can_drag = false, 
			can_resize = true, 
			class_name = "EditBox", 
			fade_in = 100, 
			fade_out = 100, 
			is_modal = false, 
			left_margin = 4, 
			name = "command", 
			right_margin = 4, 
			top_margin = 4, 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			fonts = 
			{
				FNT_NAME_DEFAULT = "courier", 
			}, 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
					material_template = "ui_color", 
					color = 
					{
						a = 150, 
						b = 15, 
						g = 15, 
						r = 15, 
					}, 
					pos = 
					{
						0, 
						0, 
					}, 
					size = 
					{
						1, 
						1, 
					}, 
				}, 
			}, 
			pos = 
			{
				4, 
				397, 
			}, 
			size = 
			{
				465, 
				20, 
			}, 
			{
				-----------------------------------------------------------------------
				alignment = "ALIGNMENT_NONE", 
				bottom_margin = 0, 
				can_drag = false, 
				can_resize = true, 
				class_name = "Caret", 
				fade_in = 100, 
				fade_out = 100, 
				is_modal = false, 
				left_margin = 0, 
				name = "caret", 
				right_margin = 0, 
				top_margin = 0, 
				visual_delta_bottom = 0, 
				visual_delta_left = 0, 
				visual_delta_right = 0, 
				visual_delta_top = 0, 
				materials = 
				{
					MAT_NAME_CHECKED = 
					{
						material_template = "ui_color", 
						color = 
						{
							a = 150, 
							b = 120, 
							g = 120, 
							r = 120, 
						}, 
						pos = 
						{
							0, 
							0, 
						}, 
						size = 
						{
							1, 
							1, 
						}, 
					}, 
					MAT_NAME_NORMAL = 
					{
					}, 
				}, 
				pos = 
				{
					4, 
					4, 
				}, 
				size = 
				{
					3, 
					14, 
				}, 
			}, 
		}, 
	}, 
	{
		-----------------------------------------------------------------------------
		alignment = "ALIGNMENT_CLIENT", 
		class_name = "Window", 
		name = "game_app", 
		pos = 
		{
			0, 
			0, 
		}, 
		size = 
		{
			1024, 
			768, 
		}, 
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_CLIENT", 
			bottom_margin = 0, 
			can_drag = false, 
			can_resize = true, 
			class_name = "GameWindow", 
			fade_in = 0, 
			fade_out = 0, 
			is_modal = false, 
			left_margin = 0, 
			name = "game_window", 
			right_margin = 0, 
			top_margin = 0, 
			visual_delta_bottom = 0, 
			visual_delta_left = 0, 
			visual_delta_right = 0, 
			visual_delta_top = 0, 
			fonts = 
			{
			}, 
			pos = 
			{
				0, 
				0, 
			}, 
			size = 
			{
				1024, 
				768, 
			}, 
			{
				--------------------------------------------------------------------------
				alignment = "ALIGNMENT_CLIENT", 
				bottom_margin = 20, 
				button_h = 32, 
				button_w = 100, 
				buttons_horizontal = true, 
				buttons_interval = 10, 
				can_drag = false, 
				can_resize = true, 
				caption = "", 
				caption_alignment = "ALIGNMENT_CENTER", 
				caption_h = 24, 
				class_name = "MessageBox", 
				fade_in = 150, 
				fade_out = 150, 
				is_modal = true, 
				left_margin = 0, 
				message_text = "STR_GAME_PAUSED", 
				name = "GamePause", 
				right_margin = 0, 
				top_margin = 0, 
				visual_delta_bottom = 0, 
				visual_delta_left = 0, 
				visual_delta_right = 0, 
				visual_delta_top = 0, 
				fonts = 
				{
					
				}, 
				materials = 
				{
					MAT_NAME_NORMAL = 
					{
						material_template = "ui_color", 
						color = 
						{
							a = 150, 
							b = 20, 
							g = 20, 
							r = 20, 
						}, 
						pos = 
						{
							0, 
							0, 
						}, 
						size = 
						{
							1, 
							1, 
						}, 
					}, 
				}, 
				pos = 
				{
					0, 
					650, 
				}, 
				size = 
				{
					1024, 
					50, 
				}, 
			},
			{
				--------------------------------------------------------------------------
				-- Информационное сообщение
				alignment = "ALIGNMENT_NONE", 
				text_alignment = "ALIGNMENT_CENTER",
				class_name = "StaticText", 
				name = "InfoMessage", 
				pos = { 0, 768 * (3/4) }, 
				size = { 1024, 40}, 
			},
		},  
		{
			--------------------------------------------------------------------------
			alignment = "ALIGNMENT_CLIENT", 
			can_drag = false, 
			can_resize = true, 
			class_name = "WindowVisual", 
			fade_in = 0, 
			fade_out = 0, 
			is_modal = true, 
			name = "video_window", 
			materials = 
			{
				MAT_NAME_NORMAL = 
				{
					material_template = "ui_color", 
					color = 
					{
						a = 255, 
						b = 0, 
						g = 0, 
						r = 0, 
					}, 
					pos = 
					{
						0, 
						0, 
					}, 
					size = 
					{
						1, 
						1, 
					}, 
				}, 
			}, 
			pos = 
			{
				0, 
				0, 
			}, 
			size = 
			{
				1024, 
				768, 
			}, 
			{
				-----------------------------------------------------------------------
				alignment = "ALIGNMENT_CLIENT",  
				can_drag = false, 
				can_resize = true, 
				class_name = "WindowVisual", 
				fade_in = 0, 
				fade_out = 0, 
				is_modal = false, 
				name = "video_player_window", 
				pos = 
				{
					0, 
					0, 
				}, 
				size = 
				{
					1024, 
					768, 
				}, 
			}, 
		},
	}, 
}