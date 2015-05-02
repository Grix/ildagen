if (hershey_moving)
    {
    hershey_scrollx += (mouse_y-hmouseyprev)*hershey_scrollh/100;
    hershey_scrollx = clamp(hershey_scrollx,0,4930);
    hmouseyprev = mouse_y;
    tooltip = "Drag to scroll the table of symbols.";
    if (!mouse_check_button(mb_left))
        {
        hershey_moving = 0;
        show_debug_message(hershey_scrollx);
        }
    }
else
    {
    if (mouse_y == clamp(mouse_y,30+hershey_scrollx*100/hershey_scrollh,30+hershey_scrollx*100/hershey_scrollh+hershey_scrollw)) 
    && (mouse_x == clamp(mouse_x,1070,1090))
        {
        tooltip = "Drag to scroll the table of symbols.";
        if (mouse_check_button_pressed(mb_left))
            {
            hershey_moving = 1;
            hmouseyprev = mouse_y;
            }
        else if (mouse_wheel_up())
            {
            hershey_scrollx-=30;
            hershey_scrollx = clamp(hershey_scrollx,0,4930);
            }
        else if (mouse_wheel_down())
            {
            hershey_scrollx+=30;
            hershey_scrollx = clamp(hershey_scrollx,0,4930);
            }
        }
    else if (mouse_y == clamp(mouse_y,30,150)) 
        &&  (mouse_x == clamp(mouse_x,650,1070))
        {
        tooltip = "Click to select symbol.";
        if (mouse_check_button_pressed(mb_left))
            {
            hershey_selected = floor((hershey_scrollx+mouse_y-30)/30)*14+floor((mouse_x-650) / 30);
            draw_preview_hershey();
            }
        else if (mouse_wheel_up())
            {
            hershey_scrollx-=30;
            hershey_scrollx = clamp(hershey_scrollx,0,4930);
            }
        else if (mouse_wheel_down())
            {
            hershey_scrollx+=30;
            hershey_scrollx = clamp(hershey_scrollx,0,4930);
            }
        }
    }