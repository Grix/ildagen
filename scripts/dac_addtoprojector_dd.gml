var t_projector = argument[0] - 2;
var t_dac = settingscontrol.dactoselect;

var t_daclist = ds_list_create();
ds_list_add(t_daclist, t_dac);
ds_list_add(t_daclist, ds_list_find_value(controller.dac_list[| t_dac], 1));
ds_list_add(t_daclist, -1);
ds_list_add(t_daclist, "");
ds_list_add(ds_list_find_value(seqcontrol.projector_list[| t_projector],2), t_daclist);

projectorlist_update();
