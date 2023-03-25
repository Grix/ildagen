// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function layer_delete_inner(){
	_layer = layertodelete;
	selectedlayer = ds_list_find_index(layer_list,_layer);
	if (selectedlayer == -1)
	    exit;
					
					
	num_objects = ds_list_size(_layer[| 1]);
	ds_list_clear(somaster_list);
	repeat (num_objects)   
	{
	    ds_list_add(somaster_list,ds_list_find_value(_layer[| 1],0));
	    seq_delete_object_noundo();
	}
	ds_list_destroy(_layer[| 1]); _layer[| 1] = -1;
            
	envelope_list = ds_list_find_value(_layer,0);
	num_objects = ds_list_size(envelope_list);
	repeat (num_objects)   
	{
	    envelope = ds_list_find_value(envelope_list,0);
	    ds_list_destroy(ds_list_find_value(envelope,1));
	    ds_list_destroy(ds_list_find_value(envelope,2));
	    ds_list_destroy(envelope); envelope = -1; 
	    ds_list_delete(envelope_list,0);
	}
	ds_list_destroy(envelope_list); envelope_list = -1; _layer[| 0] = -1;
            
	var t_dac_list = ds_list_find_value(_layer,5);
	num_objects = ds_list_size(t_dac_list);
	repeat (num_objects)  
	    ds_list_destroy(ds_list_find_value(t_dac_list,0));
	ds_list_destroy(t_dac_list); t_dac_list = -1;
            
	ds_list_destroy(_layer); _layer = -1;
	ds_list_delete(layer_list,selectedlayer);
            
	selectedlayer = 0;
	selectedx = 0;
	timeline_surf_length = 0;
	frame_surf_refresh = 1;
				
}