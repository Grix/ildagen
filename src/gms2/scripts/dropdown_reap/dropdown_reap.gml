function dropdown_reap() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 3;
	    event_user(1);
	    ds_list_add(desc_list,"Affect displacement");
	    ds_list_add(desc_list,"Remove overlapping points");
	    ds_list_add(desc_list,"Interpolate points");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_reap_trans);
	    ds_list_add(scr_list,dd_reap_overlap);
	    ds_list_add(scr_list,dd_reap_interpolate);
	    ds_list_add(hl_list,controller.reap_trans);
	    ds_list_add(hl_list,controller.reap_removeoverlap);
	    ds_list_add(hl_list,controller.reap_interpolate);
	}
    



}
