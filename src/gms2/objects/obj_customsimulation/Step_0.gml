if (moving == 1)
{
    scrollx += (mouse_y-mouse_yprevious)*scrollh/list_height;
    scrollx = clamp(scrollx,0,scrollh-scrollw);
    mouse_yprevious = mouse_y;
    controller.tooltip = "Drag to scroll the list of timeline layers.";
    if (!mouse_check_button(mb_left))
    {
        moving = 0;
    }
    exit;
}
else if (moving == 2)
{
	// moving projector offset
	if (selected >= ds_list_size(seqcontrol.layer_list))
		moving = 0;
		
	var t_thisplist = seqcontrol.layer_list[| selected];
	t_thisplist[| 6] += (mouse_x-mouse_xprevious)/canvas_width*0xffff;
	t_thisplist[| 7] += (mouse_y-mouse_yprevious)/canvas_width*0xffff;
	t_thisplist[| 6] = clamp(t_thisplist[| 6], -0x8000, 0x8000);
	t_thisplist[| 7] = clamp(t_thisplist[| 7], -0x8000, 0x8000);
	mouse_yprevious = mouse_y;
	mouse_xprevious = mouse_x;
	controller.tooltip = "Click and drag the projector to change the position of the simulated projector for the selected layer.";
	if (surface_exists(surf_projectorlist))
		surface_free(surf_projectorlist);
	
	if (!mouse_check_button(mb_left))
    {
        moving = 0;
    }
    exit;
}

if (instance_exists(obj_dropdown))
    exit;
    
if (scrollh > list_height)
&& (mouse_y == clamp(mouse_y, y+(scrollx)/(scrollh-scrollw)*(list_height-scrollw), y+(scrollx)/(scrollh-scrollw)*(list_height-scrollw)+scrollw)) 
&& (mouse_x == clamp(mouse_x, x+list_width, x+list_width+20))
{
    controller.tooltip = "Drag to scroll the list of timeline layers.";
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
else if (mouse_y == clamp(mouse_y, y, y+list_height)) 
    &&  (mouse_x == clamp(mouse_x, x, x+list_width))
{
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
    
    var t_item_mouseover = (scrollx + (mouse_y - y)) div itemh;
    var t_item = -1;
    for (i = 0; i < ds_list_size(seqcontrol.layer_list); i++)
    {
        t_item++;
        if (t_item == t_item_mouseover)
        {
            //mouse over projector i
            controller.tooltip = "Click to view or set the position of the projector in the simulated preview of this layer.";
            if (mouse_check_button_pressed(mb_left))
            {
                selected = i;
				if (surface_exists(surf_projectorlist))
					surface_free(surf_projectorlist);
            }
            exit;
        }
    }
}
else if (mouse_y == clamp(mouse_y, y-10, y+canvas_width+10)) 
    &&  (mouse_x == clamp(mouse_x, x+canvas_x-10, x+canvas_x+canvas_width+10))
{
	if (selected < ds_list_size(seqcontrol.layer_list))
	{
		var t_thisplist = seqcontrol.layer_list[| selected];
		if (mouse_y == clamp(mouse_y, y+canvas_width/2+canvas_width/$ffff*t_thisplist[| 7]-10, y+canvas_width/2+canvas_width/$ffff*t_thisplist[| 7]+10)) 
		&&  (mouse_x == clamp(mouse_x, x+canvas_x+canvas_width/2+canvas_width/$ffff*t_thisplist[| 6]-10, x+canvas_x+canvas_width/2+canvas_width/$ffff*t_thisplist[| 6]+10))
		{
			controller.tooltip = "Click and drag the projector to change the position of the simulated projector for the selected layer.";
            if (mouse_check_button_pressed(mb_left))
            {
                moving = 2;
				mouse_yprevious = mouse_y;
				mouse_xprevious = mouse_x;
            }
		}
	}
}
