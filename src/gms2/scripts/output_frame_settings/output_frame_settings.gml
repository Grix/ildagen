function output_frame_settings() {

	output_buffer = controller.dac[| 4];
	output_buffer2 = controller.dac[| 5];
	output_buffer_ready = controller.dac[| 6];
	output_buffer_next_size = controller.dac[| 7];

	if (output_buffer_ready)
	{ 
		//if (debug_mode)
	    //    log("outputted frame ", dac, output_buffer, output_buffer_next_size, output_buffer_next_size*projectfps/fpsmultiplier, fpsmultiplier, delta_time/1000);
        //log(delta_time / 1000);
		
	    dac_send_frame(controller.dac, output_buffer, output_buffer_next_size, output_buffer_next_size*controller.projectfps/controller.fpsmultiplier);
	    output_buffer_ready = false;
	    laseronfirst = false;
    
	    var t_output_buffer_prev = output_buffer;
	    output_buffer = output_buffer2;
	    output_buffer2 = t_output_buffer_prev;
	}

	if (el_list == -1)
	    load_frame_settings();
    
	//blindzones preview
	blindzone_el_lists = 0;
	for (i = 0; i < ds_list_size(controller.blindzone_list); i += 4)
	{
	    var blindzone_el = ds_list_create_pool();
		repeat(20)
			ds_list_add(blindzone_el, 0);
	    //blindzone_el[| 19] = 0; //fills up to 19 with 0
	    blindzone_el[| 10] = true;
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
	    ds_list_add(blindzone_el, 0);
	    ds_list_add(blindzone_el, c_white);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
	    ds_list_add(blindzone_el, 0);
	    ds_list_add(blindzone_el, c_white);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
	    ds_list_add(blindzone_el, 0);
	    ds_list_add(blindzone_el, c_white);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
	    ds_list_add(blindzone_el, 0);
	    ds_list_add(blindzone_el, c_white);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
	    ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
	    ds_list_add(blindzone_el, 0);
	    ds_list_add(blindzone_el, c_white);
	    ds_list_add(el_list, blindzone_el);
	    blindzone_el_lists++;
	}

	assemble_frame_dac();

	output_buffer_ready = true;

	controller.dac[| 4] = output_buffer;
	controller.dac[| 5] = output_buffer2;
	controller.dac[| 6] = output_buffer_ready;
	controller.dac[| 7] = output_buffer_next_size;


	for (i = 0; i < blindzone_el_lists; i++)
	{
	    ds_list_free_pool(el_list[| ds_list_size(el_list)-1]); 
	    ds_list_delete(el_list, ds_list_size(el_list)-1);
	}

	return 1;




}
