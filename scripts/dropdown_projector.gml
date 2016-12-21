ddobj = instance_create(mouse_x,mouse_y,oDropDown);

//projectortoselect is id in list of right clicked proj

with (ddobj)
{
    num = 3;
    ds_list_add(desc_list,"Remove all DACs");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projector_clear_dacs);
    ds_list_add(hl_list,(ds_list_size(ds_list_find_value(seqcontrol.projector_list[| settingscontrol.projectortoselect], 4)) != 0));
    ds_list_add(desc_list,"Rename Projector");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projector_rename);
    ds_list_add(hl_list,(ds_list_find_value(controller.dac_list[| settingscontrol.dactoselect], 3) != -1));
    ds_list_add(desc_list,"Delete Projector");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,projector_delete);
    ds_list_add(hl_list,1);
    event_user(1);
}


