var t_projector = argument[0] - 2;
var t_dac = settingscontrol.dactoselect;

var t_daclist = ds_list_find_value(seqcontrol.layer_list[| t_projector], 5);
var t_i;
for (t_i = 0; t_i < ds_list_size(t_daclist); t_i++)
{
    if (ds_list_find_index(t_daclist[| t_i], 0) == t_dac)
    {
        show_message_new("This DAC is already added to this layer");
        exit;
    }
}

var t_daclist = ds_list_create();
ds_list_add(t_daclist, t_dac);
ds_list_add(t_daclist, string(ds_list_find_value(controller.dac_list[| t_dac], 1))); 
ds_list_add(t_daclist, "");
ds_list_add(ds_list_find_value(seqcontrol.layer_list[| t_projector], 5), t_daclist);

projectorlist_update();
