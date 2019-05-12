if (room == rm_ilda || room == rm_seq || room == rm_options)
	ddobj = instance_create_layer(controller.menu_width_start[6],0,"foreground",obj_dropdown);
else if (room == rm_live)
	ddobj = instance_create_layer(livecontrol.menu_width_start[5],0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 5;
    event_user(1);
    ds_list_add(desc_list,"Info");
    ds_list_add(desc_list,"Open manual");
    ds_list_add(desc_list,"Contact developer");
    ds_list_add(desc_list,"Check for updates");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_info);
    ds_list_add(scr_list,dd_ilda_help);
    ds_list_add(scr_list,dd_ilda_contact);
    ds_list_add(scr_list,update_check_verbose);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Enter registration code");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_verifyserial);
    ds_list_add(hl_list,!verify_serial(false));
}
