function load_live_project_work() {
	if (idbyte == 200 || idbyte == 201 || idbyte == 202 || idbyte == 203)
	{
	    for (j = global.loading_current; j < global.loading_end;j++)
	    {
	        if (get_timer()-global.loadingtimeprev >= 100000)
	        {
	            global.loading_current = j;
	            global.loadingtimeprev = get_timer();
	            return 0;
	        }
        
	        //object data
	        objectlist = ds_list_create_pool();
	        ds_list_add(objectlist, round(buffer_read(load_buffer,buffer_u32)));
            
	        objectbuffersize = buffer_read(load_buffer,buffer_u32);
	        objectbuffer = buffer_create(objectbuffersize,buffer_fixed,1);
	        ds_list_add(objectlist, objectbuffer);
	        buffer_copy(load_buffer,buffer_tell(load_buffer),objectbuffersize,objectbuffer,0);
	        buffer_seek(load_buffer,buffer_seek_relative,objectbuffersize);
            
	        ds_list_add(objectlist, round(buffer_read(load_buffer,buffer_u32)));
	        ds_list_add(objectlist, -1);
			var t_maxframes = round(buffer_read(load_buffer,buffer_u32));
	        ds_list_add(objectlist, t_maxframes);
			ds_list_add(objectlist, create_checkpoint_list(objectbuffer));
            
	        ds_list_add(objectlist, round(buffer_read(load_buffer,buffer_u32)));
			ds_list_add(objectlist, buffer_read(load_buffer,buffer_bool));
			
			var t_midi_key = -2;
			var t_bars_duration = 0;
		
			if (idbyte >= 201)
			{
				ds_list_add(objectlist,buffer_read(load_buffer,buffer_bool));
				ds_list_add(objectlist,buffer_read(load_buffer,buffer_bool));
				ds_list_add(objectlist,buffer_read(load_buffer,buffer_u8));
				var t_has_midi_key = buffer_read(load_buffer,buffer_bool);
				buffer_read(load_buffer,buffer_bool);
				buffer_read(load_buffer,buffer_bool);
				t_midi_key = buffer_read(load_buffer,buffer_u32);
				if (!t_has_midi_key)
					t_midi_key = -2;
				t_bars_duration = buffer_read(load_buffer,buffer_f16);
				buffer_read(load_buffer,buffer_u16);
				buffer_read(load_buffer,buffer_u32);
			}
			else
			{
				ds_list_add(objectlist,0);
				ds_list_add(objectlist,0);
				ds_list_add(objectlist,0);
			}
			
			if (idbyte >= 202)
			{
				ds_list_add(objectlist,buffer_read(load_buffer,buffer_string));
				
				var t_daclist = ds_list_create_pool();
	            ds_list_add(objectlist, t_daclist);
	            numofdacs = buffer_read(load_buffer,buffer_u8);
	            repeat (numofdacs)
	            {
	                var t_thisdaclist = ds_list_create_pool();
	                ds_list_add(t_daclist, t_thisdaclist);
	                ds_list_add(t_thisdaclist, -1);
	                ds_list_add(t_thisdaclist, buffer_read(load_buffer,buffer_string));
	                ds_list_add(t_thisdaclist, buffer_read(load_buffer,buffer_string));
	            }
			}
			else
			{
				ds_list_add(objectlist,"");
				ds_list_add(objectlist,ds_list_create_pool());
			}
			
			ds_list_add(objectlist, t_midi_key);
			if (t_bars_duration <= 0)
				t_bars_duration = ((controller.bpm / 60) * (t_maxframes / controller.projectfps)) / controller.beats_per_bar;
			ds_list_add(objectlist, t_bars_duration);
		
			ds_list_add(filelist, objectlist);
		}
	}
    
	buffer_delete(load_buffer);

	global.loading_loadliveproject = 0;

	room_goto(rm_live);
	clean_redo_live();


}
