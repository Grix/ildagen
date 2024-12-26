function dropdown_envelope_menu() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 9;
	    event_user(1);
		ds_list_add(desc_list,"Delete section");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_env_deletesection);
	    ds_list_add(hl_list,seqcontrol.envelopexpos != seqcontrol.xposprev);
		ds_list_add(desc_list,"Move section");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_env_move);
	    ds_list_add(hl_list,seqcontrol.envelopexpos != seqcontrol.xposprev);
		ds_list_add(desc_list,"Cut section");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,envelope_cut_section);
	    ds_list_add(hl_list,seqcontrol.envelopexpos != seqcontrol.xposprev);
		ds_list_add(desc_list,"Copy section");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,envelope_copy_section);
	    ds_list_add(hl_list,seqcontrol.envelopexpos != seqcontrol.xposprev);
		ds_list_add(desc_list,"Copy entire envelope");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,envelope_copy_all);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Paste");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,envelope_paste);
	    ds_list_add(hl_list,seqcontrol.envelope_copy_duration > 0);
	    ds_list_add(desc_list,"Toggle minimize");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_env_hide);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Toggle mute")
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_env_disable);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Change type");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dropdown_envelope_type);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Clear data");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_env_clear);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Delete envelope");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_env_delete);
	    ds_list_add(hl_list,1);
	}
}
