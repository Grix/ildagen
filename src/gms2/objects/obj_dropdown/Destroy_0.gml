if (room != rm_seq) controller.menu_open = 0;

if (controller.dialog_open)
    exit;

if (instance_number(obj_dropdown) <= 1)
controller.alarm[6] = 2;

if (rdy)
{
    ds_list_destroy(desc_list);
    ds_list_destroy(sep_list);
    ds_list_destroy(scr_list);
    ds_list_destroy(hl_list);
}

