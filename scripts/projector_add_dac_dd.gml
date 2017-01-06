var t_projector = settingscontrol.projectortoselect;
var t_dac = argument[0] - 1;

var t_daclist = ds_list_create();
ds_list_add(t_daclist, t_dac);
ds_list_add(t_daclist, ds_list_find_value(controller.dac_list[| t_dac], 1));
ds_list_add(t_daclist, -1);
ds_list_add(t_daclist, "");
ds_list_add(ds_list_find_value(seqcontrol.layer_list[| t_projector], 5), t_daclist);

projectorlist_update();


