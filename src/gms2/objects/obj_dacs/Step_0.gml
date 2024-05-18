if (moving == 1)
{
    scrollx += (mouse_y-mouse_yprevious)*scrollh/list_height;
    scrollx = clamp(scrollx,0,scrollh-scrollw);
    mouse_yprevious = mouse_y;
    controller.tooltip = "Drag to scroll the list of DACs/lasers.";
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
    controller.tooltip = "Drag to scroll the list of DACs/lasers.";
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
    
    var t_dac_mouseover = (scrollx + (mouse_y - y)) div itemh;
    if (t_dac_mouseover < ds_list_size(controller.dac_list))
    {
        controller.tooltip = "Left click to select DAC/laser as default output. Right click for options.";
        if (mouse_check_button_pressed(mb_left))
        {
            dac_select(t_dac_mouseover);
        }
        else if (mouse_check_button_pressed(mb_right))
        {
            settingscontrol.dactoselect = t_dac_mouseover;
            dropdown_dac();
        }
    }
    else
    {
        controller.tooltip = "Right click for options.";
        if (mouse_check_button_pressed(mb_right))
        {
            dropdown_dacs();
        }
    }   
}

