function dropdown_envelope_type() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	    {
	    var t_currenttype = ds_list_find_value(seqcontrol.selectedenvelope,0);
	    num = 8;
	    event_user(1);
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
	    ds_list_add(scr_list,dd_seq_envtype_x);
	    ds_list_add(scr_list,dd_seq_envtype_y);
	    ds_list_add(scr_list,dd_seq_envtype_a);
	    ds_list_add(scr_list,dd_seq_envtype_hue);
	    ds_list_add(scr_list,dd_seq_envtype_r);
	    ds_list_add(scr_list,dd_seq_envtype_g);
	    ds_list_add(scr_list,dd_seq_envtype_b);
	    ds_list_add(scr_list,dd_seq_envtype_rotabs);
	    ds_list_add(hl_list,(t_currenttype != "x"));
	    ds_list_add(hl_list,(t_currenttype != "y"));
	    ds_list_add(hl_list,(t_currenttype != "a"));
	    ds_list_add(hl_list,(t_currenttype != "hue"));
	    ds_list_add(hl_list,(t_currenttype != "r"));
	    ds_list_add(hl_list,(t_currenttype != "g"));
	    ds_list_add(hl_list,(t_currenttype != "b"));
	    ds_list_add(hl_list,(t_currenttype != "rotabs"));
	    }



}
