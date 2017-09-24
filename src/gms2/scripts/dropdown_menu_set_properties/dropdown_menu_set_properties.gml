ddobj = instance_create_layer(settingscontrol.menu_width_start[0],0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 1;
    event_user(1);
    ds_list_add(desc_list,"Change FPS");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_fps);
    ds_list_add(hl_list,1);
}
