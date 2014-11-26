if (objmoving == 1)
    {
    if (!keyboard_check(vk_control))
        {
        anixtrans+= (obj_cursor.x-mousexprevious)*$ffff/512;
        aniytrans+= (obj_cursor.y-mouseyprevious)*$ffff/512;
        }
    else
        {
        anirot+= (obj_cursor.x-mousexprevious);
        //anirot+= (obj_cursor.y-mouseyprevious)*$ffff/1024;
        }
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
else if (objmoving == 3)
    {
    anirot+= (obj_cursor.x-mousexprevious);
    //anirot+= (obj_cursor.y-mouseyprevious);
    
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
else if (objmoving == 4)
    {
    if (!keyboard_check(vk_control))
        {
        scalex+= (obj_cursor.x-mousexprevious)/150;
        scaley+= (obj_cursor.y-mouseyprevious)/150;
        }
    else
        {
        scalex+= (obj_cursor.x-mousexprevious)/150;
        scaley+= (obj_cursor.x-mousexprevious)/150;
        }    
    
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
    else if (mouse_x == clamp(mouse_x,rectxmin-2,rectxmax+2)) and (mouse_y == clamp(mouse_y,rectymin-2,rectymax+2))
        {
        tooltip = "Click and drag to move the selected object.#If animation is enabled, the movement will be animated."
        if (mouse_check_button_pressed(mb_left)) 
            {
            objmoving = 1;
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            mousexprevious = obj_cursor.x;
            mouseyprevious = obj_cursor.y;
            }
        }
    else if (mouse_x == clamp(mouse_x,rectxmin-20,rectxmin-2)) and (mouse_y == clamp(mouse_y,rectymax+2,rectymax+20))
        {
        tooltip = "Click and drag to rotate the selected object around the anchor.#If animation is enabled, the rotation will be animated."
        if (mouse_check_button_pressed(mb_left)) 
            {
            objmoving = 3;
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            mousexprevious = obj_cursor.x;
            mouseyprevious = obj_cursor.y;
            }
        }
    else if (mouse_x == clamp(mouse_x,rectxmax+2,rectxmax+20)) and (mouse_y == clamp(mouse_y,rectymax+2,rectymax+20))
        {
        tooltip = "Click and drag to resize the selected object around the anchor.#If animation is enabled, the change will be animated."
        if (mouse_check_button_pressed(mb_left)) 
            {
            objmoving = 4;
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            mousexprevious = obj_cursor.x;
            mouseyprevious = obj_cursor.y;
            }
        }
    }
