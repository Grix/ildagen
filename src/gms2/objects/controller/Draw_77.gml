if (room == rm_loading)
{
	window_set_cursor(cr_hourglass);
	exit;
}

//cursor
if (instance_exists(obj_dropdown) && !instance_exists(obj_ad))
{
	if (obj_dropdown.selected != noone)
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
    if (show_tooltip && tooltip != ".")
    {
        draw_set_alpha(0.8);
        draw_set_color(c_black);
        draw_rectangle(0,view_yport[4],string_width(tooltip)*dpi_multiplier+20,string_height(tooltip)*dpi_multiplier+10+23,0);
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_text_transformed(5,5+view_yport[4],tooltip, dpi_multiplier, dpi_multiplier, 0);
		draw_set_color(c_black);
    }
	if (scrollcursor_flag == 1)
		window_set_cursor(cr_size_we);
	else if (scrollcursor_flag == 2)
		window_set_cursor(cr_size_ns);
	else
		window_set_cursor(cr_handpoint);
		
	tooltip = "";
}

scrollcursor_flag = 0;