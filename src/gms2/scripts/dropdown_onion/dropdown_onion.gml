ddobj = instance_create_layer(mouse_x,mouse_y,"foreground",obj_dropdown);
with (ddobj)
{
    num = 3;
    event_user(1);
    ds_list_add(desc_list,"Set number of previewed frames");
    ds_list_add(desc_list,"Set transparency");
    ds_list_add(desc_list,"Set transparency dropoff");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_onion_number);
    ds_list_add(scr_list,dd_onion_alpha);
    ds_list_add(scr_list,dd_onion_dropoff);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
}
    
