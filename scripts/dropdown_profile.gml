//todo change to list

ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
{
    num = 1;
    ds_list_add(desc_list,"[+] Create new profile");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,preset_create);
    ds_list_add(hl_list,1);
    
    if (controller.profiletoselect != -1)
    {
        ds_list_add(desc_list,"Select to load or edit");
        ds_list_add(sep_list,1);
        ds_list_add(scr_list,preset_select);
        ds_list_add(hl_list,1);
        num++;
        ds_list_add(desc_list,"[-] Delete profile");
        ds_list_add(sep_list,0);
        ds_list_add(scr_list,preset_delete);
        ds_list_add(hl_list,1);
        num++;
        ds_list_add(desc_list,"Rename profile");
        ds_list_add(sep_list,0);
        ds_list_add(scr_list,preset_rename);
        ds_list_add(hl_list,1);
        num++;
    }
    
    event_user(1);
}
