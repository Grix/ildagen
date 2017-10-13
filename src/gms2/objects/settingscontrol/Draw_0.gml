if (room != rm_options)
    exit;

draw_set_font(fnt_tooltip);
menu_string = "   Properties      View      About   ";
menu_width_start[0] = 0;
menu_width[0] = string_width("   Properties   ");
menu_width_start[1] = menu_width[0];
menu_width[1] = string_width("   View   ");
menu_width_start[2] = menu_width_start[1]+menu_width[1];
menu_width[2] = string_width("   About   ");
menu_width_start[3] = menu_width_start[2]+menu_width[2];

    
//menu
draw_set_colour(c_black);
draw_set_alpha(1);
draw_text(0, __view_get( e__VW.YView, 3 )+4, menu_string);
if (mouse_y > __view_get( e__VW.YView, 3 ))   
{
    draw_set_colour(c_teal);
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        draw_rectangle(menu_width_start[0],__view_get( e__VW.YView, 3 )+1,menu_width_start[1],__view_get( e__VW.YView, 3 )+20,1);
        draw_set_alpha(0.3);
        draw_rectangle(menu_width_start[0],__view_get( e__VW.YView, 3 )+1,menu_width_start[1],__view_get( e__VW.YView, 3 )+20,0);
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        draw_rectangle(menu_width_start[1],__view_get( e__VW.YView, 3 )+1,menu_width_start[2],__view_get( e__VW.YView, 3 )+20,1);
        draw_set_alpha(0.3);
        draw_rectangle(menu_width_start[1],__view_get( e__VW.YView, 3 )+1,menu_width_start[2],__view_get( e__VW.YView, 3 )+20,0);
    }
    else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
    {
        draw_rectangle(menu_width_start[2],__view_get( e__VW.YView, 3 )+1,menu_width_start[3],__view_get( e__VW.YView, 3 )+20,1);
        draw_set_alpha(0.3);
        draw_rectangle(menu_width_start[2],__view_get( e__VW.YView, 3 )+1,menu_width_start[3],__view_get( e__VW.YView, 3 )+20,0);
    }
    draw_set_alpha(1);
}
    
gpu_set_blendenable(0);
with (obj_button_parent)
{
    draw_self();
}
gpu_set_blendenable(1);

