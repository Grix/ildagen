function read_ilda_work() {
	//works its way through an ilda file
	with (controller)
	{
	    while (1)
	    {
	        if (read_ilda_header())
	        {
	            el_id++;
	            global.loading_current = global.loading_end;
	            log("Abort at "+string(global.loading_current))
	            exit;
	        }
        
	        if (format != 2)
	            read_ilda_frame();
        
	        if (get_timer()-global.loadingtimeprev >= 100000)
	        {
	            global.loading_current = i;
	            global.loadingtimeprev = get_timer();
	            break;
	        }
	    }
	}




}
