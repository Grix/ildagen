if (controller.placing_status > 1) exit;

with (controller)
    {
    reap_color = 1;
    reap_blank = 0;
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    reapply_properties();
    }
    

