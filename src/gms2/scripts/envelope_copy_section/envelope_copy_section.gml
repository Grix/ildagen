// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function envelope_copy_section(){
	
	with (seqcontrol)
	{
		ds_list_clear(envelope_copy_list_data);
		ds_list_clear(envelope_copy_list_time);
		
		if (xposprev == envelopexpos || !ds_list_exists(envelopetoedit))
			return;
		
		time_list = ds_list_find_value(envelopetoedit,1);
		data_list = ds_list_find_value(envelopetoedit,2);
		
		if (xposprev > envelopexpos)
		{
			var t_temp = xposprev;
			xposprev = envelopexpos;
			envelopexpos = t_temp;
		}
			
		// find points in section
		for (u = 0; u < ds_list_size(time_list); u++)
		{
			var t_xpos_loop = ds_list_find_value(time_list,u);
			if (t_xpos_loop == clamp(t_xpos_loop, xposprev+1, envelopexpos-1))
			{
				ds_list_add(envelope_copy_list_time, time_list[| u] - xposprev);
				ds_list_add(envelope_copy_list_data, data_list[| u]);
			}
		}
	}
}