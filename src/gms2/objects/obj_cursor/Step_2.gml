//window_set_cursor(cr_none);
if (controller.scrollcursor_flag == 1)
    window_set_cursor(cr_size_we);
else if (controller.scrollcursor_flag == 2)
    window_set_cursor(cr_size_ns);
else
{
    if (room != rm_ilda) or (x > 512 or y > 512)
        window_set_cursor(cr_default);
    /*else if (controller.placing == "line")
        window_set_cursor(cr_cross);
    else if (controller.placing == "circle")
        window_set_cursor(cr_cross);
    else if (controller.placing == "wave")
        window_set_cursor(cr_cross);
    else if (controller.placing == "free")
        window_set_cursor(cr_cross);
    else if (controller.placing == "curve")
        window_set_cursor(cr_cross);*/
    else if (controller.placing == "text")
        window_set_cursor(cr_beam);
    /*else if (controller.placing == "hershey")
        window_set_cursor(cr_cross);
    else if (controller.placing == "func")
        window_set_cursor(cr_cross);*/
    if (controller.tooltip != "") or (controller.objmoving)
    {
        if (mouse_check_button(mb_left))
            image_index = 10;
        else
            image_index = 9;
		window_set_cursor(cr_handpoint);
    }
    if (keyboard_check(ord("E")) and (controller.placing_status != 2))
        window_set_cursor(cr_handpoint);
}

image_speed = 0;

