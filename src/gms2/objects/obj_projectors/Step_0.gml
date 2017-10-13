if (moving == 1)
{
    scrollx += (mouse_y-mouseyprev)*scrollh/list_height;
    scrollx = clamp(scrollx,0,scrollh-scrollw);
    mouseyprev = mouse_y;
    controller.tooltip = "Drag to scroll the list of timeline layers.";
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
        mouseyprev = mouse_y;
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
            controller.tooltip = "Right click timeline layer for options.";
            if (mouse_check_button_pressed(mb_right))
            {
                settingscontrol.projectortoselect = i;
                dropdown_projector();
            }
            exit;
        }
        var t_thisplist = seqcontrol.layer_list[| i];
        for (j = 0; j < ds_list_size(t_thisplist[| 5]); j++)
        {
            t_item++;
            if (t_item == t_item_mouseover)
            {
                //mouse over dac j in projector i
                controller.tooltip = "Right click the DACs in the timeline layer list for options.";
                if (mouse_check_button_pressed(mb_right))
                {
                    settingscontrol.projectortoselect = i;
                    settingscontrol.dactoselect = j;
                    dropdown_projector_dac();
                }
                exit;
            }
        }
        if (ds_list_size(t_thisplist[| 5]) == 0)
            t_item++;
    }
}

