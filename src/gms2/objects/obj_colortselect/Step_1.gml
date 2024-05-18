if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.color_period  = clamp((mouse_x-bbox_left)/128*$8000, 1, $8000);
}

visible = ((controller.colormode == "rainbow") || (controller.colormode == "gradient") || (controller.colormode == "dash")) && (controller.colormode2 == 1);
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the distance between color changes.";
} 

