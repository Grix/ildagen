function benchmark() {
	
	repeat(100)
		ds_list_create();
	
	var t_start = get_timer();
	
	repeat(100)
		var list = ds_list_create();
	
	log("ds_list_create", get_timer()-t_start);
	
	repeat(1000)
		ds_list_add(list, random(20));
	
	t_start = get_timer();
	
	ds_list_destroy(list);
	
	log("ds_list_destroy", get_timer()-t_start);
	
	repeat(100)
		ds_list_create_pool();
	
	t_start = get_timer();
	
	repeat(100)
		var list = ds_list_create_pool();
	
	log("ds_list_create_pool", get_timer()-t_start);
	
	repeat(1000)
		ds_list_add(list, random(20));
	
	t_start = get_timer();
	
	ds_list_free_pool(list);
	
	log("ds_list_free_pool", get_timer()-t_start);
	
	t_start = get_timer();
	
	repeat(100)
		var list = ds_list_create_pool();
	
	log("ds_list_create_pool (again)", get_timer()-t_start);
	
	/*var t_zero = 0;
	var t_const = 100;
	 minitimeline_surf = surface_create(t_const/t_zero, clamp(infinity, 1, 8192));*/
	
	//show_message_new("test");

	//tesing benchmark

	//todo test buffer slignment, is it better to align to 4 in frame buffers?

	/*log("---")
	blah1 = buffer_create(10000, buffer_fast, 1);
	blah2 = buffer_create(32, buffer_grow, 1);
	time = get_timer();
	i = 3322;
	x = 32322;
	y = 1122;
	repeat (10000)
	{
	    buffer_write(blah2, buffer_u16, x);
	}
	log("time1: ",get_timer()-time);
	time2 = get_timer();
	i = 12312;
	x = 12312;
	y = 33222;
	repeat (10000)
	{
	    buffer_write(blah1, buffer_u8, x & $ff);
		buffer_write(blah1, buffer_u8, x >> 8);
	}
	//buffer_copy(blah1, 0, 10000, blah2, 0);
	log("time2: ",get_timer()-time2);
	*/
	/*
	time2 = get_timer();
	i = 0;
	x = 0;
	y = 0;
	repeat (10000)
	{
	    x++;
	    y++;
	    if (point_in_rectangle(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],bbox_left,bbox_top,bbox_right,bbox_bottom))
	        i++;
	}
	log(get_timer()-time2);
	*/



}
