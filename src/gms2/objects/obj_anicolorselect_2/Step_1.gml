if (instance_exists(obj_dropdown))
    exit;
    
visible = ((controller.colormode == "gradient") || (controller.colormode == "dash") || (controller.colormode == "func")) and (controller.anienable);
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes secondary color at the end of the animation\n(Sliders represent red, green and blue)\n->Right click to enter a precise value";
} 
  
if (moving == 4)
{
    tempundolist = ds_list_create();
    ds_list_add(tempundolist,controller.anienddotscolor);
    ds_list_add(tempundolist,controller.anicolor2);
    ds_list_add(tempundolist,controller.anicolor1);
    ds_list_add(controller.undo_list,"v"+string(tempundolist));
    if (mouse_y-y < 47+9)
		controller.anicolor2 = make_color_rgb(255, floor((mouse_x-x)/8)*51, 0);
	else if (mouse_y-y < 47+18)
		controller.anicolor2 = make_color_rgb(0, 255, floor((mouse_x-x)/8)*51);
	else if (mouse_y-y < 47+27)
		controller.anicolor2 = make_color_rgb(floor((mouse_x-x)/8)*51, 0, 255);
	else if (mouse_y-y < 47+36)
		controller.anicolor2 = make_color_rgb(255 - floor((mouse_x-x)/8)*51, 255 - floor((mouse_x-x)/8)*51, 255 - floor((mouse_x-x)/8)*51);
    moving = 0;
    update_anicolors();
}
else
{  
    if (moving == 1) or ((moving) and keyboard_check(vk_control))
    {
        red = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.anicolor2 = make_colour_rgb(red,colour_get_green(controller.anicolor2),colour_get_blue(controller.anicolor2));
    }
    if (moving == 2) or ((moving) and keyboard_check(vk_control))
    {
        green = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.anicolor2 = make_colour_rgb(colour_get_red(controller.anicolor2),green,colour_get_blue(controller.anicolor2));
    }
    if (moving == 3) or ((moving) and keyboard_check(vk_control))
    {
        blue = clamp(255 - (mouse_y-bbox_top)/25*255, 0, 255);
        controller.anicolor2 = make_colour_rgb(colour_get_red(controller.anicolor2),colour_get_green(controller.anicolor2),blue);
    }
}
    
mouse_yprevious = mouse_y;



