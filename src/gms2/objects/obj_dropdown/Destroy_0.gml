//if (room != rm_seq) controller.menu_open = 0;

if (controller.dialog_open && !force_destroy)
    exit;

if (instance_number(obj_dropdown) <= 1)
	controller.alarm[6] = 2;

if (rdy)
{
    ds_list_free_pool(desc_list); desc_list = -1;
    ds_list_free_pool(sep_list); sep_list = -1;
    ds_list_free_pool(scr_list); scr_list = -1;
    ds_list_free_pool(hl_list); hl_list = -1;
}

