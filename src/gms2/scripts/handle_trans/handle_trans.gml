if (objmoving == 1)
{
    //translate
    anixtrans += (obj_cursor.x-mouse_xprevious)*$ffff/view_wport[4];
    aniytrans += (obj_cursor.y-mouse_ypreviousious)*$ffff/view_wport[4];
    mouse_xprevious = obj_cursor.x;
    mouse_ypreviousious = obj_cursor.y;
    
    if (mouse_check_button_released(mb_left))
    {
        objmoving = 0;
        reapply_trans();
        
        update_semasterlist_flag = 1;
    }
}
else if (objmoving == 2)    
{
    //anchor
    anchorx += (obj_cursor.x-mouse_xprevious)*$ffff/view_wport[4];
    anchory += (obj_cursor.y-mouse_ypreviousious)*$ffff/view_wport[4];
    mouse_xprevious = obj_cursor.x;
    mouse_ypreviousious = obj_cursor.y;
    if (mouse_check_button_released(mb_left))
    {
        objmoving = 0;
    }
	anchorx = clamp(anchorx, 0, $ffff);
	anchory = clamp(anchory, 0, $ffff);
}
else if (objmoving == 3)
{
    //rotate
    mouseangle = point_direction(obj_cursor.x,obj_cursor.y,anchorx/$ffff*view_wport[4],anchory/$ffff*view_wport[4]);
    
    if ((mouseangleprevious-mouseangle) > 180)
        anirot -= 360;
    else if ((mouseangleprevious-mouseangle) < -180)
        anirot += 360;
        
    anirot += mouseangleprevious-mouseangle;
    
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
        scalex+= (obj_cursor.x-mouse_xprevious)/max(1,(rectxmax-rectxmin)/$ffff*view_wport[4])*2;
        scaley+= (obj_cursor.y-mouse_ypreviousious)/max(1,(rectymax-rectymin)/$ffff*view_wport[4])*2;
    }
    else
    {
        scalex+= (obj_cursor.x-mouse_xprevious)/max(1,(rectxmax-rectxmin)/$ffff*view_wport[4])*2;
        scaley+= (obj_cursor.x-mouse_xprevious)/max(1,(rectymax-rectymin)/$ffff*view_wport[4])*2;
    }  
          
    mouse_xprevious = obj_cursor.x;
    mouse_ypreviousious = obj_cursor.y;
    
    if (mouse_check_button_released(mb_left))
    {
        objmoving = 0;
        reapply_trans();
    }
}
else if !(keyboard_check(vk_control)) and (!object_select_hovering)
{
	if (window_mouse_get_x() > view_wport[4] or window_mouse_get_y()-23 > view_wport[4])
		exit;
		
    if	(window_mouse_get_x() == clamp(window_mouse_get_x(), anchorx/$ffff*view_wport[4]-10, anchorx/$ffff*view_wport[4]+10)) and 
		(window_mouse_get_y()-23 == clamp(window_mouse_get_y()-23, anchory/$ffff*view_wport[4]-10, anchory/$ffff*view_wport[4]+10))
    {
        tooltip = "Click and drag to move the rotation/scaling anchor point.\nRight click to move to center of object.";
		if (mouse_check_button_pressed(mb_left)) 
        {
            objmoving = 2;
            mouse_xprevious = obj_cursor.x;
            mouse_ypreviousious = obj_cursor.y;
        }
        else if (mouse_check_button_pressed(mb_right)) 
        {
            anchorx = (rectxmin+rectxmax)/2;
            anchory = (rectymin+rectymax)/2;
        }
    }
    else if (window_mouse_get_x() == clamp(window_mouse_get_x(),rectxmin/$ffff*view_wport[4]-2,rectxmax/$ffff*view_wport[4]+2)) and 
			(window_mouse_get_y()-23 == clamp(window_mouse_get_y()-23,rectymin/$ffff*view_wport[4]-2,rectymax/$ffff*view_wport[4]+2))
    {
        tooltip = "Click and drag to move the selected object.\nIf animation is enabled, the movement will be animated.\nRight click for other actions.";
        if (mouse_check_button_pressed(mb_left)) 
        {
            objmoving = 1;
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            mouse_xprevious = obj_cursor.x;
            mouse_ypreviousious = obj_cursor.y;
        }
        else if (mouse_check_button_pressed(mb_right)) 
        {
            dropdown_object();
        }
    }
    else if (window_mouse_get_x() == clamp(window_mouse_get_x(),rectxmin/$ffff*view_wport[4]-20, rectxmin/$ffff*view_wport[4]-2)) and 
			(window_mouse_get_y()-23 == clamp(window_mouse_get_y()-23,rectymax/$ffff*view_wport[4]+2, rectymax/$ffff*view_wport[4]+20))
    {
        tooltip = "Click and drag to rotate the selected object around the anchor.\nIf animation is enabled, the rotation will be animated.\nRight click to enter precise rotation amount.";
		if (mouse_check_button_pressed(mb_left)) 
        {
            objmoving = 3;
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            mouseangleprevious = point_direction(obj_cursor.x,obj_cursor.y,anchorx/$ffff*view_wport[4],anchory/$ffff*view_wport[4]);
        }
        else if (mouse_check_button_pressed(mb_right)) 
        {
            anixtrans = 0;
            aniytrans = 0;
            scalex = 1;
            scaley = 1;
            ilda_dialog_num("anirot","Enter the amount of degrees to rotate.",0);
        }
    }
    else if (window_mouse_get_x() == clamp(window_mouse_get_x(),rectxmax/$ffff*view_wport[4]+2,rectxmax/$ffff*view_wport[4]+20)) and 
			(window_mouse_get_y()-23 == clamp(window_mouse_get_y()-23,rectymax/$ffff*view_wport[4]+2,rectymax/$ffff*view_wport[4]+20))
    {
        tooltip = "Click and drag to resize the selected object around the anchor.\nHold Ctrl to resize X and Y the same amount.\nRight click to enter precise scaling amount.\nIf animation is enabled, the change will be animated."
        if (mouse_check_button_pressed(mb_left)) 
        {
            objmoving = 4;
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            scalex = 1;
            scaley = 1;
            mouse_xprevious = obj_cursor.x;
            mouse_ypreviousious = obj_cursor.y;
        }
        else if (mouse_check_button_pressed(mb_right)) 
        {
            anixtrans = 0;
            aniytrans = 0;
            anirot = 0;
            ilda_dialog_num("aniscale","Enter the scaling multiplier (F.ex. 1 is no change, 2 is double the size)",1);
        }
    }
    else 
    {
        return 0;
    }
}
return 1;
