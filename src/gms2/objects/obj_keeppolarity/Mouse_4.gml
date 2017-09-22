if (instance_exists(oDropDown))
    exit;
if (!visible)
	exit;

var i;
for (i = 0; i < ds_list_size(controller.selectedelementlist); i++)
{
	if (image_index != 1)
		ds_list_replace(controller.selectedelementlist[| i], 11, true);
	else
		ds_list_replace(controller.selectedelementlist[| i], 11, false);
}