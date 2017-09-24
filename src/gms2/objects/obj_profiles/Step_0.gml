if (moving == 1)
{
    scrollx += (mouse_y-mouseyprev)*scrollh/list_height;
    scrollx = clamp(scrollx,0,scrollh-scrollw);
    mouseyprev = mouse_y;
    controller.tooltip = "Drag to scroll the list of settings profiles.";
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
    controller.tooltip = "Drag to scroll the list of settings profiles.";
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
    
    var t_dac_mouseover = (scrollx + (mouse_y - y)) div itemh;
    if (t_dac_mouseover < ds_list_size(controller.profile_list))
    {
        controller.tooltip = "Click to select and load settings profile. Right click for options.";
        if (mouse_check_button_pressed(mb_left))
        {
            controller.projector = t_dac_mouseover;
            load_profile();
        }
        else if (mouse_check_button_pressed(mb_right))
        {
            controller.profiletoselect = t_dac_mouseover;
            dropdown_profile();
        }
    }
    else
    {
        controller.tooltip = "Right click for options.";
        if (mouse_check_button_pressed(mb_right))
        {
            controller.profiletoselect = -1;
            dropdown_profile();
        }
    }
}

