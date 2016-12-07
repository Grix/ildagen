//all the interaction with the timeline
    
mouseonsomelayer = 0;

if (moving_object == 1)
{
    controller.tooltip = "Drag object to any position on any timeline";
    draw_mouseline = 1;
    mouseyprevflag = 0;
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
            
        ds_list_replace(objecttomove,0,max(0,ds_list_find_value(objecttomove,0)+(mouse_x-mousexprev)*tlzoom/tlw));
        
        if (mouse_y > (mouseyprev+48)) and (layertomove_index < (ds_list_size(layer_list)-1))
        {
            //move to lower layer
            mouseyprevflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,layertomove_index+1);
            ds_list_add(newlayertomove[| 1],objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove[| 1];
        }
        else if (mouse_y < (mouseyprev-48)) and (layertomove_index > 0)
        {
            //move to above layer
            mouseyprevflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,layertomove_index-1);
            ds_list_add(newlayertomove[| 1],objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove[| 1];
        }
    }
        
    mousexprev = mouse_x;
    if (mouseyprevflag)
        mouseyprev = mouse_y;
        
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
            if (!keyboard_check(vk_alt))
            {
                //check for collisions with other objects. tempx* is pos. of object being moved, tempx*2 is pos of other objects in layer
                loopcount = 5;
                loop = 1;
                while (loop and loopcount)
                {
                    loopcount--;
                    loop = 0;
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
                        loop = 1;
                        if (tempxstart2 < tempxstart)
                        {
                            tempxstart = tempxend2+1;
                        }
                        else
                        {
                            tempxstart = tempxstart2-1-(tempxend-tempxstart);
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
        ds_list_replace(infolisttomove,0,max(0,ds_list_find_value(infolisttomove,0)+(mouse_x-mousexprev)*tlzoom/tlw));
    }
        
    mousexprev = mouse_x;    
    
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
            if (!keyboard_check(vk_alt))
            {
                tempxstart = round(ds_list_find_value(objecttomove,0));
                //check for collisions with other objects. tempx* is pos. of object being moved, tempx*2 is pos of other objects in layer
                loopcount = 5;
                loop = 1;
                while (loop and loopcount)
                {
                    loopcount--;
                    loop = 0;
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
                        loop = 1;
                        templength = tempxstart2-tempxstart-1;
                        if (templength < 1) 
                        {
                            templength = round(ds_list_find_value(infolisttomove,0));
                            loop = 0;
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
    startframe += (mouse_x-mousexprev)*tlzoom/tlw;
    if (startframe < 0) startframe = 0;
    mousexprev = mouse_x;
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
    endframe += (mouse_x-mousexprev)*tlzoom/tlw;
    mousexprev = mouse_x;
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
    ds_list_replace(marker_list,markertomove,max(1,ds_list_find_value(marker_list,markertomove)+(mouse_x-mousexprev)*tlzoom/tlw));
    mousexprev = mouse_x;
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
    
    if ( point_distance(mousexprev,mouseyprev,mouse_x,mouse_y) >= 6)
    {
        var t_xpos = round(tlx+mouse_x/tlw*tlzoom);
        var t_ypos = clamp(mouse_y-ypos_env,0,64);
        //adding point
        for (u = 0; u < ds_list_size(time_list); u++)
        {
            if (ds_list_find_value(time_list,u) > t_xpos)
            {
                break;
            }
        }
        if (ds_list_find_index(time_list,t_xpos) == -1)
        {
            ds_list_insert(time_list,u,t_xpos);
            ds_list_insert(data_list,u,t_ypos);
        }
        else
        {
            ds_list_replace(data_list,ds_list_find_index(time_list,t_xpos),t_ypos);
        }
        //deleting points in between
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
        xposprev = t_xpos;
        yposprev = t_ypos;
        mousexprev = mouse_x;
        mouseyprev = mouse_y;
        insertedthisstep = 1;
    }
    if (mouse_check_button_released(mb_left))
    {
        var t_xpos = round(tlx+mouse_x/tlw*tlzoom);
        var t_ypos = clamp(mouse_y-ypos_env,0,64);
        if (!insertedthisstep)
        {
            for (u = 0; u < ds_list_size(time_list); u++)
            {
                if (ds_list_find_value(time_list,u) > t_xpos)
                {
                    break;
                }
            }
            ds_list_insert(time_list,u,t_xpos);
            ds_list_insert(data_list,u,t_ypos);
        }
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
else if (moving_object == 7)
{
    //deleting points from envelope
    if (mouse_check_button_released(mb_left))
    {
        time_list = ds_list_find_value(envelopetoedit,1);
        data_list = ds_list_find_value(envelopetoedit,2);
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
    }
    exit;
}
    
//horizontal scroll moving
else if (scroll_moving == 1)
{
    tlx += (mouse_x-mousexprev)*(length/(tlw-17));
    if (tlx < 0) tlx = 0;
    if ((tlx+tlzoom) > length) length = tlx+tlzoom;
    
    mousexprev = mouse_x;
    
    if (mouse_check_button_released(mb_left))
    {
        scroll_moving = 0;
    }
        
    exit;
}
//vertical scroll moving
else if (scroll_moving == 2)
{
    layerbarx += (mouse_y-mouseyprev)*lbh/layerbarw;//*(length/tlw);
    if (layerbarx < 0) layerbarx = 0;
    if ((layerbarx) > ypos_perm) layerbarx = ypos_perm;
    
    mouseyprev = mouse_y;
    
    if (mouse_check_button_released(mb_left))
    {
        scroll_moving = 0;
    }
        
    exit;
}
    
controller.scrollcursor_flag = 0;
    
if (mouse_x > tlw) 
or (mouse_y < 132)
or (controller.dialog_open)
or (controller.menu_open)
    exit;
    
if (mouse_wheel_up() or keyboard_check_pressed(vk_f7))
{
    tlxtemp = tlx+mouse_x/tlw*tlzoom;
    tlzoom *= 0.8;
    if (tlzoom < 20) 
        tlzoom = 20;
    tlx = tlxtemp-mouse_x/tlw*tlzoom;
}
else if (mouse_wheel_down() or keyboard_check_pressed(vk_f8))
{
    tlxtemp = tlx+mouse_x/tlw*tlzoom;
    tlzoom *= 1.2;
    tlx -= mouse_x/tlw*tlzoom/10;
    tlx = tlxtemp-mouse_x/tlw*tlzoom;
    if (tlx < 0) 
        tlx = 0;
}

    
//horizontal scroll
var scrollypos = tls+(layerbarx*layerbarw/lbh);

if (mouse_x == clamp(mouse_x,scrollbarx,scrollbarx+scrollbarw)) 
and (mouse_y == clamp(mouse_y,lbsh+138,lbsh+16+138))
{
    mouseonsomelayer = 1;
    controller.tooltip = "Drag to scroll the timeline. Use the mouse wheel or [F7]/[F8] to zoom";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
    {
        scroll_moving = 1;
        mousexprev = mouse_x;
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
        mouseyprev = mouse_y;
    }
}
    
if (mouse_y > lbsh+136) 
or (mouse_x > tlw-16) 
    exit;
    
if (moving_object_flag)
{
    if (!mouse_check_button(mb_left))
    {
        moving_object_flag = 0;
        ds_list_clear(somoving_list);
    }
    else if (abs(mousexprev - mouse_x) > 1)
    {
        ds_list_copy(somaster_list,somoving_list);
        moving_object = moving_object_flag;
        exit;
    }
}

//startframe
if (mouse_x == clamp(mouse_x,startframex-2,startframex+2))                         
{
    controller.scrollcursor_flag = 1;
    controller.tooltip = "Drag to adjust the start of the project";
    if (mouse_check_button_pressed(mb_left))
    {
        mousexprev = mouse_x;
        moving_object = 3;
    }
    exit;
}
//endframe
else if (mouse_x == clamp(mouse_x,endframex-2,endframex+2))                         
{
    controller.scrollcursor_flag = 1;
    controller.tooltip = "Drag to adjust the end of the project";
    if (mouse_check_button_pressed(mb_left))
    {
        mousexprev = mouse_x;
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
    if (mouse_x == clamp(mouse_x,markerpostemp-2,markerpostemp+2))                         
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
                mousexprev = mouse_x;
                moving_object = 5;
            }
        }
        exit;
    }
}

//layers
var tempstarty = tls-layerbarx;

var ypos = tempstarty;
for (i = 0; i <= ds_list_size(layer_list); i++)
{
    layer = ds_list_find_value(layer_list, i); 
    
    if (ypos > tlh+16-48+138) and (ypos < lbsh+138)
    {
        mouseonlayer = (mouse_x == clamp(mouse_x,0,tlw-16)) && (mouse_y == clamp(mouse_y,ypos,ypos+48))
        if (mouseonlayer)
        {
            var mouseoverlayerbuttons_ver = (mouse_y == clamp(mouse_y,ypos+8,ypos+40));
            var mouseover_layer = (mouseoverlayerbuttons_ver  and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)));
            
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
                        ds_list_add(newlayer,0);
                    }
                }
                else
                    draw_mouseline = 1;
                ypos += 48;
                break;
            }
                
            var mouseover_envelope = !mouseover_layer and mouseoverlayerbuttons_ver and (mouse_x == clamp(mouse_x,tlw-96,tlw-64));
            
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
                
                elementlist = layer[| 1];
                for (m = 0; m < ds_list_size(elementlist); m++)
                {
                    objectlist = elementlist[| m];
                    
                    infolist =  ds_list_find_value(objectlist,2);
                    frametime = ds_list_find_value(objectlist,0);
                    object_length = ds_list_find_value(infolist,0);
                    draw_mouseline = 1;
                    
                    if (floatingcursorx == clamp(floatingcursorx, frametime-2, frametime+object_length+1))
                    {
                        //mouse over object
                        controller.tooltip = "Click to select this object. [Ctrl]+Click to select multiple objects.#Drag to move object. Drag the far edge to adjust duration.#Double-click to edit frames#Right click for more actions";
                        if (mouse_x > ((frametime-tlx)/tlzoom*tlw)+object_length/tlzoom*tlw-3)
                            controller.scrollcursor_flag = 1;
                        if  mouse_check_button_pressed(mb_left)
                        {
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
                                if (mouse_x > ((frametime-tlx)/tlzoom*tlw)+object_length/tlzoom*tlw-3)
                                {
                                    //resize object
                                    
                                    moving_object_flag = 2;
                                   
                                    undolisttemp = ds_list_create();
                                    ds_list_add(undolisttemp,infolist);
                                    ds_list_add(undolisttemp,object_length);
                                    
                                    mousexprev = mouse_x;
                                }
                                else
                                {
                                    //drag object
                                    moving_object_flag = 1;
                                    
                                    undolisttemp = ds_list_create();
                                    ds_list_add(undolisttemp,objectlist);
                                    ds_list_add(undolisttemp,elementlist);
                                    ds_list_add(undolisttemp,frametime);
                                    
                                    mousexprev = mouse_x;
                                    mouseyprev = mouse_y;
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
                    
                controller.tooltip = "Click to select this layer position#Right click for more options";
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
                    selectedlayer_list = layer;
                    selectedx = floatingcursorx;
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
    
    envelope_list = layer[| 0];
    for (j = 0; j < ds_list_size(envelope_list); j++)
    {
        if (ypos > tlh+16-64+138) and (ypos < lbsh+138)
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
                    if  mouse_check_button_pressed(mb_left) 
                    {
                        ds_list_replace(envelope,4,0);
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
            
            mouseonenvelope = (mouse_y == clamp(mouse_y,ypos,ypos+64)) and (mouse_x == clamp(mouse_x,0,tlw-16));
            if (mouseonenvelope)
            {
                mouseonsomelayer = 1;
                var mouseover_delete = (mouse_y == clamp(mouse_y,ypos+8,ypos+40)) and (mouse_x == clamp(mouse_x,tlw-56,tlw-24));
            
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
                    controller.tooltip = "Click or drag the mouse to place points on the envelope graph.#Hold [D] and drag the mouse to delete points.#Right click for menu.";
                    if  mouse_check_button_pressed(mb_left) 
                    {
                        //adding/modifying/deleting point
                        time_list = ds_list_find_value(envelope,1);
                        data_list = ds_list_find_value(envelope,2);
                        var t_xpos = round(tlx+mouse_x/tlw*tlzoom);
                        
                        if (keyboard_check(ord('D')))
                        {
                            //entering deletion mode, drag mouse to cover area
                            moving_object = 7;
                            xposprev = t_xpos;
                            mousexprev = mouse_x;
                            envelopetoedit = envelope;
                            exit;
                        }
                        var t_ypos = mouse_y-ypos;
                        
                        //todo bubble sort like in drawing for extra performance?
                        
                        for (u = 0; u < ds_list_size(time_list); u++)
                        {
                            if (ds_list_find_value(time_list,u) > t_xpos)
                            {
                                break;
                            }
                        }
                        ds_list_insert(time_list,u,t_xpos);
                        ds_list_insert(data_list,u,t_ypos);
                        xposprev = t_xpos;
                        yposprev = t_ypos;
                        mousexprev = mouse_x;
                        mouseyprev = mouse_y;
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
    if (mouse_y > 132)
    {
        //playback pos
        controller.tooltip = "Click to set playback position.";
        if  mouse_check_button(mb_left)
        {
            tlpos = round(tlx+mouse_x/tlw*tlzoom)/projectfps*1000;
            if (song)
            {
                FMODInstanceStop(songinstance);
                songinstance = FMODSoundPlay(song,1);
                set_audio_speed();
                FMODInstanceSetPosition(songinstance,clamp(((tlpos+audioshift)-10)/FMODSoundGetLength(song),0,1));
                FMODInstanceSetPaused(songinstance,!playing);
            }
        }
    }
}
    
    
return 1;
