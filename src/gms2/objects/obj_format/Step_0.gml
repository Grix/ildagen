if (instance_exists(obj_dropdown))
    exit;
image_index = (controller.exp_format == 5);

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Set exported ILDA file to modern format 5 or legacy format 0.\nFormat 0 have limited amount of colors, but some software and SD card players may not support format 5.";
    } 

