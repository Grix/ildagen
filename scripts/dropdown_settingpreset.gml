ddobj = instance_create(x+60,y+22,oDropDown);
with (ddobj)
{
    ini_open("settings.ini");
    num = 0;
    while (1)
    {
        var t_projectorstring = "projector_"+string(num);
        if (!ini_section_exists(t_projectorstring))
            break;
            
        ds_list_add(desc_list,ini_read_string(t_projectorstring, "name", "name_error"));
        ds_list_add(sep_list,0);
        ds_list_add(scr_list,preset_load);
        ds_list_add(hl_list,(controller.projector == num));
        num++;
    }
    
    ds_list_add(desc_list,"[+] Create new...");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,preset_create);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"[-] Delete ["+ini_read_string("projector_"+string(controller.projector), "name", "name_error")+"]...");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,preset_delete);
    ds_list_add(hl_list,1);
    ini_close();
    num+=2;
    event_user(1);
}
