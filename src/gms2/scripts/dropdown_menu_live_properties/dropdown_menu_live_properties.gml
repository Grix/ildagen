ddobj = instance_create_layer(livecontrol.menu_width_start[1]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 3;
    event_user(1);
    ds_list_add(desc_list,"Change FPS");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_fps);
    ds_list_add(hl_list,1);
	ds_list_add(desc_list,"Toggle stop other files at play");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dropdown_menu_live_stop_at_play);
    ds_list_add(hl_list,livecontrol.stop_at_play);
    ds_list_add(desc_list,"More properties and settings");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dropdown_menu_seq_settings);
    ds_list_add(hl_list,1);
}
