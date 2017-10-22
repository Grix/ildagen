if (instance_exists(obj_dropdown))
    exit;

visible = (controller.enddots || (controller.blankmode == "dotsolid")) && (controller.anienable);
if (!visible)
    exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes color of ending dots at the end of the animation\n(Sliders represent red, green and blue) ";
    } 
        
if (moving == 4)
{
    tempundolist = ds_list_create();
    ds_list_add(tempundolist,controller.anienddotscolor);
    ds_list_add(tempundolist,controller.anicolor2);
    ds_list_add(tempundolist,controller.anicolor1);
    ds_list_add(controller.undo_list,"v"+string(tempundolist));
    controller.anienddotscolor = draw_getpixel(obj_cursor.x,obj_cursor.y+view_hport[3]);
    moving = 0;
    update_anicolors();
}
else
{
    if (moving == 1) or ((moving) and keyboard_check(vk_control))
    {
        red = colour_get_red(controller.anienddotscolor);
        red -= (mouse_y-mouse_yprevious)*255/25;
        if (red < 0) red = 0;
        if (red > 255) red = 255;
        controller.anienddotscolor = make_colour_rgb(red,colour_get_green(controller.anienddotscolor),colour_get_blue(controller.anienddotscolor));
    }
    if (moving == 2) or ((moving) and keyboard_check(vk_control))
    {
        green = colour_get_green(controller.anienddotscolor);
        green -= (mouse_y-mouse_yprevious)*255/25;
        if (green < 0) green = 0;
        if (green > 255) green = 255;
        controller.anienddotscolor = make_colour_rgb(colour_get_red(controller.anienddotscolor),green,colour_get_blue(controller.anienddotscolor));
    }
    if (moving == 3) or ((moving) and keyboard_check(vk_control))
        {
        blue = colour_get_blue(controller.anienddotscolor);
        blue -= (mouse_y-mouse_yprevious)*255/25;
        if (blue < 0) blue = 0;
        if (blue > 255) blue = 255;
        controller.anienddotscolor = make_colour_rgb(colour_get_red(controller.anienddotscolor),colour_get_green(controller.anienddotscolor),blue);
    }
}
    
mouse_yprevious = mouse_y;


