if (instance_exists(oDropDown))
    exit;
with (controller)
{
    ds_list_add(controller.blindzone_list, 20000);
    ds_list_add(controller.blindzone_list, 45000);
    ds_list_add(controller.blindzone_list, 20000);
    ds_list_add(controller.blindzone_list, 45000);
}
    

