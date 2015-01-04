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

scrollbarw = clamp((tlzoom/length)*tlw-17,32,tlw-17); //(1+logn(1.5,length)
scrollbarx = (tlw-17-scrollbarw)*(tlx)/(length-tlzoom);
layerbarw = clamp((6/ds_list_size(layer_list))*lbh,32,lbh-1);

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
else if (mouse_y == clamp(mouse_y,138+tlh+16+layerbarx,138+tlh+16+layerbarx+layerbarw)) 
&& (mouse_x == clamp(mouse_x,tlw-16,tlw))
    {
    controller.tooltip = "Drag to scroll the layer list.";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
        {
        scroll_moving = 2;
        mouseyprev = mouse_y;
        }
    }
    
    
if (scroll_moving == 1)
    {
    tlx += (mouse_x-mousexprev)*(length/(tlw-17));
    if (tlx < 0) tlx = 0;
    if ((tlx+tlzoom) > length) length = tlx+tlzoom;
    
    mousexprev = mouse_x;
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    }
else if (scroll_moving == 2)
    {
    layerbarx += (mouse_y-mouseyprev);//*(length/tlw);
    if (layerbarx < 0) layerbarx = 0;
    if ((layerbarx*48) > (ds_list_size(layer_list)-1)*48) layerbarx = (ds_list_size(layer_list)-1)*48;
    
    mouseyprev = mouse_y;
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    }
