if (instance_exists(obj_dropdown))
    exit;
if (!visible)
	exit;

for (var k = 0; k < ds_list_size(controller.frame_list); k++)
{
	var el_list = controller.frame_list[| k];
	for (var i = 0; i < ds_list_size(el_list); i++)
	{
	    var t_list = ds_list_find_value(el_list,i);
	    var elid_temp = ds_list_find_value(t_list,9);
    
	    for (var j = 0;j < ds_list_size(controller.semaster_list); j++)
	    {
	        if (elid_temp == ds_list_find_value(controller.semaster_list, j))
	        {
	            if (image_index != 1)
					t_list[| 11] = true;
				else
					t_list[| 11] = false;
	        }
	    }
	}
}