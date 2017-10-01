if (instance_exists(obj_dropdown))
    exit;
if (!visible)
	exit;

var i;
for (i = 0; i < ds_list_size(controller.somaster_list); i++)
{
	if (image_index != 1)
		ds_list_replace(controller.somaster_list[| i], 11, true);
	else
		ds_list_replace(controller.somaster_list[| i], 11, false);
}