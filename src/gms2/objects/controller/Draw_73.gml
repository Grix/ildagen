if (view_current != 0)
    exit;
    
if (tooltip != "")
{
    if (show_tooltip)
    {
        draw_set_alpha(0.8);
        draw_set_color(c_black);
        draw_rectangle(0,0,string_width(string_hash_to_newline(tooltip))+20,string_height(string_hash_to_newline(tooltip))+10,0);
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_text(5,5,string_hash_to_newline(tooltip));
    }
    tooltip = "";
}

