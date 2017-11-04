if (room == rm_ilda && view_current != 4)
	exit;
if (room == rm_seq && view_current != 0)
	exit;
if (room == rm_options && view_current != 0)
	exit;
	
//cursor
if (instance_exists(obj_dropdown))
{
	if (mouse_x > obj_dropdown.x1 && mouse_x < obj_dropdown.x2 && mouse_y > obj_dropdown.ty1 && mouse_y < obj_dropdown.ty2)
		window_set_cursor(cr_handpoint);
	else
		window_set_cursor(cr_default);
	exit;
}

if (scrollcursor_flag == 1)
    window_set_cursor(cr_size_we);
else if (scrollcursor_flag == 2)
    window_set_cursor(cr_size_ns);
else
{
    if (placing == "text") && (room == rm_ilda)
        window_set_cursor(cr_beam);
	else
		window_set_cursor(cr_default);
		
    if (objmoving)
		window_set_cursor(cr_handpoint);
    if (room == rm_ilda) && (keyboard_check(ord("E")) && (placing_status != 2))
        window_set_cursor(cr_handpoint);
}
	
if (tooltip != "")
{
    if (show_tooltip)
    {
        draw_set_alpha(0.8);
        draw_set_color(c_black);
        draw_rectangle(0,0,string_width(tooltip)+20,string_height(tooltip)+10,0);
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_text(5,5,tooltip);
		draw_set_color(c_black);
    }
	if (scrollcursor_flag == 1)
		window_set_cursor(cr_size_we);
	else if (scrollcursor_flag == 2)
		window_set_cursor(cr_size_ns);
	else
		window_set_cursor(cr_handpoint);
}

tooltip = "";
scrollcursor_flag = 0;