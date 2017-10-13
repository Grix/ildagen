if (instance_exists(obj_dropdown))
    exit;
	
visible = !ds_list_empty(controller.semaster_list);
	
if (!visible)
	exit;

image_index = 0;

for (var i = 0; i < ds_list_size(controller.el_list); i++)
{
    var t_list = ds_list_find_value(controller.el_list,i);
    var elid_temp = ds_list_find_value(t_list,9);
    
    for (var j = 0;j < ds_list_size(controller.semaster_list); j++)
    {
        if (elid_temp == ds_list_find_value(controller.semaster_list, j))
        {
            if (t_list[| 11] == true)
				image_index = 1;
			else if (image_index == 1)
			{
				image_index = 2;
				break;
			} //todo will this be wrong if the last element is true but the rest false?
        }
    }
	if (image_index == 2)
		break;
}
	
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "If this is enabled, the selected object(s) will always be drawn in its original point order. (Can reduce animation glitches)";
}
