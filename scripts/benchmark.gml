//tesing benchmark

/*log("---")
time = get_timer();
i = 0;
x = 0;
y = 0;
repeat (10000)
    {
    x++;
    y++;
    if(mouse_x >= bbox_left && mouse_y >= bbox_top && mouse_x < bbox_right && mouse_y < bbox_bottom)
        i++;
    }
log(get_timer()-time);
time2 = get_timer();
i = 0;
x = 0;
y = 0;
repeat (10000)
    {
    x++;
    y++;
    if(mouse_x == clamp(mouse_x, bbox_left, bbox_right) && mouse_y == clamp(mouse_y, bbox_top, bbox_bottom))
        i++;
    }
log(get_timer()-time2);
time2 = get_timer();
i = 0;
x = 0;
y = 0;
repeat (10000)
    {
    x++;
    y++;
    if (point_in_rectangle(mouse_x,mouse_y,bbox_left,bbox_top,bbox_right,bbox_bottom))
        i++;
    }
log(get_timer()-time2);
*/
