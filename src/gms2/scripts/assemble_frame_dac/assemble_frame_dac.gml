function assemble_frame_dac() {
	buffer_seek(output_buffer, buffer_seek_start, 0);

	if (ds_list_size(el_list) == 0) 
	{
	    optimize_middle_output();
	}
	else
	{
	    if (controller.exp_optimize)
	    {
	        if (controller.opt_onlyblanking)
	        {
	            if (!prepare_output_onlyblank())
	            {
	                optimize_middle_output();
	            }
	            else
	            {
	                make_frame_onlyblank();
					output_framelist_to_buffer();
	            }
	        }
	        else
	        {
	            if (!prepare_output())
	            {
	                optimize_middle_output();
	            }
	            else
	            {
	                make_frame();
					output_framelist_to_buffer();
	            }
	        }
	    }
	    else
	    {
	        if (!prepare_output_unopt())
	        {
	            optimize_middle_output();
	        }
	        else
	        {
	            make_frame_unopt();
				output_framelist_to_buffer();
	        }
	    }
	}





}
