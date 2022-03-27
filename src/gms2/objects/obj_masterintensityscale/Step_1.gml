if (instance_exists(obj_dropdown))
    exit;

if (mouse_x > bbox_left) && (mouse_x < bbox_right) && (mouse_y > bbox_top) && ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the overall brightness of output.\n->Right click on a knob to enter precise values.";
} 

if (moving == 1)
{
    controller.intensity_master_scale = clamp(1 - (mouse_y-bbox_top)/52, 0, 1);
}

if (controller.laseron && moving > 0)
	save_profile();
    
mouse_yprevious = mouse_y;

