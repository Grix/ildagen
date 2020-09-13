function dropdown_profile() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 1;
	    if (controller.profiletoselect != -1)
	    {
	        ds_list_add(desc_list,"Select to load or edit");
	        ds_list_add(sep_list,1);
	        ds_list_add(scr_list,preset_select);
	        ds_list_add(hl_list,1);
	        num++;
	        ds_list_add(desc_list,"Rename profile");
	        ds_list_add(sep_list,0);
	        ds_list_add(scr_list,preset_rename);
	        ds_list_add(hl_list,1);
	        num++;
	        ds_list_add(desc_list,"[-] Delete profile");
	        ds_list_add(sep_list,0);
	        ds_list_add(scr_list,preset_delete);
	        ds_list_add(hl_list,1);
	        num++;
	    }
    
	    ds_list_add(desc_list,"[+] Create new profile");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,preset_create);
	    ds_list_add(hl_list,1);
	    event_user(1);
	}





}
