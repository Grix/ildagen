function blindzone_delete() {
	repeat(4)
	{
	    ds_list_delete(controller.blindzone_list,obj_projectionzones.blindzonetoedit);
	}

	save_profile();



}
