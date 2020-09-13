function dropdown_envelope_create() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 9;
	    event_user(1);
	    ds_list_add(desc_list,"Select type for new envelope:");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,blank_script);//do nothing
	    ds_list_add(hl_list,1);
	    ds_list_add(sep_list,1);
    
	    ds_list_add(desc_list,"X (Horizontal displacement)");
	    ds_list_add(desc_list,"Y (Vertical displacement)");
	    ds_list_add(desc_list,"Intensity (Alpha)");
	    ds_list_add(desc_list,"Color Hue");
	    ds_list_add(desc_list,"Red Color Channel");
	    ds_list_add(desc_list,"Green Color Channel");
	    ds_list_add(desc_list,"Blue Color Channel");
	    ds_list_add(desc_list,"Rotation");
	    repeat (8)
	        ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_envtype_x_create);
	    ds_list_add(scr_list,dd_seq_envtype_y_create);
	    ds_list_add(scr_list,dd_seq_envtype_a_create);
	    ds_list_add(scr_list,dd_seq_envtype_hue_create);
	    ds_list_add(scr_list,dd_seq_envtype_r_create);
	    ds_list_add(scr_list,dd_seq_envtype_g_create);
	    ds_list_add(scr_list,dd_seq_envtype_b_create);
	    ds_list_add(scr_list,dd_seq_envtype_rotabs_create);
	    repeat (8)
	        ds_list_add(hl_list,1);
	}



}
