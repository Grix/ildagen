// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_layer(){
	with (seqcontrol)
	{
		add_action_history_ilda("SEQ_addlayer");
		
		newlayer = ds_list_create_pool();
		ds_list_add(layer_list,newlayer);
		ds_list_add(newlayer,ds_list_create_pool()); //envelope list
		ds_list_add(newlayer,ds_list_create_pool()); //objects list
		ds_list_add(newlayer,0); 
		ds_list_add(newlayer,0);
		ds_list_add(newlayer,"Layer "+string(controller.el_id));
		controller.el_id++;
		ds_list_add(newlayer,ds_list_create_pool()); //dac list
		ds_list_add(newlayer,0); // projection offsets
		ds_list_add(newlayer,0);
		ds_list_add(newlayer,0); 
		ds_list_add(newlayer,0);
		ds_list_add(newlayer,ds_list_create_pool()); //event list
		ds_list_add(undo_list, "q"+string(newlayer));
		timeline_surf_length = 0;
		update_dac_list_isused();
	}
}