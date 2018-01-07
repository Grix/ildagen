if (instance_exists(obj_dropdown))
    exit;
visible = (controller.colormode != "rainbow");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes primary color (Sliders represent red, green and blue)\n->Right click to enter a precise value";
} 

if (moving == 4)
{
    tempundolist = ds_list_create();
    ds_list_add(tempundolist,controller.enddotscolor);
    ds_list_add(tempundolist,controller.color2);
    ds_list_add(tempundolist,controller.color1);
    ds_list_add(controller.undo_list,"b"+string(tempundolist));
	if (mouse_y-y < 47+9)
		controller.color1 = make_color_rgb(255, clamp(floor((mouse_x-x)/9)*63.75, 0, 255), 0);
	else if (mouse_y-y < 47+18)
		controller.color1 = make_color_rgb(0, 255, clamp(floor((mouse_x-x)/9)*63.75, 0, 255));
	else if (mouse_y-y < 47+27)
		controller.color1 = make_color_rgb(clamp(floor((mouse_x-x)/9)*63.75, 0, 255), 0, 255);
	else if (mouse_y-y < 47+36)
		controller.color1 = make_color_rgb(	255 - clamp(floor((mouse_x-x)/9)*63.75, 0, 255), 
											255 - clamp(floor((mouse_x-x)/9)*63.75, 0, 255), 
											255 - clamp(floor((mouse_x-x)/9)*63.75, 0, 255));
    moving = 0;
    update_colors();
}
else
{
    if (moving == 1) or ((moving) and keyboard_check(vk_control))
    {
		red = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.color1 = make_colour_rgb(red,colour_get_green(controller.color1),colour_get_blue(controller.color1));
    }
    if (moving == 2) or ((moving) and keyboard_check(vk_control))
    {
        green = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.color1 = make_colour_rgb(colour_get_red(controller.color1),green,colour_get_blue(controller.color1));
    }
    if (moving == 3) or ((moving) and keyboard_check(vk_control))
    {
        blue = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.color1 = make_colour_rgb(colour_get_red(controller.color1),colour_get_green(controller.color1),blue);
    }
}
