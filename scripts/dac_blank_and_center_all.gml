///dac_blank_and_center_all()

for (n = 0; n < ds_list_size(controller.dac_list); n++)
{
    var t_dac = controller.dac_list[| n];
    dac_blank_and_center(t_dac);
}
