function projectorlist_update() {
	var t_warn = false;

	var t_plist = seqcontrol.layer_list;
	for (i = 0; i < ds_list_size(t_plist); i++)
	{
	    var t_thisplist = t_plist[| i];

	    var t_daclist = t_thisplist[| 5];
    
	    for (j = 0; j < ds_list_size(t_daclist); j++)
	    {
	        //check if dac is connected
	        var t_thisdaclist = t_daclist[| j];
	        var t_found = -1;
	        for (k = 0; k < ds_list_size(controller.dac_list); k++)
	        {
	            var t_thisdaclist2 = controller.dac_list[| k];
	            if (t_thisdaclist[| 1] == t_thisdaclist2[| 1])
	            {
	                t_found = k;
	                break;
	            }
	        }
	        if (t_found == -1)
	        {
	            ds_list_free_pool(t_thisdaclist);
	            ds_list_delete(t_daclist,j);
	            j--;
	            t_warn = true;
	        }
	        else
	        {
	            t_thisdaclist[| 0] = t_found;
	        }
        
	    }
	}

	/*if (t_warn)
	{
	    show_message_new("Warning: One or more DACs have been removed from their timeline projector configuration due to being disconnected or referenced multiple times.");
	}*/

	with (obj_projectors)
	{
	    surface_free(surf_projectorlist);
	    surf_projectorlist = -1;
	}




}
