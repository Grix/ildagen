if (room != rm_ilda || view_current != 4 || y > view_wport[4] || (y == mouse_y-camera_get_view_y(view_camera[4]) && x == mouse_x))
    exit;

if (controller.scrollcursor_flag == 1)
    image_index = 13;
else if (controller.scrollcursor_flag == 2)
    image_index = 14;
else
{
	image_index = 0;
    //if (room != rm_ilda) or (x > view_w or y > 512)
    //    image_index = 0;
    /*if (controller.placing == "line")
        image_index = 1;
    else if (controller.placing == "circle")
        image_index = 2;
    else if (controller.placing == "wave")
        image_index = 3;
    else if (controller.placing == "free")
        image_index = 4;
    else if (controller.placing == "curve")
        image_index = 5;
    else if (controller.placing == "text")
        image_index = 7;
    else if (controller.placing == "hershey")
        image_index = 11;
    else if (controller.placing == "func")
        image_index = 12;
    if (controller.tooltip != "") or (controller.objmoving)
    {
        if (mouse_check_button(mb_left))
            image_index = 10;
        else
            image_index = 9;
    }
    if (keyboard_check(ord("E")) and (controller.placing_status != 2))
        image_index = 6;*/
}
   
draw_sprite_ext(sprite_index, image_index, x, y+camera_get_view_y(view_camera[4]), controller.dpi_multiplier, controller.dpi_multiplier, 0, c_white, 1);