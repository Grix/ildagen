if (instance_exists(oDropDown))
    exit;
with (controller)
{
    if (placing != "select")
    {
        placing_select_last = placing;
        placing = "select";
        placing_status = 0;
        ds_list_clear(free_list);
        ds_list_clear(bez_list);
    }
    else
    {
        placing = placing_select_last;
        placing_status = 0;
        ds_list_clear(free_list);
        ds_list_clear(bez_list);
    }
}

