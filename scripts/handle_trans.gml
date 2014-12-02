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
        
        xo = ds_list_find_value(selectedelementlist,0)/$ffff*512;
        yo = ds_list_find_value(selectedelementlist,1)/$ffff*512;
        rectxmin = x+xo + (ds_list_find_value(selectedelementlist,4));
        rectymin = y+yo + (ds_list_find_value(selectedelementlist,6));
        rectxmax = x+xo + (ds_list_find_value(selectedelementlist,5));
        rectymax = y+yo + (ds_list_find_value(selectedelementlist,7));
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
    mouseangle = point_direction(obj_cursor.x,obj_cursor.y,anchorx/$ffff*512,anchory/$ffff*512);
    
    if ((mouseangleprevious-mouseangle) > 180)
        anirot-=360;
    else if ((mouseangleprevious-mouseangle) < -180)
        anirot+=360;
        
    anirot+= mouseangleprevious-mouseangle;
    
    mouseangleprevious = mouseangle;
    
    if (mouse_check_button_released(mb_left))
        {
        objmoving = 0;
        reapply_trans();
        
        xo = ds_list_find_value(selectedelementlist,0)/$ffff*512;
        yo = ds_list_find_value(selectedelementlist,1)/$ffff*512;
        rectxmin = x+xo + (ds_list_find_value(selectedelementlist,4));
        rectymin = y+yo + (ds_list_find_value(selectedelementlist,6));
        rectxmax = x+xo + (ds_list_find_value(selectedelementlist,5));
        rectymax = y+yo + (ds_list_find_value(selectedelementlist,7));
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
        
        xo = ds_list_find_value(selectedelementlist,0)/$ffff*512;
        yo = ds_list_find_value(selectedelementlist,1)/$ffff*512;
        rectxmin = x+xo + (ds_list_find_value(selectedelementlist,4));
        rectymin = y+yo + (ds_list_find_value(selectedelementlist,6));
        rectxmax = x+xo + (ds_list_find_value(selectedelementlist,5));
        rectymax = y+yo + (ds_list_find_value(selectedelementlist,7));
        }
    }
else
    {
    if (mouse_x == clamp(mouse_x,anchorx/$ffff*512-10,anchorx/$ffff*512+10)) and (mouse_y == clamp(mouse_y,anchory/$ffff*512-10,anchory/$ffff*512+10))
        {
        tooltip = "Click and drag to move the rotation anchor point.#Right click to move to center of object."
        if (mouse_check_button_pressed(mb_left)) 
            {
            objmoving = 2;
            mousexprevious = obj_cursor.x;
            mouseyprevious = obj_cursor.y;
            }
        else if (mouse_check_button_pressed(mb_right)) 
            {
            anchorx = (rectxmin+rectxmax)*128/2;
            anchory = (rectymin+rectymax)*128/2;
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
        tooltip = "Click and drag to rotate the selected object around the anchor.#If animation is enabled, the rotation will be animated.#Right click to enter precise rotation amount."
        if (mouse_check_button_pressed(mb_left)) 
            {
            objmoving = 3;
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            mouseangleprevious = point_direction(obj_cursor.x,obj_cursor.y,anchorx/$ffff*512,anchory/$ffff*512);
            }
        if (mouse_check_button_pressed(mb_right)) 
            {
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            dialog = "anirot";
            getint = get_integer_async("Enter the amount of degrees to rotate.",0);
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