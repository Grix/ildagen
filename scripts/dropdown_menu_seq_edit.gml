ddobj = instance_create(seqcontrol.menu_width_start[2],0,oDropDown);
with (ddobj)
    {
    num = 9;
    total_width = 230;
    event_user(1);
    ds_list_add(desc_list,"Undo (Ctrl+Z)");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,undo_seq);
    ds_list_add(hl_list,ds_list_size(seqcontrol.undo_list));
    ds_list_add(desc_list,"Send selected frames to editor mode");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_fromseq);
    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
    ds_list_add(desc_list,"Cut (Ctrl+X)");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,seq_cut_object);
    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
    ds_list_add(desc_list,"Copy (Ctrl+C");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,seq_copy_object);
    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
    ds_list_add(desc_list,"Paste (Ctrl+V)");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,seq_paste_object);
    ds_list_add(hl_list,ds_list_size(seqcontrol.copy_list));
    ds_list_add(desc_list,"Delete (Del)");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,seq_delete_object);
    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
    ds_list_add(desc_list,"Change duration");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_object_duration);
    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));  
    ds_list_add(desc_list,"Split object (S)");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,split_timelineobject);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Deselect");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_deselect);
    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
 
    }
