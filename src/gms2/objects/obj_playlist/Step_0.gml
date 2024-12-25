if (moving == 1)
{
    scrollx += (mouse_y-mouse_yprevious)*scrollh/list_height;
    scrollx = clamp(scrollx,0,scrollh-scrollw);
    mouse_yprevious = mouse_y;
    controller.tooltip = "Drag to scroll the playlist of queued shows.";
    if (!mouse_check_button(mb_left))
    {
        moving = 0;
    }
    exit;
}

if (instance_exists(obj_dropdown) || seqcontrol.largepreview)
    exit;
    
if (scrollh > list_height)
&& (mouse_y == clamp(mouse_y, y+(scrollx)/(scrollh-scrollw)*(list_height-scrollw)*controller.dpi_multiplier, y+((scrollx)/(scrollh-scrollw)*(list_height-scrollw)+scrollw)*controller.dpi_multiplier)) 
&& (mouse_x == clamp(mouse_x, x+list_width*controller.dpi_multiplier, x+(list_width+20)*controller.dpi_multiplier))
{
    controller.tooltip = "Drag to scroll the playlist of queued shows.";
    if (mouse_check_button_pressed(mb_left))
    {
        moving = 1;
        mouse_yprevious = mouse_y;
    }
    else if (mouse_wheel_up())
    {
        scrollx -= itemh;
        scrollx = clamp(scrollx,0,scrollh-scrollw);
    }
    else if (mouse_wheel_down())
    {
        scrollx += itemh;
        scrollx = clamp(scrollx,0,scrollh-scrollw);
    }
}
else if (mouse_y == clamp(mouse_y, y, y+list_height*controller.dpi_multiplier)) 
    &&  (mouse_x == clamp(mouse_x, x, x+list_width*controller.dpi_multiplier))
{
	if (mouse_x == clamp(mouse_x, x + (list_width - 24)*controller.dpi_multiplier, x + (list_width - 8)*controller.dpi_multiplier) && mouse_y == clamp(mouse_y, y + (list_height - 24)*controller.dpi_multiplier, y + (list_height - 8)*controller.dpi_multiplier))
	{
		controller.tooltip = "Click to add a project to the playlist.";
		if (mouse_check_button_pressed(mb_left) && !controller.menu_open)
		{
			dd_seq_playlist_add();
		}
		mouseover_addbutton = true;
		exit;
	}
	else
		mouseover_addbutton = false;
	
    if (mouse_wheel_up())
    {
        scrollx -= itemh;
        scrollx = clamp(scrollx,0,scrollh-scrollw);
    }
    else if (mouse_wheel_down())
    {
        scrollx += itemh;
        scrollx = clamp(scrollx,0,scrollh-scrollw);
    }
    
    var t_mouseover = (scrollx + (mouse_y - y)) div (itemh*controller.dpi_multiplier);
    if (t_mouseover < ds_list_size(seqcontrol.playlist_list))
    {
        controller.tooltip = "Right click for options.";
        if (mouse_check_button_pressed(mb_right))
        {
            seqcontrol.playlist_list_to_select = t_mouseover;
            dropdown_playlist_item();
        }
    }
    else
    {
        controller.tooltip = "Right click for options.";
        if (mouse_check_button_pressed(mb_right))
        {
            seqcontrol.playlist_list_to_select = -1;
            dropdown_playlist();
        }
    }
}

