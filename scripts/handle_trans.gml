if (objmoving == 1)
    {
    //translate
    anixtrans+= (obj_cursor.x-mousexprevious)*$ffff/512;
    aniytrans+= (obj_cursor.y-mouseyprevious)*$ffff/512;
    mousexprevious = obj_cursor.x;
    mouseyprevious = obj_cursor.y;
    
    if (mouse_check_button_released(mb_left))
        {
        objmoving = 0;
        reapply_trans();
        
        update_semasterlist();
        }
    }
else if (objmoving == 2)    
    {
    //anchor
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
    //rotate
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
        }
    }
else if (objmoving == 4)
    {
    //resize
    if (!keyboard_check(vk_control))
        {
        scalex+= (obj_cursor.x-mousexprevious)/(rectxmax-rectxmin)*2;
        scaley+= (obj_cursor.y-mouseyprevious)/(rectymax-rectymin)*2;
        }
    else
        {
        scalex+= (obj_cursor.x-mousexprevious)/(rectxmax-rectxmin)*2;
        scaley+= (obj_cursor.x-mousexprevious)/(rectxmax-rectxmin)*2;
        }  
          
    mousexprevious = obj_cursor.x;
    mouseyprevious = obj_cursor.y;
    
    if (mouse_check_button_released(mb_left))
        {
        objmoving = 0;
        reapply_trans();
        }
    }
else if !keyboard_check(vk_control)
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
        tooltip = "Click and drag to move the selected object.#If animation is enabled, the movement will be animated.#Right click for other actions."
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
        else if (mouse_check_button_pressed(mb_right)) 
            {
            dropdown_object();
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
        else if (mouse_check_button_pressed(mb_right)) 
            {
            anixtrans = 0;
            aniytrans = 0;
            scalex = 1;
            scaley = 1;
            dialog = "anirot";
            getint = get_integer_async("Enter the amount of degrees to rotate.",0);
            }
        }
    else if (mouse_x == clamp(mouse_x,rectxmax+2,rectxmax+20)) and (mouse_y == clamp(mouse_y,rectymax+2,rectymax+20))
        {
        tooltip = "Click and drag to resize the selected object around the anchor.#Hold Ctrl to resize X and Y the same amount.#Right click to enter precise scaling amount.#If animation is enabled, the change will be animated."
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
        else if (mouse_check_button_pressed(mb_right)) 
            {
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            dialog = "aniscale";
            getint = get_integer_async("Enter the scaling multiplier (F.ex. 1 is no change, 2 is double the size)",1);
            }
        }
    else return 0;
    }
return 1;
