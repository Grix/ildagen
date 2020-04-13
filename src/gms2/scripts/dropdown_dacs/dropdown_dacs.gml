ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
with (ddobj)
{
    num = 1;
    ds_list_add(desc_list,"Scan for DACs");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,scan_dacs);
    ds_list_add(hl_list,1);
    
    event_user(1);
}
