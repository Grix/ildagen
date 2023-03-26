// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_layer(){
	with (seqcontrol)
	{
		newlayer = ds_list_create();
		ds_list_add(layer_list,newlayer);
		ds_list_add(newlayer,ds_list_create()); //envelope list
		ds_list_add(newlayer,ds_list_create()); //objects list
		ds_list_add(newlayer,0); 
		ds_list_add(newlayer,0);
		ds_list_add(newlayer,"Layer "+string(controller.el_id));
		controller.el_id++;
		ds_list_add(newlayer,ds_list_create()); //dac list
		ds_list_add(newlayer,0); 
		ds_list_add(newlayer,0);
		ds_list_add(newlayer,0); 
		ds_list_add(newlayer,0);
		ds_list_add(undo_list, "q"+string(newlayer));
		timeline_surf_length = 0;
	}
}