ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 5;
    event_user(1);
    ds_list_add(desc_list,"Affect coloring");
    ds_list_add(desc_list,"Affect blanking");
    ds_list_add(desc_list,"Affect displacement");
    ds_list_add(desc_list,"Remove overlapping points");
    ds_list_add(desc_list,"Interpolate points");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_reap_color);
    ds_list_add(scr_list,dd_reap_blank);
    ds_list_add(scr_list,dd_reap_trans);
    ds_list_add(scr_list,dd_reap_overlap);
    ds_list_add(scr_list,dd_reap_interpolate);
    ds_list_add(hl_list,controller.reap_color);
    ds_list_add(hl_list,controller.reap_blank);
    ds_list_add(hl_list,controller.reap_trans);
    ds_list_add(hl_list,controller.reap_removeoverlap);
    ds_list_add(hl_list,controller.reap_interpolate);
    }
    
