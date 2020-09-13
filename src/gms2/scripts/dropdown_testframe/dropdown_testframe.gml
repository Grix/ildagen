function dropdown_testframe() {
	ddobj = instance_create_layer(/*obj_testframe.x*/(24+45)*controller.dpi_multiplier,/*obj_testframe.y*/384*controller.dpi_multiplier,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 3;
	    ds_list_add(desc_list,"Test frame");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,testframe_usetestframe);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Frame from Editor Mode");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,testframe_useeditor);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Frame from Timeline Mode");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,testframe_usetimeline);
	    ds_list_add(hl_list,1);
	    event_user(1);
	}





}
