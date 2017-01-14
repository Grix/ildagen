ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
{
    num = 1;
    ds_list_add(desc_list,"Scan for DACs");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,scan_dacs);
    ds_list_add(hl_list,1);
    
    event_user(1);
}
