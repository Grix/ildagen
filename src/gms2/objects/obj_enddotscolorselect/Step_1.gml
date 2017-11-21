if (instance_exists(obj_dropdown))
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
    if (mouse_y-y < 47+9)
		controller.enddotscolor = make_color_rgb(255, floor((mouse_x-x)/8)*51, 0);
	else if (mouse_y-y < 47+18)
		controller.enddotscolor = make_color_rgb(0, 255, floor((mouse_x-x)/8)*51);
	else if (mouse_y-y < 47+27)
		controller.enddotscolor = make_color_rgb(floor((mouse_x-x)/8)*51, 0, 255);
	else if (mouse_y-y < 47+36)
		controller.enddotscolor = make_color_rgb(255 - floor((mouse_x-x)/8)*51, 255 - floor((mouse_x-x)/8)*51, 255 - floor((mouse_x-x)/8)*51);
    moving = 0;
    update_colors();
}
else
{
    if (moving == 1) or ((moving) and keyboard_check(vk_control))
    {
        red = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.enddotscolor = make_colour_rgb(red,colour_get_green(controller.enddotscolor),colour_get_blue(controller.enddotscolor));
    }
    if (moving == 2) or ((moving) and keyboard_check(vk_control))
    {
        green = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.enddotscolor = make_colour_rgb(colour_get_red(controller.enddotscolor),green,colour_get_blue(controller.enddotscolor));
    }
    if (moving == 3) or ((moving) and keyboard_check(vk_control))
    {
        blue = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.enddotscolor = make_colour_rgb(colour_get_red(controller.enddotscolor),colour_get_green(controller.enddotscolor),blue);
    }
}
    
mouse_yprevious = mouse_y;

