if (objmoving == 1)
    {
    anixtrans+= (obj_cursor.x-mousexprevious)*$ffff/512;
    aniytrans+= (obj_cursor.y-mouseyprevious)*$ffff/512;
    mousexprevious = obj_cursor.x;
    mouseyprevious = obj_cursor.y;
    if (mouse_check_button_released(mb_left))
        {
        objmoving = 0;
        reapply_trans();
        
        xo = ds_list_find_value(controller.selectedelementlist,0)/$ffff*512;
        yo = ds_list_find_value(controller.selectedelementlist,1)/$ffff*512;
        rectxmin = x+xo + (ds_list_find_value(controller.selectedelementlist,4));
        rectymin = y+yo + (ds_list_find_value(controller.selectedelementlist,6));
        rectxmax = x+xo + (ds_list_find_value(controller.selectedelementlist,5));
        rectymax = y+yo + (ds_list_find_value(controller.selectedelementlist,7));
        }
    }
else if (objmoving == 2)    
    {
    anchorx += (obj_cursor.x-mousexprevious)*$ffff/512;
    anchory += (obj_cursor.y-mouseyprevious)*$ffff/512;
    mousexprevious = obj_cursor.x;
    mouseyprevious = obj_cursor.y;
    if (mouse_check_button_released(mb_left))
        {
        objmoving = 0;
        }
    }
else
    {
    if (mouse_x == clamp(mouse_x,anchorx/$ffff*512-10,anchorx/$ffff*512+10)) and (mouse_y == clamp(mouse_y,anchory/$ffff*512-10,anchory/$ffff*512+10))
        {
        tooltip = "Click and drag to move the rotation anchor point."
        if (mouse_check_button_pressed(mb_left)) 
            {
            objmoving = 2;
            mousexprevious = obj_cursor.x;
            mouseyprevious = obj_cursor.y;
            }
        }
    else if (mouse_x == clamp(mouse_x,rectxmin,rectxmax)) and (mouse_y == clamp(mouse_y,rectymin,rectymax))
        {
        tooltip = "Click and drag to move the selected object.#If animation is enabled, the movement will be animated."
        if (mouse_check_button_pressed(mb_left)) 
            {
            objmoving = 1;
            anixtrans = 0;
            aniytrans = 0;
            mousexprevious = obj_cursor.x;
            mouseyprevious = obj_cursor.y;
            }
        }
    }
