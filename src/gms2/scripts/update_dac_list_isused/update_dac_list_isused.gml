// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_dac_list_isused()
{
	for (n = 0; n < ds_list_size(controller.dac_list); n++)
	{
		var t_dac = controller.dac_list[| n];
		t_dac[| 8] = false;
		log("Set DAC " + string(n) + " to unused.");
	}
	
	for (k = 0; k < ds_list_size(seqcontrol.layer_list); k++)
	{
		var t_daclist = ds_list_find_value(seqcontrol.layer_list[| k], 5);
		if (ds_list_size(t_daclist) == 0)
		{
		    if (ds_list_exists_pool(controller.dac))
			{
				log("Default DAC found to be used in layer " + string(k));
		        controller.dac[| 8] = true;
				continue;
			}
		}
		for (m = 0; m < ds_list_size(t_daclist); m++)
		{
		    var t_thisdac = t_daclist[| m];
			var t_founddac = ds_list_find_value(controller.dac_list, t_thisdac[| 0]);
		    if (ds_list_exists_pool(t_founddac))
			{
				log("Dac " + string(t_thisdac[| 0]) + " found to be used in layer " + string(k));
				t_founddac[| 8] = true;
			}
		}
	}
	
}