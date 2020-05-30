//all the user mouse input interaction with the timeline
    
mouseonsomelayer = 0;
if (stretch_flag)
{
	timeline_surf_length = 0;
	stretch_flag = 0;
}
var t_loop;
var t_rowheight = 48;
var t_env_rowheight = 64;

if (moving_object > 0 || somaster_list_prevsize != ds_list_size(somaster_list))
	timeline_surf_length = 0;
	
somaster_list_prevsize = ds_list_size(somaster_list);

if (moving_object == 1)
{
    controller.tooltip = "Drag object to any position on any timeline";
    draw_mouseline = 1;
    mouse_ypreviousflag = 0;
    //currently dragging object on timeline
    for (i = 0; i < ds_list_size(somaster_list); i++)
    {
        objecttomove = ds_list_find_value(somaster_list,i);
        infolisttomove = ds_list_find_value(objecttomove,2);
        layertomove = -1;
        layertomove_index = -1;
        for (j = 0; j < ds_list_size(layer_list); j++)
        {
            elementlist = ds_list_find_value(layer_list[| j], 1);
            if (ds_list_find_index(elementlist,objecttomove) != -1)
            {
                layertomove = elementlist;
                layertomove_index = j;
            }
        }
        if (layertomove == -1)
        {
            moving_object = 0;
            exit;
        }
            
        ds_list_replace(objecttomove,0,max(0,ds_list_find_value(objecttomove,0)+(mouse_x-mouse_xprevious)*tlzoom/tlw));
        
        if (mouse_y > (mouse_yprevious+t_rowheight)) and (layertomove_index < (ds_list_size(layer_list)-1))
        {
            //move to lower layer
            mouse_ypreviousflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,layertomove_index+1);
            ds_list_add(newlayertomove[| 1],objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove[| 1];
        }
        else if (mouse_y < (mouse_yprevious-t_rowheight)) and (layertomove_index > 0)
        {
            //move to above layer
            mouse_ypreviousflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,layertomove_index-1);
            ds_list_add(newlayertomove[| 1],objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove[| 1];
        }
    }
        
    mouse_xprevious = mouse_x;
    if (mouse_ypreviousflag)
        mouse_yprevious = mouse_y;
        
    if (mouse_check_button_released(mb_left))
    {
        for (i = 0; i < ds_list_size(somaster_list); i++)
        {
            objecttomove = ds_list_find_value(somaster_list,i);
            infolisttomove = ds_list_find_value(objecttomove,2);
            layertomove = -1;
            for (j = 0; j < ds_list_size(layer_list); j++)
            {
                elementlist = ds_list_find_value(layer_list[| j], 1);
                if (ds_list_find_index(elementlist,objecttomove) != -1)
                {
                    layertomove = elementlist;
                }
            }
            if (layertomove == -1)
            {
                moving_object = 0;
                exit;
            }
            
            frame_surf_refresh = 1;
            tempxstart = round(ds_list_find_value(objecttomove,0));
            if (!keyboard_check_control())
            {
                //check for collisions with other objects. tempx* is pos. of object being moved, tempx*2 is pos of other objects in layer
                loopcount = 5;
                t_loop = 1;
                while (t_loop and loopcount)
                {
                    loopcount--;
                    t_loop = 0;
                    tempxend = tempxstart + ds_list_find_value(ds_list_find_value(objecttomove,2),0);
                    for ( u = 0; u < ds_list_size(layertomove); u++)
                    {
                        if (ds_list_find_value(layertomove,u) == objecttomove) 
                            continue;
                            
                        tempxstart2 = ds_list_find_value(ds_list_find_value(layertomove,u),0); 
                        if (tempxstart2 > tempxend) //if object is ahead
                            continue;
        
                        tempxend2 = tempxstart2 + ds_list_find_value(ds_list_find_value(ds_list_find_value(layertomove,u),2),0);
                        if (tempxend2 < tempxstart) //if object is behind
                            continue;
                        
                        //collision:
                        t_loop = 1;
                        if (tempxstart2 < tempxstart)
                        {
                            tempxstart = tempxend2+1;
                        }
                        else
                        {
                            tempxstart = tempxstart2-1-(tempxend-tempxstart);
                        }
						if (tempxstart < 0)
						{
							tempxstart = 0;
							t_loop = 0;
						}
                    }
                }
            }
                
            ds_list_add(undo_list,"m"+string(undolisttemp));
            
            ds_list_replace(objecttomove,0,tempxstart);
            moving_object = 0;
        }
    }
    exit;
}
else if (moving_object == 2)
{
    //resizing object on timeline
    controller.scrollcursor_flag = 1;
    for (i = 0; i < ds_list_size(somaster_list); i++)
    {
        objecttomove = ds_list_find_value(somaster_list,i);
        infolisttomove = ds_list_find_value(objecttomove,2);
        
        draw_mouseline = 1;
        ds_list_replace(infolisttomove,0,max(0,ds_list_find_value(infolisttomove,0)+(mouse_x-mouse_xprevious)*tlzoom/tlw));
    }
        
    mouse_xprevious = mouse_x;    
    
    if (mouse_check_button_released(mb_left))
    {
		frame_surf_refresh = 1;
		
        for (i = 0; i < ds_list_size(somaster_list); i++)
        {
            objecttomove = ds_list_find_value(somaster_list,i);
            infolisttomove = ds_list_find_value(objecttomove,2);
            layertomove = -1;
            for (j = 0; j < ds_list_size(layer_list); j++)
            {
                elementlist = ds_list_find_value(layer_list[| j], 1);
                if (ds_list_find_index(elementlist,objecttomove) != -1)
                    layertomove = elementlist;
            }
            if (layertomove == -1)
            {
                moving_object = 0;
                exit;
            }
			
            templength = round(ds_list_find_value(infolisttomove,0));
            if (!keyboard_check_control())
            {
                tempxstart = round(ds_list_find_value(objecttomove,0));
                //check for collisions with other objects. tempx* is pos. of object being moved, tempx*2 is pos of other objects in layer
                loopcount = 5;
                t_loop = 1;
                while (t_loop and loopcount)
                {
                    loopcount--;
                    t_loop = 0;
                    tempxend = tempxstart + templength;
                    for ( u = 0; u < ds_list_size(layertomove); u++)
                    {
                        if (ds_list_find_value(layertomove,u) == objecttomove) 
                            continue;
                            
                        tempxstart2 = ds_list_find_value(ds_list_find_value(layertomove,u),0); 
                        if (tempxstart2 > tempxend) //if object is ahead
                            continue;
        
                        tempxend2 = tempxstart2 + ds_list_find_value(ds_list_find_value(ds_list_find_value(layertomove,u),2),0);
                        if (tempxend2 < tempxstart) //if object is behind
                            continue;
                            
                        //collision:
                        t_loop = 1;
                        templength = tempxstart2-tempxstart-1;
                        if (templength < 1) 
                        {
                            templength = round(ds_list_find_value(infolisttomove,0));
                            t_loop = 0;
                        }
                    }
                }
            }
            
            ds_list_replace(infolisttomove,0,templength);
            
            ds_list_add(undo_list,"r"+string(undolisttemp));
            
            moving_object = 0;
        }
    }
    exit;
}
else if (moving_object == 8)
{
    //stretching object on timeline
    controller.scrollcursor_flag = 1;
	timeline_surf_length = 0;
	
    for (i = 0; i < ds_list_size(somaster_list); i++)
    {
        objecttomove = ds_list_find_value(somaster_list,i);
        infolisttomove = ds_list_find_value(objecttomove,2);
		stretch += (mouse_x-mouse_xprevious)*tlzoom/tlw;
		if (infolisttomove[| 2] + stretch/infolisttomove[| 0]*infolisttomove[| 2] < 1)
			stretch = (1 - infolisttomove[| 2])/infolisttomove[| 2]*infolisttomove[| 0];
        
        draw_mouseline = 1;
    }
        
    mouse_xprevious = mouse_x;    
    
    if (mouse_check_button_released(mb_left))
    {
		frame_surf_refresh = 1;
        for (i = 0; i < ds_list_size(somaster_list); i++)
        {
            objecttomove = ds_list_find_value(somaster_list,i);
            infolisttomove = ds_list_find_value(objecttomove,2);
            layertomove = -1;
            for (j = 0; j < ds_list_size(layer_list); j++)
            {
                elementlist = ds_list_find_value(layer_list[| j], 1);
                if (ds_list_find_index(elementlist,objecttomove) != -1)
                    layertomove = elementlist;
            }
            if (layertomove == -1)
            {
                moving_object = 0;
                exit;
            }
			
            tempstretch = stretch;
            if (!keyboard_check_control())
            {
				templength = round(ds_list_find_value(infolisttomove,0));
                tempxstart = round(ds_list_find_value(objecttomove,0));
                //check for collisions with other objects. tempx* is pos. of object being moved, tempx*2 is pos of other objects in layer
                loopcount = 5;
                t_loop = 1;
                while (t_loop and loopcount)
                {
                    loopcount--;
                    t_loop = 0;
                    tempxend = tempxstart + templength + tempstretch;
                    for ( u = 0; u < ds_list_size(layertomove); u++)
                    {
                        if (ds_list_find_value(layertomove,u) == objecttomove) 
                            continue;
						
                        tempxstart2 = ds_list_find_value(ds_list_find_value(layertomove,u),0); 
                        if (tempxstart2 > tempxend) //if object is ahead
                            continue;
						
                        tempxend2 = tempxstart2 + ds_list_find_value(ds_list_find_value(ds_list_find_value(layertomove,u),2),0);
                        if (tempxend2 < tempxstart) //if object is behind
                            continue;
							
                        //collision:
                        t_loop = 1;
                        tempstretch = tempxstart2-tempxstart-templength-1;
						if (infolisttomove[| 2] + tempstretch < 1)
						{
							tempstretch = 1 - infolisttomove[| 2];
							t_loop = 0;
						}
                    }
                }
            }
            
			//set up lists
			var t_newlength = max(infolisttomove[| 0]+tempstretch, 1);
			var t_newmaxframes = max(infolisttomove[| 2]+floor(tempstretch/infolisttomove[| 0]*infolisttomove[| 2]), 1);
			var t_oldbuffer = objecttomove[| 1];
			new_objectlist = ds_list_create();
			ds_list_add(new_objectlist, objecttomove[| 0]);
			el_buffer = buffer_create(1, buffer_grow, 1);
			buffer_write(el_buffer, buffer_u8, 52);
			buffer_write(el_buffer, buffer_u32, t_newmaxframes);
			ds_list_add(new_objectlist, el_buffer);
			newinfolist = ds_list_create();
			ds_list_add(new_objectlist, newinfolist);
			ds_list_add(newinfolist, t_newlength);
			ds_list_add(newinfolist, -1);
			ds_list_add(newinfolist, t_newmaxframes);
			//set up frame buffer
			for (n = 0; n < t_newmaxframes; n++) //todo this can be optimized
			{
		        buffer_seek(t_oldbuffer, buffer_seek_start, 0);
		        buffer_ver = buffer_read(t_oldbuffer,buffer_u8);
		        if (buffer_ver != 52)
		        {
		            show_message_new("Error: Unexpected version id reading buffer while stretching object: "+string(buffer_ver)+". Things might get ugly. Contact developer.");
		            exit;
		        }
		        buffer_maxframes = buffer_read(t_oldbuffer,buffer_u32);
				fetchedframe = floor(lerp(0, buffer_maxframes-0.001, n/t_newmaxframes));
        
		        //skip to correct frame
		        for (j = 0; j < fetchedframe; j++)
		        {
		            numofel = buffer_read(t_oldbuffer,buffer_u32);
		            for (u = 0; u < numofel; u++)
		            {
		                numofdata = buffer_read(t_oldbuffer,buffer_u32)-20;
		                buffer_seek(t_oldbuffer,buffer_seek_relative,50+numofdata*3.25);
		            }
		        }
            
		        buffer_maxelements = buffer_read(t_oldbuffer,buffer_u32);
				buffer_write(el_buffer, buffer_u32, buffer_maxelements);
				for (j = 0; j < buffer_maxelements; j++)
				{
					numofdata = buffer_read(t_oldbuffer,buffer_u32);
					buffer_write(el_buffer, buffer_u32, numofdata);
					buffer_copy(t_oldbuffer, buffer_tell(t_oldbuffer), 50+(numofdata-20)*3.25, el_buffer, buffer_tell(el_buffer));
					buffer_seek(el_buffer, buffer_seek_relative, 50+(numofdata-20)*3.25);
					buffer_seek(t_oldbuffer, buffer_seek_relative, 50+(numofdata-20)*3.25);
				}
			}
			
			buffer_resize(el_buffer, buffer_tell(el_buffer));
            
            undolisttemp = ds_list_create();
	        ds_list_add(undolisttemp,new_objectlist);
	        ds_list_add(undo_list,"c"+string(undolisttemp));
			
			ds_list_add(layertomove, new_objectlist);
			
        }
		seq_delete_object();
		moving_object = 0;
    }
    exit;
}
else if (moving_object == 3)
{
    //moving startframe
    controller.scrollcursor_flag = 1;
    startframe += (mouse_x-mouse_xprevious)*tlzoom/tlw;
    if (startframe < 0) startframe = 0;
    mouse_xprevious = mouse_x;
    if (mouse_check_button_released(mb_left))
    {
        startframe = round(startframe);
        moving_object = 0;
    }
    exit;
}
else if (moving_object == 4)
{
    //moving endframe
    controller.scrollcursor_flag = 1;
    endframe += (mouse_x-mouse_xprevious)*tlzoom/tlw;
    mouse_xprevious = mouse_x;
    if (mouse_check_button_released(mb_left))
    {
        endframe = round(endframe);
        moving_object = 0;
    }
    exit;
}
else if (moving_object == 5)
{
    //moving marker
    controller.scrollcursor_flag = 1;
    ds_list_replace(marker_list,markertomove,max(1,ds_list_find_value(marker_list,markertomove)+(mouse_x-mouse_xprevious)*tlzoom/tlw));
    mouse_xprevious = mouse_x;
    if (mouse_check_button_released(mb_left))
    {
        ds_list_replace(marker_list,markertomove,round(ds_list_find_value(marker_list,markertomove)));
        moving_object = 0;
    }
    exit;
}
else if (moving_object == 6)
{
    //adding points on envelope
    
    time_list = ds_list_find_value(envelopetoedit,1);
    data_list = ds_list_find_value(envelopetoedit,2);
		
    var insertedthisstep = 0;
    
	var tlwdivtlzoom = tlw/tlzoom; //frames to pixels -> *
	
    var t_xpos = round(tlx + mouse_x/tlwdivtlzoom);
	var t_ypos = clamp(round(mouse_y-ypos_env),0,t_env_rowheight);
	if (mouse_check_button_pressed(mb_left) || mouse_check_button_released(mb_left) || abs(xposprev-t_xpos) > 7/tlwdivtlzoom)
	{
	    //adding/editing point
		
		while (ds_list_find_index(time_list, t_xpos) != -1)
		{
			ds_list_delete(data_list, ds_list_find_index(time_list, t_xpos));
			ds_list_delete(time_list, ds_list_find_index(time_list, t_xpos));
		}
		
	    for (u = 0; u < ds_list_size(time_list); u++)
	    {
	        if (ds_list_find_value(time_list,u) > t_xpos)
	            break;
	    }
		if (time_list[| u] == t_xpos)
		{
			data_list[| u] = t_ypos;
		}
		else
		{
			ds_list_insert(time_list, u, t_xpos);
	        ds_list_insert(data_list, u, t_ypos);
		}
			
		if (xposprev > t_xpos)
		{
			var t_u = u + 1;
			while (ds_list_size(time_list) > t_u)
			{
				if (time_list[| t_u] < xposprev)
				{
					ds_list_delete(time_list, t_u);
					ds_list_delete(data_list, t_u);
				}
				else
				{
					if (ds_list_size(time_list) > t_u+1)
					{
						if (time_list[| t_u] == xposprev && time_list[| t_u+1] == xposprev)
						{
							ds_list_delete(time_list, t_u);
							ds_list_delete(data_list, t_u);
						}
					}
					break;
				}
			}
		}
		else
		{
			var t_u = u - 1;
			while (0 <= t_u)
			{
				if (time_list[| t_u] > xposprev)
				{
					ds_list_delete(time_list, t_u);
					ds_list_delete(data_list, t_u);
					t_u--;
				}
				else
				{
					if (0 <= t_u-1)
					{
						if (time_list[| t_u] == xposprev && time_list[| t_u-1] == xposprev)
						{
							ds_list_delete(time_list, t_u);
							ds_list_delete(data_list, t_u);
						}
					}
					break;
				}
			}
		}
			
		insertedthisstep = 1;
		xposprev = t_xpos;
		yposprev = t_ypos;
	}
		
    if (mouse_check_button_released(mb_left))
	{
        moving_object = 0;
		if (ds_exists(envelope_undolist,ds_type_list))
			ds_list_add(seqcontrol.undo_list,"e"+string(envelope_undolist));
	}
		
    exit;
}
else if (moving_object == 7)
{
    //deleting points from envelope
    if (mouse_check_button_released(mb_left))
    {			
        time_list = ds_list_find_value(envelopetoedit,1);
        data_list = ds_list_find_value(envelopetoedit,2);
		
		var t_undolist = ds_list_create();
		var t_list1 = ds_list_create();
		var t_list2 = ds_list_create();
		ds_list_copy(t_list1,time_list);
		ds_list_copy(t_list2,data_list);
		ds_list_add(t_undolist,t_list1);
		ds_list_add(t_undolist,t_list2);
		ds_list_add(t_undolist,envelopetoedit);
		
        var t_xpos = round(tlx+mouse_x/tlw*tlzoom);
        if (xposprev < t_xpos)
            for (u = 0; u < ds_list_size(time_list); u++)
            {
                var t_xpos_loop = ds_list_find_value(time_list,u);
                if (t_xpos_loop == clamp(t_xpos_loop, xposprev+1, t_xpos-1))
                {
                    ds_list_delete(data_list,u);
                    ds_list_delete(time_list,u);
                    u--;
                }
            }
        else
            for (u = 0; u < ds_list_size(time_list); u++)
            {
                var t_xpos_loop = ds_list_find_value(time_list,u);
                if (t_xpos_loop == clamp(t_xpos_loop, t_xpos+1, xposprev-1))
                {
                    ds_list_delete(data_list,u);
                    ds_list_delete(time_list,u);
                    u--;
                }
            }
        moving_object = 0;
		
		ds_list_add(seqcontrol.undo_list,"e"+string(t_undolist));
    }
    exit;
}
    
//horizontal scroll moving
else if (scroll_moving == 1)
{
    tlx += (device_mouse_raw_x(0)-mouse_xprevious)/controller.dpi_multiplier*(length/(tlw-17));
    if (tlx < 0) tlx = 0;
    if ((tlx+tlzoom) > length) length = tlx+tlzoom;
    
    mouse_xprevious = device_mouse_raw_x(0);
    
    if (mouse_check_button_released(mb_left))
    {
        scroll_moving = 0;
    }
        
    exit;
}
//vertical scroll moving
else if (scroll_moving == 2)
{
    layerbary += (device_mouse_raw_y(0)-mouse_yprevious)/controller.dpi_multiplier*lbh/layerbarw;//*(length/tlw);
    if (layerbary < 0) 
		layerbary = 0;
    if ((layerbary) > ypos_perm) 
		layerbary = ypos_perm;
    
    mouse_yprevious = device_mouse_raw_y(0);
    
    if (mouse_check_button_released(mb_left))
    {
        scroll_moving = 0;
    }
        
	timeline_surf_length = 0;
    exit;
}
    
controller.scrollcursor_flag = 0;

if (mouse_x > tlw)
or (mouse_y < camera_get_view_height(view_camera[3])+camera_get_view_height(view_camera[4]))
or (controller.dialog_open)
or (controller.menu_open)
    exit;
	
var t_mac_ctrl_click = (os_type == os_macosx) && (keyboard_check_control() && mouse_check_button_pressed(mb_right));
    
if (mouse_wheel_up() or keyboard_check_pressed(vk_f7))
{
    tlxtemp = tlx+mouse_x/tlw*tlzoom;
    tlzoom *= 0.8;
    if (tlzoom < 20) 
        tlzoom = 20;
    tlx = tlxtemp-mouse_x/tlw*tlzoom;
	if (tlx+tlzoom > length)
		length = tlx+tlzoom;
}
else if (mouse_wheel_down() or keyboard_check_pressed(vk_f8))
{
    tlxtemp = tlx+mouse_x/tlw*tlzoom;
    tlzoom *= 1.2;
    tlx -= mouse_x/tlw*tlzoom/10;
    tlx = tlxtemp-mouse_x/tlw*tlzoom;
    if (tlx < 0) 
        tlx = 0;
	if (tlx+tlzoom > length)
		length = tlx+tlzoom;
}

    
//horizontal scroll
var scrollypos = tls+(layerbary*layerbarw/lbh);

if (mouse_x == clamp(mouse_x,scrollbarx,scrollbarx+scrollbarw)) 
and (mouse_y == clamp(mouse_y,tlsurf_y+lbsh,tlsurf_y+lbsh+16))
{
    mouseonsomelayer = 1;
    controller.tooltip = "Drag to scroll the timeline. Use the mouse wheel or [F7]/[F8] to zoom";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
    {
        scroll_moving = 1;
        mouse_xprevious = device_mouse_raw_x(0);
    }
}
//vertical scroll
else if (mouse_y == clamp(mouse_y,scrollypos,scrollypos+layerbarw)) 
    and (mouse_x == clamp(mouse_x,tlw-16,tlw))
{
    mouseonsomelayer = 1;
    controller.tooltip = "Drag to scroll the layer list.";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
    {
        scroll_moving = 2;
        mouse_yprevious = device_mouse_raw_y(0);
    }
}
    
if (mouse_y > tlsurf_y+lbsh) 
or (mouse_x > tlw-16) 
    exit;
    
if (moving_object_flag)
{
    if (!mouse_check_button(mb_left))
    {
        moving_object_flag = 0;
        ds_list_clear(somoving_list);
    }
    else if (abs(mouse_xprevious - mouse_x) > 1)
    {
        ds_list_copy(somaster_list,somoving_list);
        moving_object = moving_object_flag;
        exit;
    }
}


//endframe
if (mouse_x == clamp(mouse_x,endframex-2,endframex+2))                         
{
    controller.scrollcursor_flag = 1;
    controller.tooltip = "Drag to adjust the end of the project";
	mouseonsomelayer = 1;
    if (mouse_check_button_pressed(mb_left))
    {
        mouse_xprevious = mouse_x;
        moving_object = 4;
    }
    exit;
}
//start marker is further down, as it is has lower priority because it is moved less often
    
draw_cursorline = 0;    

//markers
for (i = 0; i < ds_list_size(marker_list); i++)
{
    var tlwdivtlzoom = tlw/tlzoom;   
    var markerpostemp = (ds_list_find_value(marker_list,i)-tlx)*tlwdivtlzoom;
    if (mouse_x == clamp(mouse_x,markerpostemp-2,markerpostemp+2))                         
    {
        mouseonsomelayer = 1;
        controller.scrollcursor_flag = 1;
        controller.tooltip = "Drag to adjust the marker. Ctrl+Click to delete marker.";
        if (mouse_check_button_pressed(mb_left) || t_mac_ctrl_click)
        {
            if (keyboard_check_control())
                ds_list_delete(marker_list,i);
            else
            {
                markertomove = i;
                mouse_xprevious = mouse_x;
                moving_object = 5;
            }
        }
        exit;
    }
}

//layers
var tempstarty = tls-layerbary;

var ypos = tempstarty;
for (i = 0; i <= ds_list_size(layer_list); i++)
{
	if (i == ds_list_size(layer_list))
    {
        var mouse_on_button_ver = (mouse_y == clamp(mouse_y,ypos+8,ypos+40)) && mouse_y > tlsurf_y+tlh+16;
		var mouseover_layer = (mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)));
        if (mouseover_layer) 
        {
            mouseonsomelayer = 1;
            controller.tooltip = "Click to create a new layer";
            if (mouse_check_button_pressed(mb_left))
            {
                newlayer = ds_list_create();
                ds_list_add(layer_list,newlayer);
                ds_list_add(newlayer,ds_list_create()); //envelope list
                ds_list_add(newlayer,ds_list_create()); //objects list
                ds_list_add(newlayer,0); 
                ds_list_add(newlayer,0);
                ds_list_add(newlayer,"Layer "+string(controller.el_id));
                controller.el_id++;
                ds_list_add(newlayer,ds_list_create()); //dac list
				timeline_surf_length = 0;
            }
        }
        else
            draw_mouseline = 1;
				
        ypos += t_rowheight;
        break;
    }
	
    _layer = ds_list_find_value(layer_list, i); 
    
    if (ypos > tlh+16-t_rowheight+tlsurf_y) and (ypos < tlsurf_y+lbsh)
    {
        mouseonlayer = (mouse_x == clamp(mouse_x,0,tlw-16)) && (mouse_y == clamp(mouse_y,ypos,ypos+t_rowheight))
        if (mouseonlayer)
        {
            var mouse_on_button_ver = (mouse_y == clamp(mouse_y,ypos+8,ypos+40)) && mouse_y > tlsurf_y+tlh+16;
            var mouseover_layer = (mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)));
            var mouseover_envelope = !mouseover_layer and mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-96,tlw-64));
            
            mouseonsomelayer = 1;
            if (mouseover_layer)
            {
                controller.tooltip = "Click to delete this layer and all its content";
                if  mouse_check_button_pressed(mb_left) 
                {
                    layertodelete = ds_list_find_value(layer_list,i);
                    seq_dialog_yesno("layerdelete","Are you sure you want to delete this layer? (Cannot be undone)");
                }
            }
            else if (mouseover_envelope) 
            {
                mouseonsomelayer = 1;
                controller.tooltip = "Click to add an envelope (effect) for this layer.";
                if  mouse_check_button_pressed(mb_left)
                {
                    layertoedit = ds_list_find_value(layer_list, i);
                    dropdown_envelope_create();
                }
            }
            else
            {
                //mouse on layer but not button
                floatingcursorx = round(tlx+mouse_x/tlw*tlzoom);
                
                elementlist = _layer[| 1];
                for (m = 0; m < ds_list_size(elementlist); m++)
                {
                    objectlist = elementlist[| m];
					
					if (!ds_exists(objectlist,ds_type_list))
					{
						ds_list_delete(elementlist, m);
						if (m > 0)
							m--;
						continue;
					}
                    
                    infolist =  ds_list_find_value(objectlist,2);
                    frametime = ds_list_find_value(objectlist,0);
                    object_length = ds_list_find_value(infolist,0);
                    draw_mouseline = 1;
                    
					if (mouse_x > ((frametime-tlx)/tlzoom*tlw) && mouse_x < ((frametime+object_length+1-tlx)/tlzoom*tlw)+3)
                    {
                        //mouse over object
                        controller.tooltip = "Click to select this object. [Ctrl]+Click to select multiple objects.\nDrag to move object. Drag the far edge to adjust duration by looping.\nHold [Shift] and drag the far edge to adjust duration by stretching.\nDouble-click to edit frames\nRight click for more actions";
                        if (mouse_x > ((frametime+object_length+0.7-tlx)/tlzoom*tlw))
						{
                            controller.scrollcursor_flag = 1;
							if keyboard_check(vk_shift)
							{
								stretch_flag = 1;
								stretch = 0;
								objecttomove = objectlist;
							}
						}
                        if (mouse_check_button_pressed(mb_left) || t_mac_ctrl_click)
                        {
							timeline_surf_length = 0;
                            if (keyboard_check_control())
                            {
                                if (ds_list_find_index(somaster_list,objectlist) != -1)
                                {
                                    ds_list_delete(somaster_list,ds_list_find_index(somaster_list,objectlist));
                                }
                                ds_list_insert(somaster_list,0,objectlist);
                                ds_list_copy(somoving_list,somaster_list);
                            }
                            else
                            {
                                if (ds_list_find_index(somaster_list,objectlist) != -1)
                                {
                                    ds_list_copy(somoving_list,somaster_list);
                                }
                                else
                                {
                                    ds_list_clear(somoving_list);
                                    ds_list_insert(somoving_list,0,objectlist);
                                }
                                ds_list_clear(somaster_list);
                                ds_list_insert(somaster_list,0,objectlist);
                            }
                            
                            if (doubleclick)
                            {
                                //edit object
                                seq_dialog_yesno("fromseq","You are about to open these frames in the editor mode. This will discard any unsaved changes in the editor. Continue? (Cannot be undone)");
                            }
                            else
                            {
                                if (mouse_x > ((frametime+object_length+0.7-tlx)/tlzoom*tlw)-1)
                                {
									if (!keyboard_check(vk_shift))
									{
										//resize object
										moving_object_flag = 2;
										undolisttemp = ds_list_create();
	                                    ds_list_add(undolisttemp,infolist);
	                                    ds_list_add(undolisttemp,object_length);
									}
									else 
									{
										//stretch object
										moving_object_flag = 8;
										stretch = 0;
									}
                                    
                                    mouse_xprevious = mouse_x;
                                }
                                else
                                {
                                    //drag object
                                    moving_object_flag = 1;
                                    
                                    undolisttemp = ds_list_create();
                                    ds_list_add(undolisttemp,objectlist);
                                    ds_list_add(undolisttemp,elementlist);
                                    ds_list_add(undolisttemp,frametime);
                                    
                                    mouse_xprevious = mouse_x;
                                    mouse_yprevious = mouse_y;
                                }
                            }
                        }
                        else if mouse_check_button_pressed(mb_right)
                        {
                            //right clicked on object
                            if (!keyboard_check_control())
                                ds_list_clear(somaster_list);
                            if (ds_list_find_index(somaster_list,objectlist) != -1)
                                ds_list_delete(somaster_list,ds_list_find_index(somaster_list,objectlist));
                            ds_list_insert(somaster_list,0,objectlist);
							timeline_surf_length = 0;
                            dropdown_seqobject();
                        }
                        ypos += t_rowheight;
                        exit;
                    }
                }
                    
                controller.tooltip = "Click to select this layer position\nRight click for more options";
                floatingcursory = ypos-1;
                draw_cursorline = 1;
                draw_mouseline = 1;
                
                if (mouse_check_button_pressed(mb_left) || t_mac_ctrl_click)
                {
                    selectedlayer = i;
                    selectedx = floatingcursorx;
                    ds_list_clear(somaster_list);
                }
                else if (mouse_check_button_pressed(mb_right))
                {
                    selectedlayer = i;
                    selectedlayer_list = _layer;
                    selectedx = floatingcursorx;
                    settingscontrol.projectortoselect = i;
                    ds_list_clear(somaster_list);
                    dropdown_layer();
                }
                exit;
            }
        }
            
    }
        
    ypos += t_rowheight;
    
    //envelopes
    if (i == ds_list_size(layer_list) || is_undefined(_layer) || !ds_exists(_layer, ds_type_list)) 
        break;
    
    envelope_list = _layer[| 0];
    for (j = 0; j < ds_list_size(envelope_list); j++)
    {
        if (ypos > tlh+16-t_env_rowheight+tlsurf_y) and (ypos < lbsh+tlsurf_y)
        {
            envelope = ds_list_find_value(envelope_list,j);
            type = ds_list_find_value(envelope,0);
            hidden = ds_list_find_value(envelope,4);
            if (hidden)
            {
                mouseonenvelope = (mouse_y == clamp(mouse_y,ypos,ypos+16)) and (mouse_x == clamp(mouse_x,0,tlw-16));
                if (mouseonenvelope)
                {
                    mouseonsomelayer = 1;
                    controller.tooltip = "Click to restore full view of this envelope.";
                    if (mouse_check_button_pressed(mb_left) || t_mac_ctrl_click)
                    {
                        ds_list_replace(envelope,4,0);
						timeline_surf_length = 0;
                        exit;
                    }
                    else if (mouse_check_button_pressed(mb_right))
                    {
                        selectedenvelope = envelope;
                        env_list_to_delete = envelope_list;
                        dropdown_envelope_menu();
                    }
                }
                ypos+=16;
                continue;
            }
            
            mouseonenvelope = (mouse_y == clamp(mouse_y,ypos,ypos+t_env_rowheight)) and (mouse_x == clamp(mouse_x,0,tlw-16));
			if (mouseonenvelope)
            {
                mouseonsomelayer = 1;
                var mouseover_delete = (mouse_y == clamp(mouse_y,ypos+8,ypos+40)) and (mouse_x == clamp(mouse_x,tlw-56,tlw-24));
            
                if (mouseover_delete) 
                {
                    controller.tooltip = "Click to delete this envelope and its data.";
                    if (mouse_check_button_pressed(mb_left))
                    {
                        selectedenvelope = envelope;
                        env_list_to_delete = envelope_list;
                        seq_dialog_yesno("envelopedelete","Are you sure you want to delete this envelope? (Cannot be undone)");
                    }
                }
                else
                {
                    controller.tooltip = "Click or drag the mouse to place points on the envelope graph.\nHold [D] and drag the mouse to delete points.\nRight click for menu.";
					if (mouse_check_button_pressed(mb_left))
                    {
                        //adding/modifying/deleting point
                        var t_xpos = round(tlx+mouse_x/tlw*tlzoom);
                        
                        if (keyboard_check(ord("D")))
                        {
                            //entering deletion mode, drag mouse to cover area
                            moving_object = 7;
                            xposprev = t_xpos;
                            mouse_xprevious = mouse_x;
                            envelopetoedit = envelope;
                            exit;
                        }
                        var t_ypos = mouse_y-ypos;
                        
                        //todo bubble sort like in drawing for extra performance?
                        
                        xposprev = t_xpos;
                        yposprev = t_ypos;
                        mouse_xprevious = mouse_x;
                        mouse_yprevious = mouse_y;
                        ypos_env = ypos;
                        envelopetoedit = envelope;
                        moving_object = 6;
						
						time_list = ds_list_find_value(envelopetoedit,1);
						data_list = ds_list_find_value(envelopetoedit,2);
						envelope_undolist = ds_list_create();
						var t_list1 = ds_list_create();
						var t_list2 = ds_list_create();
						ds_list_copy(t_list1,time_list);
						ds_list_copy(t_list2,data_list);
						ds_list_add(envelope_undolist,t_list1);
						ds_list_add(envelope_undolist,t_list2);
						ds_list_add(envelope_undolist,envelopetoedit);
                    }
                    else if  mouse_check_button_pressed(mb_right) 
                    {
                        selectedenvelope = envelope;
                        env_list_to_delete = envelope_list;
                        dropdown_envelope_menu();
                    }
                }
                exit;
            }
                
        }
        ypos += t_env_rowheight;
    }
}



//startframe
if (mouse_x == clamp(mouse_x,startframex-2,startframex+2))                         
{
    controller.scrollcursor_flag = 1;
    controller.tooltip = "Drag to adjust the start of the project";
	mouseonsomelayer = 1;
    if (mouse_check_button_pressed(mb_left))
    {
        mouse_xprevious = mouse_x;
        moving_object = 3;
    }
    exit;
}
    
if !(mouseonsomelayer)
{
    draw_mouseline = 1;
    //playback pos
    controller.tooltip = "Click to set playback position. Hold [Ctrl] and drag mouse to scroll timeline.";
    if (mouse_check_button(mb_left) && !keyboard_check_control())
    {
        tlpos = round(tlx+mouse_x/tlw*tlzoom)/projectfps*1000;
        if (song != -1)
        {
            FMODGMS_Chan_StopChannel(play_sndchannel);
            FMODGMS_Snd_PlaySound(song, play_sndchannel);
            apply_audio_settings();
            fmod_set_pos(play_sndchannel,clamp(((tlpos+audioshift)-10),0,songlength));
        }
		
		//mouse_xprevious = mouse_x;
    }
	else if (keyboard_check_control() && mouse_check_button_pressed(mb_left) || t_mac_ctrl_click)
	{
		mouse_xprevious = mouse_x;
		mouse_yprevious = mouse_y;
	}
	else if (keyboard_check_control() && mouse_check_button(mb_left))
	{
		tlx -= round((mouse_x-mouse_xprevious)/tlw*tlzoom);
		layerbary -= round(mouse_y-mouse_yprevious);
		if (layerbary < 0) 
			layerbary = 0;
	    if ((layerbary) > ypos_perm) 
			layerbary = ypos_perm;
		if (tlx < 0) 
			tlx = 0;
		if (tlx+tlzoom > length)
			length = tlx+tlzoom;
		mouse_xprevious = mouse_x;
		mouse_yprevious = mouse_y;
		timeline_surf_length = 0;
	}
}
    
    
return 1;
