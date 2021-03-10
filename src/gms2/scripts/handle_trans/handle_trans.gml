function handle_trans() {
	var t_wport4 = view_wport[4];
	var t_scale = $ffff/t_wport4;
	var t_mouse_x = mouse_x;//window_mouse_get_x();
	var t_mouse_y = mouse_y-camera_get_view_y(view_camera[4]);//window_mouse_get_y()-view_hport[3];

	if (objmoving == 1)
	{
	    //translate
	    anixtrans += (obj_cursor.x-mouse_xprevious)*t_scale;
		if (obj_cursor.y > camera_get_view_y(view_camera[0]))
			aniytrans += (obj_cursor.y-mouse_yprevious)*t_scale;
			
		if (editing_type == 1 && ds_list_exists(edit_recording_list))
		{
			ds_list_add(edit_recording_list, anixtrans);
			ds_list_add(edit_recording_list, aniytrans);
			ds_list_add(edit_recording_list, scalex);
			ds_list_add(edit_recording_list, scaley);
			ds_list_add(edit_recording_list, anirot);
		}
	    mouse_xprevious = obj_cursor.x;
	    mouse_yprevious = obj_cursor.y;
    
	    if (mouse_check_button_released(mb_left))
	    {
	        objmoving = 0;
	        reapply_trans();
        
	        update_semasterlist_flag = 1;
			clean_redo_list();
	    }
	}
	else if (objmoving == 2)    
	{
	    //anchor
	    anchorx += (obj_cursor.x-mouse_xprevious)*t_scale;
	    anchory += (obj_cursor.y-mouse_yprevious)*t_scale;
	    mouse_xprevious = obj_cursor.x;
	    mouse_yprevious = obj_cursor.y;
		
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
	    mouseangle = point_direction(obj_cursor.x,obj_cursor.y,anchorx/t_scale,anchory/t_scale);
    
	    if ((mouseangleprevious-mouseangle) > 180)
	        anirot_raw -= 360;
	    else if ((mouseangleprevious-mouseangle) < -180)
	        anirot_raw += 360;
        
	    anirot_raw += mouseangleprevious-mouseangle;
		anirot = anirot_raw;
		if (keyboard_check(vk_shift))
			anirot = round(anirot/11.25)*11.25;
		
		if (editing_type == 1 && ds_list_exists(edit_recording_list))
		{
			ds_list_add(edit_recording_list, anixtrans);
			ds_list_add(edit_recording_list, aniytrans);
			ds_list_add(edit_recording_list, scalex);
			ds_list_add(edit_recording_list, scaley);
			ds_list_add(edit_recording_list, anirot);
		}
    
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
	    if (!keyboard_check_control())
	    {
	        scalex+= (obj_cursor.x-mouse_xprevious)/max(1,(rectxmax-rectxmin)/t_scale)*2;
	        scaley+= (obj_cursor.y-mouse_yprevious)/max(1,(rectymax-rectymin)/t_scale)*2;
	    }
	    else
	    {
	        scalex+= (obj_cursor.x-mouse_xprevious)/max(1,(rectxmax-rectxmin)/t_scale)*2;
	        scaley+= (obj_cursor.x-mouse_xprevious)/max(1,(rectymax-rectymin)/t_scale)*2;
	    }  
		
		if (editing_type == 1 && ds_list_exists(edit_recording_list))
		{
			ds_list_add(edit_recording_list, anixtrans);
			ds_list_add(edit_recording_list, aniytrans);
			ds_list_add(edit_recording_list, scalex);
			ds_list_add(edit_recording_list, scaley);
			ds_list_add(edit_recording_list, anirot);
		}
          
	    mouse_xprevious = obj_cursor.x;
	    mouse_yprevious = obj_cursor.y;
    
	    if (mouse_check_button_released(mb_left))
	    {
	        objmoving = 0;
	        reapply_trans();
	    }
	}
	else if !(keyboard_check_control()) and (!object_select_hovering)
	{
		if (rectxmax == 0 && rectxmin == $fffff && rectymax == 0 && rectymin == $fffff)
			return 0;
		if (t_mouse_x > t_wport4 or t_mouse_y > t_wport4)
			return 0;
		if (instance_exists(obj_dropdown))
			return 0;
		
		var t_resizex = clamp(rectxmax/t_scale, 0, t_wport4-22);
		var t_resizey = clamp(rectymax/t_scale, 0, t_wport4-22);
		
		var t_rotatex = clamp(rectxmin/t_scale, 22, t_wport4);
		var t_rotatey = clamp(rectymax/t_scale, 0, t_wport4-22);
		
		if (t_rotatex > 100 && t_rotatex > t_resizex-8)
			t_rotatex = t_resizex-8;
		else if (t_resizex < t_rotatex+8)
			t_resizex = t_rotatex+8;
	
	
	    if	(t_mouse_x == clamp(t_mouse_x, clamp(anchorx, 0, $ffff-8*t_scale)/t_scale-10*dpi_multiplier, clamp(anchorx, 0, $ffff-8*t_scale)/t_scale+10*dpi_multiplier)) and 
			(t_mouse_y == clamp(t_mouse_y, clamp(anchory, 0, $ffff-8*t_scale)/t_scale-10*dpi_multiplier, clamp(anchory, 0, $ffff-8*t_scale)/t_scale+10*dpi_multiplier))
	    {
	        tooltip = "Click and drag to move the rotation/scaling anchor point.\nRight click to move to center of object.";
			if (mouse_check_button_pressed(mb_left)) 
	        {
	            objmoving = 2;
	            mouse_xprevious = obj_cursor.x;
	            mouse_yprevious = obj_cursor.y;
				anchorx = clamp(anchorx, 8, $ffff-8);
				anchory = clamp(anchory, 8, $ffff-8);
	        }
	        else if (mouse_check_button_pressed(mb_right)) 
	        {
	            anchorx = (rectxmin+rectxmax)/2;
	            anchory = (rectymin+rectymax)/2;
	        }
	    }
	    else if (t_mouse_x == clamp(t_mouse_x,clamp(rectxmin, 3*t_scale, $ffff-3*t_scale)/t_scale-2,clamp(rectxmax, 3*t_scale, $ffff-3*t_scale)/t_scale+2)) and 
				(t_mouse_y == clamp(t_mouse_y,clamp(rectymin, 3*t_scale, $ffff-3*t_scale)/t_scale-2,clamp(rectymax, 3*t_scale, $ffff-3*t_scale)/t_scale+2))
	    {
	        tooltip = "Click and drag to move the selected object.\nIf animation is enabled, the movement will be animated.\nRight click for other actions.";
	        if (mouse_check_button_pressed(mb_left)) 
	        {
	            objmoving = 1;
	            anixtrans = 0;
	            aniytrans = 0;
	            anirot_raw = 0;
				anirot = 0;
	            scalex = 1;
	            scaley = 1;
	            mouse_xprevious = obj_cursor.x;
	            mouse_yprevious = obj_cursor.y;
				if (ds_list_exists(edit_recording_list))
					ds_list_destroy(edit_recording_list);
				if (editing_type == 1)
					edit_recording_list = ds_list_create();
	        }
	        else if (mouse_check_button_pressed(mb_right)) 
	        {
	            dropdown_object();
	        }
	    }
	    else if (t_mouse_x > t_rotatex-20*dpi_multiplier &&
				 t_mouse_x < t_rotatex-2*dpi_multiplier &&
				 t_mouse_y > t_rotatey+2*dpi_multiplier &&
				 t_mouse_y < t_rotatey+20*dpi_multiplier)
	    {
	        tooltip = "Click and drag to rotate the selected object around the anchor.\nIf animation is enabled, the rotation will be animated.\nRight click to enter precise rotation amount.";
			if (mouse_check_button_pressed(mb_left)) 
	        {
	            objmoving = 3;
	            anixtrans = 0;
	            aniytrans = 0;
				anirot_raw = 0;
				anirot = 0;
	            scalex = 1;
	            scaley = 1;
	            mouseangleprevious = point_direction(obj_cursor.x,obj_cursor.y,anchorx/t_scale,anchory/t_scale);
				if (ds_list_exists(edit_recording_list))
					ds_list_destroy(edit_recording_list);
				if (editing_type == 1)
					edit_recording_list = ds_list_create();
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
	    else if (t_mouse_x > t_resizex+2*dpi_multiplier &&
				 t_mouse_x < t_resizex+20*dpi_multiplier &&
				 t_mouse_y > t_resizey+2*dpi_multiplier &&
				 t_mouse_y < t_resizey+20*dpi_multiplier)
	    {
	        tooltip = "Click and drag to resize the selected object around the anchor.\nHold Ctrl to resize X and Y the same amount.\nRight click to enter precise scaling amount.\nIf animation is enabled, the change will be animated."
			if (mouse_check_button_pressed(mb_left)) 
	        {
	            objmoving = 4;
	            anixtrans = 0;
	            aniytrans = 0;
				anirot_raw = 0;
				anirot = 0;
	            scalex = 1;
	            scaley = 1;
	            mouse_xprevious = obj_cursor.x;
	            mouse_yprevious = obj_cursor.y;
				if (ds_list_exists(edit_recording_list))
					ds_list_destroy(edit_recording_list);
				if (editing_type == 1)
					edit_recording_list = ds_list_create();
	        }
	        else if (mouse_check_button_pressed(mb_right)) 
	        {
	            anixtrans = 0;
	            aniytrans = 0;
				anirot_raw = 0;
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



}
