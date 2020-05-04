ddobj = instance_create_layer(controller.menu_width_start[1]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 4;
    ds_list_add(desc_list,"Change number of frames (pad)");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_ilda_maxframes);
    ds_list_add(hl_list,1);
	ds_list_add(desc_list,"Change number of frames (stretch)");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_ilda_maxframes_stretch);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Change FPS");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_fps);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"More properties and settings");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_goto_options);
    ds_list_add(hl_list,1);
    event_user(1);
}
