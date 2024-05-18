if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.blank_period = clamp((mouse_x-bbox_left)/128*$8000, 1, $8000);
}
    
visible = (controller.blankmode != "solid") && (controller.blankmode2 == 1) and (controller.blankmode != "func");
if (!visible)
    exit;
    

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the length between stroke blanking intervals.";
} 

