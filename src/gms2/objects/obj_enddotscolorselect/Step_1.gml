if (instance_exists(oDropDown))
    exit;
visible = controller.enddots || (controller.blankmode == "dotsolid");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes color of ending dots (Sliders represent red, green and blue)";
} 

if (moving == 4)
{
    tempundolist = ds_list_create();
    ds_list_add(tempundolist,controller.enddotscolor);
    ds_list_add(tempundolist,controller.color2);
    ds_list_add(tempundolist,controller.color1);
    ds_list_add(controller.undo_list,"b"+string(tempundolist));
    controller.enddotscolor = draw_getpixel(obj_cursor.x,obj_cursor.y+__view_get( e__VW.HView, 3 ));
    moving = 0;
    update_colors();
}
else
{
    if (moving == 1) or ((moving) and keyboard_check(vk_control))
        {
        red = colour_get_red(controller.enddotscolor);
        red -= (mouse_y-mouse_yprevious)*255/25;
        if (red < 0) red = 0;
        if (red > 255) red = 255;
        controller.enddotscolor = make_colour_rgb(red,colour_get_green(controller.enddotscolor),colour_get_blue(controller.enddotscolor));
        }
    if (moving == 2) or ((moving) and keyboard_check(vk_control))
        {
        green = colour_get_green(controller.enddotscolor);
        green -= (mouse_y-mouse_yprevious)*255/25;
        if (green < 0) green = 0;
        if (green > 255) green = 255;
        controller.enddotscolor = make_colour_rgb(colour_get_red(controller.enddotscolor),green,colour_get_blue(controller.enddotscolor));
        }
    if (moving == 3) or ((moving) and keyboard_check(vk_control))
        {
        blue = colour_get_blue(controller.enddotscolor);
        blue -= (mouse_y-mouse_yprevious)*255/25;
        if (blue < 0) blue = 0;
        if (blue > 255) blue = 255;
        controller.enddotscolor = make_colour_rgb(colour_get_red(controller.enddotscolor),colour_get_green(controller.enddotscolor),blue);
        }
}
    
mouse_yprevious = mouse_y;

