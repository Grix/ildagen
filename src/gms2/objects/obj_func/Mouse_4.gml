if (instance_exists(obj_dropdown))
    exit;
controller.placing = "func";
with (controller)
{
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    exit;
}

