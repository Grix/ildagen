function close_dacs() {
	//cleanup
	for (i = 0; i < ds_list_size(dac_list); i++)
	{
	    var daclist = dac_list[| i];
	    if (ds_list_exists_pool(daclist))
	        dac_blank_and_center(daclist);
	}



}
