if (room == rm_ilda && view_current != 4)
	exit;
    
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
    window_set_cursor(cr_handpoint);
}