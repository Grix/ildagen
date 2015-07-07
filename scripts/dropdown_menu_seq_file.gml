ddobj = instance_create(controller.menu_width_start[0],0,oDropDown);
with (ddobj)
    {
    total_width = 265;
    num = 7;
    event_user(1);
    ds_list_add(desc_list,"New Project (Clear)");
    ds_list_add(desc_list,"Save project");
    ds_list_add(desc_list,"Load project");
    ds_list_add(desc_list,"Export project as ILDA file");
    ds_list_add(desc_list,"Import ILDA file to timeline");
    ds_list_add(desc_list,"Import LasershowGen frames file to timeline");
    ds_list_add(desc_list,"Send frames from editor mode to timeline");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_clearproject);
    ds_list_add(scr_list,dd_seq_saveproject);
    ds_list_add(scr_list,dd_seq_loadproject);
    ds_list_add(scr_list,dd_seq_exportilda);
    ds_list_add(scr_list,dd_seq_importilda);
    ds_list_add(scr_list,dd_seq_importframes);
    ds_list_add(scr_list,dd_seq_toseq);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    }