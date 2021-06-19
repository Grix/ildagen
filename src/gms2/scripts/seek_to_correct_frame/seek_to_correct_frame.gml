///@param frame
///@param buffer
///@param objectlist
function seek_to_correct_frame(argument0, argument1, argument2) {
	var t_frame = argument1;
	var t_buffer = argument0;
	var t_infolist = argument2[| 2];
	if (ds_list_size(t_infolist) == 3)
		ds_list_add(t_infolist, create_checkpoint_list(t_buffer));
		
	var t_checkpointlist = ds_list_find_value(t_infolist, 3);

	try
	{
		buffer_seek(t_buffer,buffer_seek_start,0);
		var t_buffer_ver = buffer_read(t_buffer,buffer_u8);
		if (t_buffer_ver != 52)
		{
			show_message_new("Error: Unexpected version id reading buffer in seek_to_correct_frame: "+string(t_buffer_ver)+". Things might get ugly. Contact developer.");
			return false;
		}
		buffer_maxframes = buffer_read(t_buffer,buffer_u32);
	
		if (!is_undefined(t_checkpointlist) && t_frame >= 100 && ds_list_size(t_checkpointlist) >= t_frame/100)
		{
			if (buffer_get_size(t_buffer) <= t_checkpointlist[| floor(t_frame / 100)-1])
				return false;
			
			buffer_seek(t_buffer, buffer_seek_start, t_checkpointlist[| floor(t_frame / 100)-1]);
			t_frame = t_frame % 100;
		}
        
		//skip to correct frame
		for (var t_i = 0; t_i < t_frame;t_i++)
		{
			var t_numofel = buffer_read(t_buffer,buffer_u32);
			for (var t_u = 0; t_u < t_numofel; t_u++)
			{
				var t_numofdata = buffer_read(t_buffer,buffer_u32)-20;
				
				if (buffer_get_size(t_buffer) <= buffer_tell(t_buffer)+50+t_numofdata*13/4)
					return false;
				
				buffer_seek(t_buffer,buffer_seek_relative,50+t_numofdata*13/4);
			}
		}
	}
	catch (_exception)
	{
		try
		{
			var t_frame = argument1;
			buffer_seek(t_buffer,buffer_seek_start,0);
			var t_buffer_ver = buffer_read(t_buffer,buffer_u8);
			if (t_buffer_ver != 52)
			{
				show_message_new("Error: Unexpected version id reading buffer in seek_to_correct_frame: "+string(t_buffer_ver)+". Things might get ugly. Contact developer.");
				return false;
			}
			buffer_maxframes = buffer_read(t_buffer,buffer_u32);
		
			//skip to correct frame
			for (var t_i = 0; t_i < t_frame;t_i++)
			{
				var t_numofel = buffer_read(t_buffer,buffer_u32);
				for (var t_u = 0; t_u < t_numofel; t_u++)
				{
					var t_numofdata = buffer_read(t_buffer,buffer_u32)-20;
					
					if (buffer_get_size(t_buffer) <= buffer_tell(t_buffer)+50+t_numofdata*13/4)
						return false;
						
					buffer_seek(t_buffer,buffer_seek_relative,50+t_numofdata*13/4);
				}
			}
			return true;
		}
		catch (_exception2)
		{
			return false;	
		}
	}
	
	return true;
}
