//all the interaction with the timeline
    
mouseonsomelayer = 0;
scrollbarw = clamp(((tlzoom+18)/length)*tlw-18,32,tlw-18);
if (length != tlzoom)
    scrollbarx = (tlw-18-scrollbarw)*(tlx)/(length-tlzoom);
layerbarw = clamp(lbh/(ds_list_size(layer_list)*48+lbh)*(lbh-1),32,lbh-1);

if (moving_object == 1)
    {
    draw_mouseline = 1;
    mouseyprevflag = 0;
    //currently dragging object on timeline
    for (i = 0; i < ds_list_size(somaster_list); i++)
        {
        objecttomove = ds_list_find_value(somaster_list,i);
        infolisttomove = ds_list_find_value(objecttomove,2);
        layertomove = -1;
        for (j = 0; j < ds_list_size(layer_list); j++)
            {
            if (ds_list_find_index(ds_list_find_value(layer_list,j),objecttomove) != -1)
                layertomove = ds_list_find_value(layer_list,j);
            }
        if (layertomove == -1)
            {
            moving_object = 0;
            exit;
            }
            
        ds_list_replace(objecttomove,0,max(0,ds_list_find_value(objecttomove,0)+(mouse_x-mousexprev)*tlzoom/tlw));
        
        if (mouse_y > (mouseyprev+48)) and (ds_list_find_index(layer_list,layertomove) < (ds_list_size(layer_list)-1))
            {
            //move to lower layer
            mouseyprevflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,ds_list_find_index(layer_list,layertomove)+1);
            ds_list_add(newlayertomove,objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove;
            }
        else if (mouse_y < (mouseyprev-48)) and (ds_list_find_index(layer_list,layertomove) > 0)
            {
            //move to above layer
            mouseyprevflag = 1;
            var newlayertomove = ds_list_find_value(layer_list,ds_list_find_index(layer_list,layertomove)-1);
            ds_list_add(newlayertomove,objecttomove);
            ds_list_delete(layertomove,ds_list_find_index(layertomove,objecttomove));
            layertomove = newlayertomove;
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
                if (ds_list_find_index(ds_list_find_value(layer_list,j),objecttomove) != -1)
                    layertomove = ds_list_find_value(layer_list,j);
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
                    for ( u = 1; u < ds_list_size(layertomove); u++)
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
                
            //ds_list_add(undolisttemp,layertomove);
            //ds_list_add(undo_list,"m"+string(undolisttemp));
            
            ds_list_replace(objecttomove,0,tempxstart);
            moving_object = 0;
            }
        }
    exit;
    }
else if (moving_object == 2)
    {
    //resizing object on timeline
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
                if (ds_list_find_index(ds_list_find_value(layer_list,j),objecttomove) != -1)
                    layertomove = ds_list_find_value(layer_list,j);
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
                    for ( u = 1; u < ds_list_size(layertomove); u++)
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
            
            //ds_list_add(undo_list,"r"+string(undolisttemp));
            
            moving_object = 0;
            }
        }
    exit;
    }
else if (moving_object == 3)
    {
    //moving startframe
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
    ds_list_replace(marker_list,markertomove,max(1,ds_list_find_value(marker_list,markertomove)+(mouse_x-mousexprev)*tlzoom/tlw));
    mousexprev = mouse_x;
    if (mouse_check_button_released(mb_left))
        {
        ds_list_replace(marker_list,markertomove,round(ds_list_find_value(marker_list,markertomove)));
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
    if ((layerbarx/48) > ds_list_size(layer_list)) layerbarx = (ds_list_size(layer_list))*48;
    
    mouseyprev = mouse_y;
    
    if (mouse_check_button_released(mb_left))
        {
        scroll_moving = 0;
        }
        
    exit;
    }
    
if (mouse_x > tlw) 
or (mouse_y < 132)
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
if (mouse_x == clamp(mouse_x,scrollbarx,scrollbarx+scrollbarw)) 
&& (mouse_y == clamp(mouse_y,lbsh+138,lbsh+16+138))
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
else if (mouse_y == clamp(mouse_y,tls+layerbarx,tls+layerbarx+layerbarw)) 
&& (mouse_x == clamp(mouse_x,tlw-16,tlw))
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
for (i = 0; i <= ds_list_size(layer_list);i++)//( i = floor(layerbarx/48); i < floor((layerbarx+lbh)/48); i++)
    { 
    if (i < floor(layerbarx/48))
        {
        ypos += 48;
        continue;
        }
    
    layer = ds_list_find_value(layer_list, i);    
    
    mouseonlayer = (mouse_x == clamp(mouse_x,0,tlw-16)) && (mouse_y == clamp(mouse_y,ypos,ypos+48))
    if (mouseonlayer)
        {
        mouseover_layer = (mouse_x == clamp(mouse_x,tlw-56,tlw-24)) && (mouse_y == clamp(mouse_y,ypos+8,ypos+40));
        mouseover_envelope = !mouseover_layer and (mouse_x == clamp(mouse_x,tlw-96,tlw-64)) && (mouse_y == clamp(mouse_y,ypos+8,ypos+40));
        
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
                    ds_list_add(newlayer,ds_list_create());
                    }
                }
            else
                draw_mouseline = 1;
            ypos += 48;
            break;
            }
            
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
                layer = ds_list_find_value(layer_list, i);
                envelope = ds_list_create();
                ds_list_add(ds_list_find_value(layer,0),envelope);
                ds_list_add(envelope,"x");
                ds_list_add(envelope,ds_list_create());
                }
            }
        else
            {
            //mouse on layer but not button
            for (m = 1; m < ds_list_size(layer); m++)
                {
                objectlist = ds_list_find_value(layer,m);
                
                infolist =  ds_list_find_value(objectlist,2);
                frametime = ds_list_find_value(objectlist,0);
                object_length = ds_list_find_value(infolist,0);
                correctframe = round(tlx+mouse_x/tlw*tlzoom);
                draw_mouseline = 1;
                
                
                if (correctframe == clamp(correctframe, frametime-2, frametime+object_length+1))
                    {
                    //mouse over object
                    controller.tooltip = "Click to select this object. [Ctrl]+Click to select multiple objects.#Drag to move object. Drag the far edge to adjust duration.#Double-click to edit frames#Right click for more actions";
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
                            if (mouse_x > ((frametime-tlx)/tlzoom*tlw)+object_length/tlzoom*tlw-2)
                                {
                                //resize object
                                moving_object_flag = 2;
                               
                                //undolisttemp = ds_list_create();
                                //ds_list_add(undolisttemp,infolisttomove);
                                //ds_list_add(undolisttemp,object_length);
                                
                                mousexprev = mouse_x;
                                }
                            else
                                {
                                //drag object
                                moving_object_flag = 1;
                                
                                /*undolisttemp = ds_list_create();
                                ds_list_add(undolisttemp,layertomove);
                                ds_list_add(undolisttemp,objecttomove);
                                ds_list_add(undolisttemp,frametime);*/
                                
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
            floatingcursorx = round(tlx+mouse_x/tlw*tlzoom);
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
                selectedx = floatingcursorx;
                ds_list_clear(somaster_list);
                dropdown_layer();
                }
            }
        }
    ypos += 48;
    
    //envelope
    envelope_list = ds_list_find_value(layer, 0);
    for (j = 0; j < ds_list_size(envelope_list); j++)
        {
        envelope = ds_list_find_value(envelope_list,j);
        type = ds_list_find_value(envelope,0);
        
        mouseonenvelope = (mouse_x == clamp(mouse_x,0,tlw-16)) && (mouse_y == clamp(mouse_y,ypos,ypos+64))
        if (mouseonenvelope)
            {
            //delete button
            mouseover_layer = (mouse_x == clamp(mouse_x,tlw-96,tlw-64)) && (mouse_y == clamp(mouse_y,ypos+8,ypos+40));
            if (mouseover_layer) 
                {
                mouseonsomelayer = 1;
                controller.tooltip = "Click to delete this envelope and its data.";
                if  mouse_check_button_pressed(mb_left) 
                    {
                    envelopetodelete = envelope;
                    seq_dialog_yesno("envelopedelete","Are you sure you want to delete this envelope? (Cannot be undone)");
                    }
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
        //mouse over layer area
        controller.tooltip = "Click to set playback position.";
        if  mouse_check_button(mb_left)
            {
            tlpos = round(tlx+mouse_x/tlw*tlzoom)/projectfps*1000;
            if (song)
                {
                if ((tlpos-10)/FMODSoundGetLength(song)) == clamp(((tlpos+audioshift)-10)/FMODSoundGetLength(song),0,1)
                    FMODInstanceSetPosition(songinstance,clamp(((tlpos+audioshift)-10)/FMODSoundGetLength(song),0,1));
                else
                    FMODInstanceSetPaused(songinstance,1);
                }
            }
        }
    }
    
    
return 1;
