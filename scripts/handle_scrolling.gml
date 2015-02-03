if (mouse_x == clamp(mouse_x,0,tlw)) 
&& (mouse_y == clamp(mouse_y,132,room_height))
    {
    if (mouse_wheel_up())
        {
        tlzoom *= 0.8;
        if (tlzoom < 10) tlzoom = 10;
        }
    if (mouse_wheel_down())
        tlzoom *= 1.2;
    }

scrollbarw = clamp(((tlzoom+18)/length)*tlw-18,32,tlw-18);
scrollbarx = (tlw-18-scrollbarw)*(tlx)/(length-tlzoom);
layerbarw = clamp(7/(ds_list_size(layer_list)+6)*lbh,32,lbh-1);

//horizontal
if (mouse_x == clamp(mouse_x,scrollbarx,scrollbarx+scrollbarw)) 
&& (mouse_y == clamp(mouse_y,room_height-16,room_height))
    {
    controller.tooltip = "Drag to scroll the timeline. Hold and scroll the mouse wheel to zoom";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
        {
        scroll_moving = 1;
        mousexprev = mouse_x;
        }
    }
//vertical
else if (mouse_y == clamp(mouse_y,tls+layerbarx,tls+layerbarx+layerbarw)) 
&& (mouse_x == clamp(mouse_x,tlw-16,tlw))
    {
    controller.tooltip = "Drag to scroll the layer list.";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
        {
        scroll_moving = 2;
        mouseyprev = mouse_y;
        }
    }
    
//horizontal
if (scroll_moving == 1)
    {
    tlx += (mouse_x-mousexprev)*(length/(tlw-17));
    if (tlx < 0) tlx = 0;
    if ((tlx+tlzoom) > length) length = tlx+tlzoom;
    
    mousexprev = mouse_x;
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    }
//vertical
else if (scroll_moving == 2)
    {
    layerbarx += (mouse_y-mouseyprev);//*(length/tlw);
    if (layerbarx < 0) layerbarx = 0;
    if ((layerbarx/48) > ds_list_size(layer_list)-1) layerbarx = (ds_list_size(layer_list)-1)*48;
    
    mouseyprev = mouse_y;
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    }
    

//layers
draw_cursorline = 0;
tempstartx = tls-layerbarx//tlh+16-floor(layerbarx);
for (i = 0; i <= ds_list_size(layer_list);i++)//( i = floor(layerbarx/48); i < floor((layerbarx+lbh)/48); i++)
    {
    if (i < floor(layerbarx/48))
        continue;
        
    mouseonlayer = (mouse_x == clamp(mouse_x,0,tlw-16)) && (mouse_y == clamp(mouse_y,tempstartx+i*48,tempstartx+i*48+48))
    if (mouseonlayer)
        {
        mouseover = (mouse_x == clamp(mouse_x,8,40)) && (mouse_y == clamp(mouse_y,tempstartx+i*48+8,tempstartx+i*48+40))
        if (i == ds_list_size(layer_list))
            {
            if (mouseover) 
                {
                controller.tooltip = "Click to create a new layer";
                if  mouse_check_button_pressed(mb_left)
                    {
                    newlayer = ds_list_create();
                    ds_list_add(layer_list,newlayer);
                    }
                }
            break;
            }
        
    
        //draw_rectangle(0,tempstartx+i*48,tlw-16,tempstartx+i*48+48,1);
        if (mouseover) 
            {
            controller.tooltip = "Click to delete this layer and all its content";
            if  mouse_check_button_pressed(mb_left)
                {
                layertodelete = ds_list_find_value(layer_list,i);
                getint = show_question_async("Are you sure you want to delete this layer? (Cannot be undone)");
                dialog = "layerdelete";
                }
            }
        else
            {
            //mouse on layer but not button
            controller.tooltip = "Click to set cursor to this position and select#Double-click to create and place new ILDA frames"
            floatingcursorx = round(tlx+mouse_x/tlw*tlzoom);
            floatingcursory = tempstartx+i*48-1;
            draw_cursorline = 1;
            
            if  mouse_check_button_pressed(mb_left)
                {
                if (selectedlayer == i) and (selectedx == floatingcursorx)
                    {
                    //if no object underneath, else
                    show_debug_message("create ilda")
                    }
                else
                    {
                    selectedlayer = i;
                    selectedx = floatingcursorx;
                    }
                }
            }
        }
    }
    
