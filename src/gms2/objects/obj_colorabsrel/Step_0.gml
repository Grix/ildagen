if (instance_exists(obj_dropdown))
    exit;
visible = (controller.colormode == "rainbow") || (controller.colormode == "gradient") || (controller.colormode == "dash") || (controller.colormode == "func");

if (!visible) exit;

if (controller.colormode == "func")
    sprite_index = spr_rgbhsv;
else
    sprite_index = spr_absrel;

image_index = controller.colormode2;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Toggles absolute or relative color cycle length";
    } 

