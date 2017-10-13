if (controller.placing_status > 1) exit;

with (controller)
    {
    reap_color = 0;
    reap_blank = 1;
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    reapply_properties();
    }
    

