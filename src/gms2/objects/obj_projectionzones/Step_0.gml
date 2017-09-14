controller.scrollcursor_flag = 0;

if (moving == 1)
{
    //x start
    controller.scrollcursor_flag = 1;
    if (keyboard_check(vk_control))
    {
        controller.x_scale_start += ((mouse_x-mousexprevious)*4);
        if (controller.x_scale_start < 0)
            controller.x_scale_start = 0;
        if (controller.x_scale_start > controller.x_scale_end-1)
            controller.x_scale_start = controller.x_scale_end-1;
    }
    else
    {
        controller.x_scale_start += ((mouse_x-mousexprevious)*$ffff/256);
        if (controller.x_scale_start < 0)
            controller.x_scale_start = 0;
        if (controller.x_scale_start > controller.x_scale_end-4096)
            controller.x_scale_start = controller.x_scale_end-4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        controller.x_scale_end += ((mouse_x-mousexprevious)*4);
        if (controller.x_scale_end > $FFFF)
            controller.x_scale_end = $FFFF;
        if (controller.x_scale_end < controller.x_scale_start+1)
            controller.x_scale_end = controller.x_scale_start+1;
    }
    else
    {
        controller.x_scale_end += ((mouse_x-mousexprevious)*$ffff/256);
        if (controller.x_scale_end > $FFFF)
            controller.x_scale_end = $FFFF;
        if (controller.x_scale_end < controller.x_scale_start+4096)
            controller.x_scale_end = controller.x_scale_start+4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        controller.y_scale_start += ((mouse_y-mouseyprevious)*4);
        if (controller.y_scale_start < 0)
            controller.y_scale_start = 0;
        if (controller.y_scale_start > controller.y_scale_end-4096)
            controller.y_scale_start = controller.y_scale_end-4096;
    }
    else
    {
        controller.y_scale_start += ((mouse_y-mouseyprevious)*$ffff/256);
        if (controller.y_scale_start < 0)
            controller.y_scale_start = 0;
        if (controller.y_scale_start > controller.y_scale_end-4096)
            controller.y_scale_start = controller.y_scale_end-4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        controller.y_scale_end += ((mouse_y-mouseyprevious)*4);
        if (controller.y_scale_end > $FFFF)
            controller.y_scale_end = $FFFF;
        if (controller.y_scale_end < controller.y_scale_start+1)
            controller.y_scale_end = controller.y_scale_start+1;
    }
    else
    {
        controller.y_scale_end += ((mouse_y-mouseyprevious)*$ffff/256);
        if (controller.y_scale_end > $FFFF)
            controller.y_scale_end = $FFFF;
        if (controller.y_scale_end < controller.y_scale_start+4096)
            controller.y_scale_end = controller.y_scale_start+4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        controller.y_scale_end += ((mouse_y-mouseyprevious)*4);
        controller.y_scale_start += ((mouse_y-mouseyprevious)*4);
        controller.x_scale_end += ((mouse_x-mousexprevious)*4);
        controller.x_scale_start += ((mouse_x-mousexprevious)*4);
    }
    else
    {
        controller.y_scale_end += ((mouse_y-mouseyprevious)*$ffff/256);
        controller.y_scale_start += ((mouse_y-mouseyprevious)*$ffff/256);
        controller.x_scale_end += ((mouse_x-mousexprevious)*$ffff/256);
        controller.x_scale_start += ((mouse_x-mousexprevious)*$ffff/256);
    }
    if (controller.x_scale_start < 0)
    {
        controller.x_scale_end += abs(controller.x_scale_start);
        controller.x_scale_start = 0;
    }
    if (controller.x_scale_end > $FFFF)
    {
        controller.x_scale_start -= controller.x_scale_end-$FFFF;
        controller.x_scale_end = $FFFF;
    }
    if (controller.y_scale_start < 0)
    {
        controller.y_scale_end += abs(controller.y_scale_start);
        controller.y_scale_start = 0;
    }
    if (controller.y_scale_end > $FFFF)
    {
        controller.y_scale_start -= controller.y_scale_end-$FFFF;
        controller.y_scale_end = $FFFF;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        t_list[| i] = t_list[| i]+((mouse_x-mousexprevious)*4);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-1)
            t_list[| i] = t_list[| i+1]-1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_x-mousexprevious)*$ffff/256);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-4096)
            t_list[| i] = t_list[| i+1]-4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        t_list[| i] = t_list[| i]+((mouse_x-mousexprevious)*4);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+1)
            t_list[| i] = t_list[| i-1]+1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_x-mousexprevious)*$ffff/256);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+4096)
            t_list[| i] = t_list[| i-1]+4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        t_list[| i] = t_list[| i]+((mouse_y-mouseyprevious)*4);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-1)
            t_list[| i] = t_list[| i+1]-1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_y-mouseyprevious)*$ffff/256);
        if (t_list[| i] < 0)
            t_list[| i] = 0;
        if (t_list[| i] > t_list[| i+1]-4096)
            t_list[| i] = t_list[| i+1]-4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        t_list[| i] = t_list[| i]+((mouse_y-mouseyprevious)*4);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+1)
            t_list[| i] = t_list[| i-1]+1;
    }
    else
    {
        t_list[| i] = t_list[| i]+((mouse_y-mouseyprevious)*$ffff/256);
        if (t_list[| i] > $FFFF)
            t_list[| i] = $FFFF;
        if (t_list[| i] < t_list[| i-1]+4096)
            t_list[| i] = t_list[| i-1]+4096;
    }
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
        t_list[| i+0] = t_list[| i+0]+((mouse_x-mousexprevious)*4);
        t_list[| i+1] = t_list[| i+1]+((mouse_x-mousexprevious)*4);
        t_list[| i+2] = t_list[| i+2]+((mouse_y-mouseyprevious)*4);
        t_list[| i+3] = t_list[| i+3]+((mouse_y-mouseyprevious)*4);
    }
    else
    {
        t_list[| i+0] = t_list[| i+0]+((mouse_x-mousexprevious)*$ffff/256);
        t_list[| i+1] = t_list[| i+1]+((mouse_x-mousexprevious)*$ffff/256);
        t_list[| i+2] = t_list[| i+2]+((mouse_y-mouseyprevious)*$ffff/256);
        t_list[| i+3] = t_list[| i+3]+((mouse_y-mouseyprevious)*$ffff/256);
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
    mousexprevious = mouse_x;
    mouseyprevious = mouse_y;
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
                controller.tooltip = "Drag side to resize blind zone.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 6;
                    blindzonetoedit = i;
                }
                exit;
            }
            else if (mouse_x > (x+t_list[| i+1]/$FFFF*256-5))
            {   
                controller.scrollcursor_flag = 1;
                controller.tooltip = "Drag side to resize blind zone.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 7;
                    blindzonetoedit = i;
                }
                exit;
            }
            else if (mouse_y < (y+t_list[| i+2]/$FFFF*256+5))
            {   
                controller.scrollcursor_flag = 2;
                controller.tooltip = "Drag side to resize blind zone.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 8;
                    blindzonetoedit = i;
                }
                exit;
            }
            else if (mouse_y > (y+t_list[| i+3]/$FFFF*256-5))
            {   
                controller.scrollcursor_flag = 2;
                controller.tooltip = "Drag side to resize blind zone.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 9;
                    blindzonetoedit = i;
                    
                }
                exit;
            }
            else
            {
                controller.tooltip = "Drag to move this blind zone.#Hold CTRL to drag more slowly.#Right click for more options.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
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
        if ((mouse_x > (x+controller.x_scale_start/$FFFF*256-2)) &&
            (mouse_y > (y+controller.y_scale_start/$FFFF*256-2)) && 
            (mouse_x < (x+controller.x_scale_end/$FFFF*256+2)) &&
            (mouse_y < (y+controller.y_scale_end/$FFFF*256+2)) )
        {
            //within projector window
            if (mouse_x < (x+controller.x_scale_start/$FFFF*256+5))
            {   
                controller.scrollcursor_flag = 1;
                controller.tooltip = "Drag side to resize projection window.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 1;
                    
                }
                exit;
            }
            else if (mouse_x > (x+controller.x_scale_end/$FFFF*256-5))
            {   
                controller.scrollcursor_flag = 1;
                controller.tooltip = "Drag side to resize projection window.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 2;
                    
                }
                exit;
            }
            else if (mouse_y < (y+controller.y_scale_start/$FFFF*256+5))
            {   
                controller.scrollcursor_flag = 2;
                controller.tooltip = "Drag side to resize projection window.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 3;
                    
                }
                exit;
            }
            else if (mouse_y > (y+controller.y_scale_end/$FFFF*256-5))
            {   
                controller.scrollcursor_flag = 2;
                controller.tooltip = "Drag side to resize projection window.#Hold CTRL to drag more slowly.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
                    moving = 4;
                    
                }
                exit;
            }
            else
            {
                controller.tooltip = "Drag to move projection window.#Hold CTRL to drag more slowly.#Right click for more options.";
                if (mouse_check_button_pressed(mb_left))
                {
                    mousexprevious = mouse_x;
                    mouseyprevious = mouse_y;
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

}

