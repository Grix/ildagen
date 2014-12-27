scrollbarw = clamp(tlw/(1+logn(1.5,length)),32,tlw);
scrollbarx = (tlw-scrollbarw)*tlx/(length);
//show_debug_message(scrollbarx)
//show_debug_message(scrollbarw)


if (mouse_x == clamp(mouse_x,scrollbarx,scrollbarx+scrollbarw)) 
&& (mouse_y == clamp(mouse_y,room_height-16,room_height))
    {
    controller.tooltip = "Drag to scroll the timeline.#Hold and scroll the mouse wheel to zoom";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
        {
        scroll_moving = 1;
        mousexprev = mouse_x;
        }
    }
    
if (scroll_moving == 1)
    {
    tlx += (mouse_x-mousexprev)*length/tlw;
    if (tlx < 0) tlx = 0;
    if (tlx > length) length = tlx;
    if (mouse_wheel_down())
        tlzoom *= 0.8;
    if (mouse_wheel_up())
        tlzoom *= 1.2;
    if (tlzoom < 10) tlzoom = 10;
    
    mousexprev = mouse_x;
    
    //show_debug_message(tlx)
    //show_debug_message(tlzoom)
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    
    //refresh_audio_surf();
    }