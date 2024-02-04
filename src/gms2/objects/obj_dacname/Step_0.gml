if (instance_exists(obj_dropdown))
    exit;
visible = false;
if (controller.dac != -1 && ds_list_exists_pool(controller.dac))
{
    visible = (controller.dac[| 3] != -1);
}
if (!visible) 
    exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Change the name of the selected DAC.";
} 
else 
    image_index = 0;

