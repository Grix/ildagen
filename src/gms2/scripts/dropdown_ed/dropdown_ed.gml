
ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
with (ddobj)
{
    num = 4;
    ds_list_add(desc_list,"Bright dots");
    ds_list_add(desc_list,"Medium dots");
    ds_list_add(desc_list,"Weak dots");
    ds_list_add(desc_list,"Custom brightness ..");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ed_high);
    ds_list_add(scr_list,dd_ed_med);
    ds_list_add(scr_list,dd_ed_low);
    ds_list_add(scr_list,dd_ed_custom);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    if (controller.dotmultiply == 30) highlighted = 0;
    else if (controller.dotmultiply == 12) highlighted = 1;
    else if (controller.dotmultiply == 3) highlighted = 2;
    else highlighted = 3;
    ds_list_replace(hl_list,highlighted,1);
    event_user(1);
}
    
