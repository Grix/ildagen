ddobj = instance_create_layer(controller.menu_width_start[3]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
with (ddobj)
{
    num = 5;
    event_user(1);
    ds_list_add(desc_list,"Toggle square grid (S)");
    ds_list_add(desc_list,"Toggle radial grid (R)");
    ds_list_add(desc_list,"Toggle onion skinning (O)");
    ds_list_add(desc_list,"Toggle alignment guidelines (A)");
    ds_list_add(desc_list,"Load/toggle background image");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_sgridtoggle);
    ds_list_add(scr_list,dd_ilda_rgridtoggle);
    ds_list_add(scr_list,dd_ilda_oniontoggle);
    ds_list_add(scr_list,dd_ilda_guidelinetoggle);
    ds_list_add(scr_list,dd_ilda_bckimagetoggle);
    ds_list_add(hl_list,controller.sgridshow);
    ds_list_add(hl_list,controller.rgridshow);
    ds_list_add(hl_list,controller.onion);
    ds_list_add(hl_list,controller.guidelineshow);
    ds_list_add(hl_list,controller.bckimage);
}
