ddobj = instance_create_layer(seqcontrol.menu_width_start[1],0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 2;
    event_user(1);
    ds_list_add(desc_list,"Change FPS");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_fps);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"More properties and settings");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_goto_options);
    ds_list_add(hl_list,1);
}
