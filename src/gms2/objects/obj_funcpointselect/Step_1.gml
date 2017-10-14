if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.shapefunc_cp = clamp((mouse_x-bbox_left)/128*400, 1, 400);
}

visible = (controller.placing == "func");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the number of points to calculate along the functions";
} 

