//all the interaction with the timeline
    
mouseonsomelayer = 0;
var t_loop;

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
            
        ds_list_replace(objecttomove,0,max(0,ds_list_find_value(objecttomove,0)+(window_mouse_get_x()-mouse_xprevious)*tlzoom/tlw));
        
        if (mouse_y > (mouse_yprevious+48)) and (layertomove_index < (ds_list_size(layer_list)-1))
        {
            //move to lower layer
            mouse_ypreviousflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,layertomove_index+1);
            ds_list_add(newlayertomove[| 1],objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove[| 1];
        }
        else if (mouse_y < (mouse_yprevious-48)) and (layertomove_index > 0)
        {
            //move to above layer
            mouse_ypreviousflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,layertomove_index-1);
            ds_list_add(newlayertomove[| 1],objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove[| 1];
        }
    }
        
    mouse_xprevious = window_mouse_get_x();
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
            if (!keyboard_check(vk_control))
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
        ds_list_replace(infolisttomove,0,max(0,ds_list_find_value(infolisttomove,0)+(window_mouse_get_x()-mouse_xprevious)*tlzoom/tlw));
    }
        
    mouse_xprevious = window_mouse_get_x();    
    
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
                    layertomove = elementlist;
            }
            if (layertomove == -1)
            {
                moving_object = 0;
                exit;
            }
            
            frame_surf_refresh = 1;
            templength = round(ds_list_find_value(infolisttomove,0));
            if (!keyboard_check(vk_control))
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
    for (i = 0; i < ds_list_size(somaster_list); i++)
    {
        objecttomove = ds_list_find_value(somaster_list,i);
        infolisttomove = ds_list_find_value(objecttomove,2);
		stretch += (window_mouse_get_x()-mouse_xprevious)*tlzoom/tlw;
        
        draw_mouseline = 1;
        //ds_list_replace(infolisttomove,0,max(0,ds_list_find_value(infolisttomove,0)+(window_mouse_get_x()-mouse_xprevious)*tlzoom/tlw));
    }
        
    mouse_xprevious = window_mouse_get_x();    
    
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
                    layertomove = elementlist;
            }
            if (layertomove == -1)
            {
                moving_object = 0;
                exit;
            }
            
            frame_surf_refresh = 1;
            templength = round(ds_list_find_value(infolisttomove,0));
            if (!keyboard_check(vk_control))
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
else if (moving_object == 3)
{
    //moving startframe
    controller.scrollcursor_flag = 1;
    startframe += (window_mouse_get_x()-mouse_xprevious)*tlzoom/tlw;
    if (startframe < 0) startframe = 0;
    mouse_xprevious = window_mouse_get_x();
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
    endframe += (window_mouse_get_x()-mouse_xprevious)*tlzoom/tlw;
    mouse_xprevious = window_mouse_get_x();
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
    ds_list_replace(marker_list,markertomove,max(1,ds_list_find_value(marker_list,markertomove)+(window_mouse_get_x()-mouse_xprevious)*tlzoom/tlw));
    mouse_xprevious = window_mouse_get_x();
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
	
    var t_xpos = round(tlx + window_mouse_get_x()/tlwdivtlzoom);
	var t_ypos = clamp(round(mouse_y-ypos_env),0,64);
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
        moving_object = 0;
		
    exit;
}
else if (moving_object == 7)
{
    //deleting points from envelope
    if (mouse_check_button_released(mb_left))
    {
        time_list = ds_list_find_value(envelopetoedit,1);
        data_list = ds_list_find_value(envelopetoedit,2);
        var t_xpos = round(tlx+window_mouse_get_x()/tlw*tlzoom);
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
    }
    exit;
}
    
//horizontal scroll moving
else if (scroll_moving == 1)
{
    tlx += (window_mouse_get_x()-mouse_xprevious)*(length/(tlw-17));
    if (tlx < 0) tlx = 0;
    if ((tlx+tlzoom) > length) length = tlx+tlzoom;
    
    mouse_xprevious = window_mouse_get_x();
    
    if (mouse_check_button_released(mb_left))
    {
        scroll_moving = 0;
    }
        
    exit;
}
//vertical scroll moving
else if (scroll_moving == 2)
{
    layerbary += (window_mouse_get_y()-mouse_yprevious)*lbh/layerbarw;//*(length/tlw);
    if (layerbary < 0) 
		layerbary = 0;
    if ((layerbary) > ypos_perm) 
		layerbary = ypos_perm;
    
    mouse_yprevious = window_mouse_get_y();
    
    if (mouse_check_button_released(mb_left))
    {
        scroll_moving = 0;
    }
        
	timeline_surf_length = 0;
    exit;
}
    
controller.scrollcursor_flag = 0;
    
if (window_mouse_get_x() > tlw) 
or (window_mouse_get_y() < view_hport[3]+view_hport[4])
or (controller.dialog_open)
or (controller.menu_open)
    exit;
    
if (mouse_wheel_up() or keyboard_check_pressed(vk_f7))
{
    tlxtemp = tlx+window_mouse_get_x()/tlw*tlzoom;
    tlzoom *= 0.8;
    if (tlzoom < 20) 
        tlzoom = 20;
    tlx = tlxtemp-window_mouse_get_x()/tlw*tlzoom;
	if (tlx+tlzoom > length)
		length = tlx+tlzoom;
}
else if (mouse_wheel_down() or keyboard_check_pressed(vk_f8))
{
    tlxtemp = tlx+window_mouse_get_x()/tlw*tlzoom;
    tlzoom *= 1.2;
    tlx -= window_mouse_get_x()/tlw*tlzoom/10;
    tlx = tlxtemp-window_mouse_get_x()/tlw*tlzoom;
    if (tlx < 0) 
        tlx = 0;
	if (tlx+tlzoom > length)
		length = tlx+tlzoom;
}

    
//horizontal scroll
var scrollypos = tls+(layerbary*layerbarw/lbh);

if (window_mouse_get_x() == clamp(window_mouse_get_x(),scrollbarx,scrollbarx+scrollbarw)) 
and (mouse_y == clamp(mouse_y,lbsh+138,lbsh+16+138))
{
    mouseonsomelayer = 1;
    controller.tooltip = "Drag to scroll the timeline. Use the mouse wheel or [F7]/[F8] to zoom";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
    {
        scroll_moving = 1;
        mouse_xprevious = window_mouse_get_x();
    }
}
//vertical scroll
else if (mouse_y == clamp(mouse_y,scrollypos,scrollypos+layerbarw)) 
    and (window_mouse_get_x() == clamp(window_mouse_get_x(),tlw-16,tlw))
{
    mouseonsomelayer = 1;
    controller.tooltip = "Drag to scroll the layer list.";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
    {
        scroll_moving = 2;
        mouse_yprevious = window_mouse_get_y();
    }
}
    
if (mouse_y > lbsh+136) 
or (window_mouse_get_x() > tlw-16) 
    exit;
    
if (moving_object_flag)
{
    if (!mouse_check_button(mb_left))
    {
        moving_object_flag = 0;
        ds_list_clear(somoving_list);
    }
    else if (abs(mouse_xprevious - window_mouse_get_x()) > 1)
    {
        ds_list_copy(somaster_list,somoving_list);
        moving_object = moving_object_flag;
        exit;
    }
}

//startframe
if (window_mouse_get_x() == clamp(window_mouse_get_x(),startframex-2,startframex+2))                         
{
    controller.scrollcursor_flag = 1;
    controller.tooltip = "Drag to adjust the start of the project";
    if (mouse_check_button_pressed(mb_left))
    {
        mouse_xprevious = window_mouse_get_x();
        moving_object = 3;
    }
    exit;
}
//endframe
else if (window_mouse_get_x() == clamp(window_mouse_get_x(),endframex-2,endframex+2))                         
{
    controller.scrollcursor_flag = 1;
    controller.tooltip = "Drag to adjust the end of the project";
    if (mouse_check_button_pressed(mb_left))
    {
        mouse_xprevious = window_mouse_get_x();
        moving_object = 4;
    }
    exit;
}
    
draw_cursorline = 0;    

//markers
for (i = 0; i < ds_list_size(marker_list); i++)
{
    var tlwdivtlzoom = tlw/tlzoom;   
    var markerpostemp = (ds_list_find_value(marker_list,i)-tlx)*tlwdivtlzoom;
    if (window_mouse_get_x() == clamp(window_mouse_get_x(),markerpostemp-2,markerpostemp+2))                         
    {
        mouseonsomelayer = 1;
        controller.scrollcursor_flag = 1;
        controller.tooltip = "Drag to adjust the marker. Ctrl+Click to delete marker.";
        if (mouse_check_button_pressed(mb_left))
        {
            if (keyboard_check(vk_control))
                ds_list_delete(marker_list,i);
            else
            {
                markertomove = i;
                mouse_xprevious = window_mouse_get_x();
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
    _layer = ds_list_find_value(layer_list, i); 
    
    if (ypos > tlh+16-48+138) and (ypos < lbsh+138)
    {
        mouseonlayer = (window_mouse_get_x() == clamp(window_mouse_get_x(),0,tlw-16)) && (mouse_y == clamp(mouse_y,ypos,ypos+48))
        if (mouseonlayer)
        {
            var mouse_on_button_ver = (mouse_y == clamp(mouse_y,ypos+8,ypos+40)) && mouse_y > tlsurf_y+tlh+16;
            var mouseover_layer = (mouse_on_button_ver  and (window_mouse_get_x() == clamp(window_mouse_get_x(),tlw-56,tlw-24)));
            
            if (i == ds_list_size(layer_list))
            {
                if (mouseover_layer) 
                {
                    mouseonsomelayer = 1;
                    controller.tooltip = "Click to create a new layer";
                    if  mouse_check_button_pressed(mb_left)
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
                ypos += 48;
                break;
            }
                
            var mouseover_envelope = !mouseover_layer and mouse_on_button_ver and (window_mouse_get_x() == clamp(window_mouse_get_x(),tlw-96,tlw-64));
            
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
                floatingcursorx = round(tlx+window_mouse_get_x()/tlw*tlzoom);
                
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
                    
					if (window_mouse_get_x() > ((frametime-tlx)/tlzoom*tlw) && window_mouse_get_x() < ((frametime+object_length+1-tlx)/tlzoom*tlw)+3)
                    {
                        //mouse over object
                        controller.tooltip = "Click to select this object. [Ctrl]+Click to select multiple objects.\nDrag to move object. Drag the far edge to adjust duration.\nDouble-click to edit frames\nRight click for more actions";
                        if (window_mouse_get_x() > ((frametime+object_length+0.7-tlx)/tlzoom*tlw))
                            controller.scrollcursor_flag = 1;
                        if  mouse_check_button_pressed(mb_left)
                        {
							timeline_surf_length = 0;
                            if (keyboard_check(vk_control))
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
                                if (window_mouse_get_x() > ((frametime+object_length+0.7-tlx)/tlzoom*tlw)-1)
                                {
									if (keyboard_check(vk_control))
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
                                    
                                    mouse_xprevious = window_mouse_get_x();
                                }
                                else
                                {
                                    //drag object
                                    moving_object_flag = 1;
                                    
                                    undolisttemp = ds_list_create();
                                    ds_list_add(undolisttemp,objectlist);
                                    ds_list_add(undolisttemp,elementlist);
                                    ds_list_add(undolisttemp,frametime);
                                    
                                    mouse_xprevious = window_mouse_get_x();
                                    mouse_yprevious = mouse_y;
                                }
                            }
                        }
                        else if mouse_check_button_pressed(mb_right)
                        {
                            //right clicked on object
                            if (!keyboard_check(vk_control))
                                ds_list_clear(somaster_list);
                            if (ds_list_find_index(somaster_list,objectlist) != -1)
                                ds_list_delete(somaster_list,ds_list_find_index(somaster_list,objectlist));
                            ds_list_insert(somaster_list,0,objectlist);
                            dropdown_seqobject();
                        }
                        ypos += 48;
                        exit;
                    }
                }
                    
                controller.tooltip = "Click to select this layer position\nRight click for more options";
                floatingcursory = ypos-1;
                draw_cursorline = 1;
                draw_mouseline = 1;
                
                if  mouse_check_button_pressed(mb_left)
                {
                    selectedlayer = i;
                    selectedx = floatingcursorx;
                    ds_list_clear(somaster_list);
                }
                else if  mouse_check_button_pressed(mb_right)
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
        
    ypos += 48;
    
    //envelopes
    if (i == ds_list_size(layer_list)) 
        break;
    
    envelope_list = _layer[| 0];
    for (j = 0; j < ds_list_size(envelope_list); j++)
    {
        if (ypos > tlh+16-64+138) and (ypos < lbsh+138)
        {
            envelope = ds_list_find_value(envelope_list,j);
            type = ds_list_find_value(envelope,0);
            hidden = ds_list_find_value(envelope,4);
            if (hidden)
            {
                mouseonenvelope = (mouse_y == clamp(mouse_y,ypos,ypos+16)) and (window_mouse_get_x() == clamp(window_mouse_get_x(),0,tlw-16));
                if (mouseonenvelope)
                {
                    mouseonsomelayer = 1;
                    controller.tooltip = "Click to restore full view of this envelope.";
                    if  mouse_check_button_pressed(mb_left) 
                    {
                        ds_list_replace(envelope,4,0);
						timeline_surf_length = 0;
                        exit;
                    }
                    else if  mouse_check_button_pressed(mb_right) 
                    {
                        selectedenvelope = envelope;
                        env_list_to_delete = envelope_list;
                        dropdown_envelope_menu();
                    }
                }
                ypos+=16;
                continue;
            }
            
            mouseonenvelope = (mouse_y == clamp(mouse_y,ypos,ypos+64)) and (window_mouse_get_x() == clamp(window_mouse_get_x(),0,tlw-16));
            if (mouseonenvelope)
            {
                mouseonsomelayer = 1;
                var mouseover_delete = (mouse_y == clamp(mouse_y,ypos+8,ypos+40)) and (window_mouse_get_x() == clamp(window_mouse_get_x(),tlw-56,tlw-24));
            
                if (mouseover_delete) 
                {
                    controller.tooltip = "Click to delete this envelope and its data.";
                    if  mouse_check_button_pressed(mb_left) 
                    {
                        selectedenvelope = envelope;
                        env_list_to_delete = envelope_list;
                        seq_dialog_yesno("envelopedelete","Are you sure you want to delete this envelope? (Cannot be undone)");
                    }
                }
                else
                {
                    controller.tooltip = "Click or drag the mouse to place points on the envelope graph.\nHold [D] and drag the mouse to delete points.\nRight click for menu.";
                    if  mouse_check_button_pressed(mb_left) 
                    {
                        //adding/modifying/deleting point
                        var t_xpos = round(tlx+window_mouse_get_x()/tlw*tlzoom);
                        
                        if (keyboard_check(ord("D")))
                        {
                            //entering deletion mode, drag mouse to cover area
                            moving_object = 7;
                            xposprev = t_xpos;
                            mouse_xprevious = window_mouse_get_x();
                            envelopetoedit = envelope;
                            exit;
                        }
                        var t_ypos = mouse_y-ypos;
                        
                        //todo bubble sort like in drawing for extra performance?
                        
                        xposprev = t_xpos;
                        yposprev = t_ypos;
                        mouse_xprevious = window_mouse_get_x();
                        mouse_yprevious = mouse_y;
                        ypos_env = ypos;
                        envelopetoedit = envelope;
                        moving_object = 6;
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
        ypos += 64;
    }
}
    
if !(mouseonsomelayer)
{
    draw_mouseline = 1;
    //playback pos
    controller.tooltip = "Click to set playback position. Hold [Ctrl] and drag mouse to scroll timeline.";
    if (mouse_check_button(mb_left) && !keyboard_check(vk_control))
    {
        tlpos = round(tlx+window_mouse_get_x()/tlw*tlzoom)/projectfps*1000;
        if (song != -1)
        {
            FMODGMS_Chan_StopChannel(play_sndchannel);
            FMODGMS_Snd_PlaySound(song, play_sndchannel);
            apply_audio_settings();
            fmod_set_pos(play_sndchannel,clamp(((tlpos+audioshift)-10),0,songlength));
        }
		
		//mouse_xprevious = window_mouse_get_x();
    }
	else if (keyboard_check(vk_control) && mouse_check_button_pressed(mb_left))
	{
		mouse_xprevious = window_mouse_get_x();
		mouse_yprevious = window_mouse_get_y();
	}
	else if (keyboard_check(vk_control) && mouse_check_button(mb_left))
	{
		tlx -= round((window_mouse_get_x()-mouse_xprevious)/tlw*tlzoom);
		layerbary -= round(window_mouse_get_y()-mouse_yprevious);
		if (layerbary < 0) 
			layerbary = 0;
	    if ((layerbary) > ypos_perm) 
			layerbary = ypos_perm;
		if (tlx < 0) 
			tlx = 0;
		if (tlx+tlzoom > length)
			length = tlx+tlzoom;
		mouse_xprevious = window_mouse_get_x();
		mouse_yprevious = window_mouse_get_y();
		timeline_surf_length = 0;
	}
}
    
    
return 1;
