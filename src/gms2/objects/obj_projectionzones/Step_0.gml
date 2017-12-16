controller.scrollcursor_flag = 0;

if (moving == 1)
{
    //x start
    controller.scrollcursor_flag = 1;
    if (keyboard_check(vk_control))
    {
		controller.scale_left_top += ((mouse_x-mouse_xprevious));
		controller.scale_left_bottom += ((mouse_x-mouse_xprevious));
    }
    else
    {
	    controller.scale_left_top += ((mouse_x-mouse_xprevious)/256*$ffff);
		controller.scale_left_bottom += ((mouse_x-mouse_xprevious)/256*$ffff);
    }
	controller.scale_left_top = clamp(controller.scale_left_top, 0, $ffff);
	controller.scale_left_bottom = clamp(controller.scale_left_bottom, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 2)
{
    //x end
    controller.scrollcursor_flag = 1;
    if (keyboard_check(vk_control))
    {
		controller.scale_right_top += ((mouse_x-mouse_xprevious));
		controller.scale_right_bottom += ((mouse_x-mouse_xprevious));
    }
    else
    {
	    controller.scale_right_top += ((mouse_x-mouse_xprevious)/256*$ffff);
		controller.scale_right_bottom += ((mouse_x-mouse_xprevious)/256*$ffff);
    }
	controller.scale_right_top = clamp(controller.scale_right_top, 0, $ffff);
	controller.scale_right_bottom = clamp(controller.scale_right_bottom, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 3)
{
    //y start
    controller.scrollcursor_flag = 2;
    if (keyboard_check(vk_control))
    {
		controller.scale_top_left += ((mouse_y-mouse_yprevious));
		controller.scale_top_right += ((mouse_y-mouse_yprevious));
    }
    else
    {
	    controller.scale_top_left += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_top_right += ((mouse_y-mouse_yprevious)/256*$ffff);
    }
	controller.scale_top_left = clamp(controller.scale_top_left, 0, $ffff);
	controller.scale_top_right = clamp(controller.scale_top_right, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 4)
{
    //y end
    controller.scrollcursor_flag = 2;
    if (keyboard_check(vk_control))
    {
		controller.scale_bottom_left += ((mouse_y-mouse_yprevious));
		controller.scale_bottom_right += ((mouse_y-mouse_yprevious));
    }
    else
    {
	    controller.scale_bottom_left += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_bottom_right += ((mouse_y-mouse_yprevious)/256*$ffff);
    }
	controller.scale_bottom_left = clamp(controller.scale_bottom_left, 0, $ffff);
	controller.scale_bottom_right = clamp(controller.scale_bottom_right, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 5)
{
    //drag whole window
    if (keyboard_check(vk_control))
    {
		controller.scale_bottom_left += ((mouse_y-mouse_yprevious));
		controller.scale_bottom_right += ((mouse_y-mouse_yprevious));
		controller.scale_top_left += ((mouse_y-mouse_yprevious));
		controller.scale_top_right += ((mouse_y-mouse_yprevious));
		controller.scale_right_top += ((mouse_x-mouse_xprevious));
		controller.scale_right_bottom += ((mouse_x-mouse_xprevious));
		controller.scale_left_top += ((mouse_x-mouse_xprevious));
		controller.scale_left_bottom += ((mouse_x-mouse_xprevious));
    }
    else
    {
        controller.scale_bottom_left += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_bottom_right += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_top_left += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_top_right += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_right_top += ((mouse_x-mouse_xprevious)/256*$ffff);
		controller.scale_right_bottom += ((mouse_x-mouse_xprevious)/256*$ffff);
		controller.scale_left_top += ((mouse_x-mouse_xprevious)/256*$ffff);
		controller.scale_left_bottom += ((mouse_x-mouse_xprevious)/256*$ffff);
    }
	controller.scale_left_top = clamp(controller.scale_left_top, 0, $ffff);
	controller.scale_left_bottom = clamp(controller.scale_left_bottom, 0, $ffff);
	controller.scale_bottom_left = clamp(controller.scale_bottom_left, 0, $ffff);
	controller.scale_bottom_right = clamp(controller.scale_bottom_right, 0, $ffff);
	controller.scale_top_left = clamp(controller.scale_top_left, 0, $ffff);
	controller.scale_top_right = clamp(controller.scale_top_right, 0, $ffff);
	controller.scale_left_top = clamp(controller.scale_left_top, 0, $ffff);
	controller.scale_left_bottom = clamp(controller.scale_left_bottom, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 6)
{
    //x start blind zone
    var t_list = controller.blindzone_list;
    controller.scrollcursor_flag = 1;
    i = blindzonetoedit;
    if (keyboard_check(vk_control))
    {
        t_list[| i] = t_list[| i]+((mouse_x-mouse_xprevious)*4);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-1)
            t_list[| i] = t_list[| i+1]-1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_x-mouse_xprevious)*$ffff/256);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-4096)
            t_list[| i] = t_list[| i+1]-4096;
    }
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 7)
{
    //x end blind zone
    var t_list = controller.blindzone_list;
    controller.scrollcursor_flag = 1;
    i = blindzonetoedit+1;
    if (keyboard_check(vk_control))
    {
        t_list[| i] = t_list[| i]+((mouse_x-mouse_xprevious)*4);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+1)
            t_list[| i] = t_list[| i-1]+1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_x-mouse_xprevious)*$ffff/256);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+4096)
            t_list[| i] = t_list[| i-1]+4096;
    }
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 8)
{
    //y start blind zone
    var t_list = controller.blindzone_list;
    controller.scrollcursor_flag = 2;
    i = blindzonetoedit+2;
    if (keyboard_check(vk_control))
    {
        t_list[| i] = t_list[| i]+((mouse_y-mouse_yprevious)*4);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-1)
            t_list[| i] = t_list[| i+1]-1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_y-mouse_yprevious)*$ffff/256);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-4096)
            t_list[| i] = t_list[| i+1]-4096;
    }
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 9)
{
    //y end blind zone
    var t_list = controller.blindzone_list;
    controller.scrollcursor_flag = 2;
    i = blindzonetoedit+3;
    if (keyboard_check(vk_control))
    {
        t_list[| i] = t_list[| i]+((mouse_y-mouse_yprevious)*4);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+1)
            t_list[| i] = t_list[| i-1]+1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_y-mouse_yprevious)*$ffff/256);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+4096)
            t_list[| i] = t_list[| i-1]+4096;
    }
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 10)
{
    //drag whole window blind zone
    var t_list = controller.blindzone_list;
    i = blindzonetoedit;
    if (keyboard_check(vk_control))
    {
        t_list[| i+0] = t_list[| i+0]+((mouse_x-mouse_xprevious)*4);
        t_list[| i+1] = t_list[| i+1]+((mouse_x-mouse_xprevious)*4);
        t_list[| i+2] = t_list[| i+2]+((mouse_y-mouse_yprevious)*4);
        t_list[| i+3] = t_list[| i+3]+((mouse_y-mouse_yprevious)*4);
    }
    else
    {
        t_list[| i+0] = t_list[| i+0]+((mouse_x-mouse_xprevious)*$ffff/256);
        t_list[| i+1] = t_list[| i+1]+((mouse_x-mouse_xprevious)*$ffff/256);
        t_list[| i+2] = t_list[| i+2]+((mouse_y-mouse_yprevious)*$ffff/256);
        t_list[| i+3] = t_list[| i+3]+((mouse_y-mouse_yprevious)*$ffff/256);
    }
    if (t_list[| i+0] < 0)
    {
        t_list[| i+1] += abs(t_list[| i+0]);
        t_list[| i+0] = 0;
    }
    if (t_list[| i+1] > $FFFF)
    {
        t_list[| i+0] -= t_list[| i+1]-$FFFF;
        t_list[| i+1] = $FFFF;
    }
    if (t_list[| i+2] < 0)
    {
        t_list[| i+3] += abs(t_list[| i+2]);
        t_list[| i+2] = 0;
    }
    if (t_list[| i+3] > $FFFF)
    {
        t_list[| i+2] -= t_list[| i+3]-$FFFF;
        t_list[| i+3] = $FFFF;
    }
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 11)
{
    //upper left corner
	controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
    if (keyboard_check(vk_control))
    {
		controller.scale_top_left += ((mouse_y-mouse_yprevious));
		controller.scale_left_top += ((mouse_x-mouse_xprevious));
    }
    else
    {
	    controller.scale_top_left += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_left_top += ((mouse_x-mouse_xprevious)/256*$ffff);
    }
	controller.scale_top_left = clamp(controller.scale_top_left, 0, $ffff);
	controller.scale_left_top = clamp(controller.scale_left_top, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 12)
{
    //upper right corner
	controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
    if (keyboard_check(vk_control))
    {
		controller.scale_top_right += ((mouse_y-mouse_yprevious));
		controller.scale_right_top += ((mouse_x-mouse_xprevious));
    }
    else
    {
	    controller.scale_top_right += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_right_top += ((mouse_x-mouse_xprevious)/256*$ffff);
    }
	controller.scale_top_right = clamp(controller.scale_top_right, 0, $ffff);
	controller.scale_right_top = clamp(controller.scale_right_top, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 13)
{
    //lower left corner
	controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
    if (keyboard_check(vk_control))
    {
		controller.scale_bottom_left += ((mouse_y-mouse_yprevious));
		controller.scale_left_bottom += ((mouse_x-mouse_xprevious));
    }
    else
    {
	    controller.scale_bottom_left += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_left_bottom += ((mouse_x-mouse_xprevious)/256*$ffff);
    }
	controller.scale_bottom_left = clamp(controller.scale_bottom_left, 0, $ffff);
	controller.scale_left_bottom = clamp(controller.scale_left_bottom, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}
else if (moving == 14)
{
    //lower right corner
	controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
    if (keyboard_check(vk_control))
    {
		controller.scale_bottom_right += ((mouse_y-mouse_yprevious));
		controller.scale_right_bottom += ((mouse_x-mouse_xprevious));
    }
    else
    {
	    controller.scale_bottom_right += ((mouse_y-mouse_yprevious)/256*$ffff);
		controller.scale_right_bottom += ((mouse_x-mouse_xprevious)/256*$ffff);
    }
	controller.scale_bottom_right = clamp(controller.scale_bottom_right, 0, $ffff);
	controller.scale_right_bottom = clamp(controller.scale_right_bottom, 0, $ffff);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
    if (mouse_check_button_released(mb_left))
    {
        save_profile();
        moving = 0;
    }
}

else
{
    var t_withinblindzone = false;
    var t_list = controller.blindzone_list;
    for (i = 0; i < ds_list_size(t_list); i+=4)
    {   
        if ( (mouse_x > (x+t_list[| i+0]/$FFFF*256-2)) &&
             (mouse_y > (y+t_list[| i+2]/$FFFF*256-2)) &&
             (mouse_x < (x+t_list[| i+1]/$FFFF*256+2)) &&
             (mouse_y < (y+t_list[| i+3]/$FFFF*256+2))  )
        {
            //within blind zone
            t_withinblindzone = true;
            if (mouse_x < (x+t_list[| i+0]/$FFFF*256+5))
            {   
                controller.scrollcursor_flag = 1;
                controller.tooltip = "Drag side to resize blind zone.\nHold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mouse_xprevious = mouse_x;
                    mouse_yprevious = mouse_y;
                    moving = 6;
                    blindzonetoedit = i;
                }
                exit;
            }
            else if (mouse_x > (x+t_list[| i+1]/$FFFF*256-5))
            {   
                controller.scrollcursor_flag = 1;
                controller.tooltip = "Drag side to resize blind zone.\nHold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mouse_xprevious = mouse_x;
                    mouse_yprevious = mouse_y;
                    moving = 7;
                    blindzonetoedit = i;
                }
                exit;
            }
            else if (mouse_y < (y+t_list[| i+2]/$FFFF*256+5))
            {   
                controller.scrollcursor_flag = 2;
                controller.tooltip = "Drag side to resize blind zone.\nHold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mouse_xprevious = mouse_x;
                    mouse_yprevious = mouse_y;
                    moving = 8;
                    blindzonetoedit = i;
                }
                exit;
            }
            else if (mouse_y > (y+t_list[| i+3]/$FFFF*256-5))
            {   
                controller.scrollcursor_flag = 2;
                controller.tooltip = "Drag side to resize blind zone.\nHold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mouse_xprevious = mouse_x;
                    mouse_yprevious = mouse_y;
                    moving = 9;
                    blindzonetoedit = i;
                    
                }
                exit;
            }
            else
            {
                controller.tooltip = "Drag to move this blind zone.\nHold CTRL to drag more slowly.\nRight click for more options.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mouse_xprevious = mouse_x;
                    mouse_yprevious = mouse_y;
                    moving = 10;
                    blindzonetoedit = i;
                }
                if (mouse_check_button_pressed(mb_right))
                {
                    blindzonetoedit = i;
                    dropdown_blindzone();
                }
                exit;
            }
        }
                        
    }
    
    if (!t_withinblindzone)
    {
		if (mode == 0)
		{
	        if ((mouse_x > (x+controller.scale_left_top/$FFFF*256-2)) &&
	            (mouse_y > (y+controller.scale_top_left/$FFFF*256-2)) && 
	            (mouse_x < (x+controller.scale_right_top/$FFFF*256+2)) &&
	            (mouse_y < (y+controller.scale_bottom_left/$FFFF*256+2)) )
	        {
	            //within projector window
	            if (mouse_x < (x+controller.scale_left_top/$FFFF*256+5))
	            {   
	                controller.scrollcursor_flag = 1;
	                controller.tooltip = "Drag side to resize projection window.\nHold CTRL to drag more slowly.";
	                if (mouse_check_button_pressed(mb_left))
	                {
	                    mouse_xprevious = mouse_x;
	                    mouse_yprevious = mouse_y;
	                    moving = 1;
	                }
	                exit;
	            }
	            else if (mouse_x > (x+controller.scale_right_top/$FFFF*256-5))
	            {   
	                controller.scrollcursor_flag = 1;
	                controller.tooltip = "Drag side to resize projection window.\nHold CTRL to drag more slowly.";
	                if (mouse_check_button_pressed(mb_left))
	                {
	                    mouse_xprevious = mouse_x;
	                    mouse_yprevious = mouse_y;
	                    moving = 2;
	                }
	                exit;
	            }
	            else if (mouse_y < (y+controller.scale_top_left/$FFFF*256+5))
	            {   
	                controller.scrollcursor_flag = 2;
	                controller.tooltip = "Drag side to resize projection window.\nHold CTRL to drag more slowly.";
	                if (mouse_check_button_pressed(mb_left))
	                {
	                    mouse_xprevious = mouse_x;
	                    mouse_yprevious = mouse_y;
	                    moving = 3;
	                }
	                exit;
	            }
	            else if (mouse_y > (y+controller.scale_bottom_left/$FFFF*256-5))
	            {   
	                controller.scrollcursor_flag = 2;
	                controller.tooltip = "Drag side to resize projection window.\nHold CTRL to drag more slowly.";
	                if (mouse_check_button_pressed(mb_left))
	                {
	                    mouse_xprevious = mouse_x;
	                    mouse_yprevious = mouse_y;
	                    moving = 4;
	                }
	                exit;
	            }
	            else
	            {
	                controller.tooltip = "Drag to move projection window.\nHold CTRL to drag more slowly.\nRight click for more options.";
	                if (mouse_check_button_pressed(mb_left))
	                {
	                    mouse_xprevious = mouse_x;
	                    mouse_yprevious = mouse_y;
	                    moving = 5;
	                }
	                if (mouse_check_button_pressed(mb_right))
	                {
	                    dropdown_projectionwindow();
	                }
	                exit;
	            }
			}
        }
		else if (mode == 1)
		{
			if (point_distance(	window_mouse_get_x(), window_mouse_get_y()-23,
								x+controller.scale_left_top/$ffff*256, y+controller.scale_top_left/$ffff*256) < 3)
			{
				controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
				if (mouse_check_button_pressed(mb_left))
	            {
	                mouse_xprevious = mouse_x;
	                mouse_yprevious = mouse_y;
	                moving = 11;
	            }
	            exit;
			}
			if (point_distance(	window_mouse_get_x(), window_mouse_get_y()-23,
								x+controller.scale_right_top/$ffff*256, y+controller.scale_top_right/$ffff*256) < 3)
			{
				controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
				if (mouse_check_button_pressed(mb_left))
	            {
	                mouse_xprevious = mouse_x;
	                mouse_yprevious = mouse_y;
	                moving = 12;
	            }
	            exit;
			}
			if (point_distance(	window_mouse_get_x(), window_mouse_get_y()-23,
								x+controller.scale_left_bottom/$ffff*256, y+controller.scale_bottom_left/$ffff*256) < 3)
			{
				controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
				if (mouse_check_button_pressed(mb_left))
	            {
	                mouse_xprevious = mouse_x;
	                mouse_yprevious = mouse_y;
	                moving = 13;
	            }
	            exit;
			}
			if (point_distance(	window_mouse_get_x(), window_mouse_get_y()-23,
								x+controller.scale_right_bottom/$ffff*256, y+controller.scale_bottom_right/$ffff*256) < 3)
			{
				controller.tooltip = "Drag corner to shape projection window.\nHold CTRL to drag more slowly.";
				if (mouse_check_button_pressed(mb_left))
	            {
	                mouse_xprevious = mouse_x;
	                mouse_yprevious = mouse_y;
	                moving = 14;
	            }
	            exit;
			}
		}
    }

}

