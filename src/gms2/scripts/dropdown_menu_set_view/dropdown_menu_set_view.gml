ddobj = instance_create_layer(settingscontrol.menu_width_start[1],0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 4;
    event_user(1);
    ds_list_add(desc_list,"Editor Mode (Tab)");
    ds_list_add(desc_list,"Timeline Mode (Tab)");
    ds_list_add(desc_list,"Toggle fullscreen (F11)");
    ds_list_add(desc_list,"Reset window size (M)");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_ilda_vieweditor);
    ds_list_add(scr_list,dd_ilda_viewtimeline);
    ds_list_add(scr_list,dd_ilda_togglefullscreen);
    ds_list_add(scr_list,dd_ilda_resetwindow);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
}
