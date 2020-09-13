function split_timelineobject() {
	//splitting timeline objects
	splitted = false;
	for (i = 0; i < ds_list_size(somaster_list); i++)
	{
	    objectlist = somaster_list[| i];
		if (!ds_list_exists(objectlist))
		{
			ds_list_delete(somaster_list, i);
			if (i > 0)
				i--;
			continue;
		}
	    correctframe = round(tlpos/1000*projectfps);
	    infolist =  ds_list_find_value(objectlist,2);
	    frametime = ds_list_find_value(objectlist,0);
	    object_length = ds_list_find_value(infolist,2);
    
	    if ( (correctframe > frametime) && (correctframe < (frametime+object_length)) )
	    {
	        //split this object
	        splitted = true;
	        splitafternum = correctframe-frametime;
	        object1 = buffer_create(16,buffer_grow,1);
	        object2 = buffer_create(16,buffer_grow,1);
        
	        el_buffer = objectlist[| 1];
	        buffer_seek(el_buffer, buffer_seek_start, 0);
	        bufferformat = buffer_read(el_buffer, buffer_u8);
	        maxframes = buffer_read(el_buffer,buffer_u32);
        
	        buffer_write(object1,buffer_u8, bufferformat);
	        buffer_write(object1,buffer_u32, splitafternum);
        
	        for (j = 0; j < splitafternum; j++)
	        {
	            numofel = buffer_read(el_buffer,buffer_u32);
	            buffer_write(object1, buffer_u32, numofel);
	            for (k = 0; k < numofel; k++)
	            {
	                numofinds = buffer_read(el_buffer,buffer_u32);
	                buffer_write(object1, buffer_u32, numofinds);
	                for (u = 0; u < 10; u++)
	                {
	                    buffer_write(object1,buffer_f32,buffer_read(el_buffer,buffer_f32));
	                }
	                for (u = 10; u < 20; u++)
	                {
	                    buffer_write(object1,buffer_bool,buffer_read(el_buffer,buffer_bool));
	                }
	                for (u = 20; u < numofinds; u += 4)
	                {
	                    buffer_write(object1,buffer_f32,buffer_read(el_buffer,buffer_f32));
	                    buffer_write(object1,buffer_f32,buffer_read(el_buffer,buffer_f32));
	                    buffer_write(object1,buffer_bool,buffer_read(el_buffer,buffer_bool));
	                    buffer_write(object1,buffer_u32,buffer_read(el_buffer,buffer_u32));
	                }
	            }
	        }
        
	        buffer_write(object2,buffer_u8, bufferformat);
	        buffer_write(object2,buffer_u32, maxframes-splitafternum);
        
	        for (j = splitafternum; j < maxframes; j++)
	        {
	            numofel = buffer_read(el_buffer,buffer_u32);
	            buffer_write(object2, buffer_u32, numofel);
	            for (k = 0; k < numofel; k++)
	            {
	                numofinds = buffer_read(el_buffer,buffer_u32);
	                buffer_write(object2, buffer_u32, numofinds);
	                for (u = 0; u < 10; u++)
	                {
	                    buffer_write(object2,buffer_f32,buffer_read(el_buffer,buffer_f32));
	                }
	                for (u = 10; u < 20; u++)
	                {
	                    buffer_write(object2,buffer_bool,buffer_read(el_buffer,buffer_bool));
	                }
	                for (u = 20; u < numofinds; u += 4)
	                {
	                    buffer_write(object2,buffer_f32,buffer_read(el_buffer,buffer_f32));
	                    buffer_write(object2,buffer_f32,buffer_read(el_buffer,buffer_f32));
	                    buffer_write(object2,buffer_bool,buffer_read(el_buffer,buffer_bool));
	                    buffer_write(object2,buffer_u32,buffer_read(el_buffer,buffer_u32));
	                }
	            }
	        }
        
	        objectlist1 = ds_list_create();
	        objectlist2 = ds_list_create();
        
	        infolist = ds_list_create();
	        ds_list_add(infolist, splitafternum-1);
	        ds_list_add(infolist, -1);
	        ds_list_add(infolist, splitafternum);
        
	        ds_list_add(objectlist1, frametime);
	        ds_list_add(objectlist1, object1);
	        ds_list_add(objectlist1, infolist);
        
	        infolist = ds_list_create();
	        ds_list_add(infolist, maxframes-splitafternum-1);
	        ds_list_add(infolist, -1);
	        ds_list_add(infolist, maxframes-splitafternum);
        
	        ds_list_add(objectlist2, frametime+splitafternum);
	        ds_list_add(objectlist2, object2);
	        ds_list_add(objectlist2, infolist);
        
	        for (j = 0; j < ds_list_size(layer_list); j++)
	        {
	            layertop = layer_list[| j];
	            _layer = layertop[| 1];
	            for (k = 0; k < ds_list_size(_layer); k++)
	            {
	                if (ds_list_find_index(_layer, objectlist) != -1)
	                {
	                    ds_list_delete(_layer, ds_list_find_index(_layer, objectlist));
	                    ds_list_add(_layer, objectlist1);
	                    ds_list_add(_layer, objectlist2);
	                    undolisttemp = ds_list_create();
	                    ds_list_add(undolisttemp, objectlist);
	                    ds_list_add(undolisttemp, objectlist1);
	                    ds_list_add(undolisttemp, objectlist2);
	                    ds_list_add(undo_list, "s"+string(undolisttemp));
	                }
	            }
	        }
	    }
	}

	if (!splitted)
	    show_message_new("To split an object, select it and move the playback cursor to the desired split position, then try again.");
	else
	{
	    ds_list_clear(somaster_list);
		timeline_surf_length = 0;
	}




}
