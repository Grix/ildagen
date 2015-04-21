if (hershey_moving)
    {
    hershey_scrollx += (mouse_y-hmouseyprev)*hershey_scrollh/120;
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
    if (mouse_y == clamp(mouse_y,30+hershey_scrollx*120/hershey_scrollh,30+hershey_scrollx*120/hershey_scrollh+hershey_scrollw)) 
    && (mouse_x == clamp(mouse_x,1050,1066))
        {
        tooltip = "Drag to scroll the table of symbols.";
        if (mouse_check_button_pressed(mb_left))
            {
            hershey_moving = 1;
            hmouseyprev = mouse_y;
            }
        }
    }
