scrollbarx = tlx/(length)//-clamp(1/length*tlw,32,tlw);
scrollbarw = 50//clamp(1/length*tlw,32,tlw);

if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
    {
    if (mouse_x == clamp(mouse_x,scrollbarx,scrollbarx+scrollbarw)) 
    && (mouse_y == clamp(mouse_y,room_height-16,room_height))
        {
        //show_debug_message(1)
        scroll_moving = 1;
        mousexprev = mouse_x;
        }
    }
else if (scroll_moving == 1)
    {
    tlx += (mouse_x-mousexprev)//*1/length*tlw;
    if (tlx < 0) tlx = 0;
    tlzoom += mouse_wheel_down()*10;
    tlzoom -= mouse_wheel_up()*10;
    if (tlzoom < 10) tlzoom = 10;
    
    mousexprev = mouse_x;
    
    show_debug_message(tlx)
    show_debug_message(tlzoom)
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    
    refresh_audio_surf();
    }