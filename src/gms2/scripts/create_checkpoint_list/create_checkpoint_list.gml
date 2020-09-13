///@param buffer
function create_checkpoint_list(argument0) {
	var t_buffer = argument0;

	var t_checkpointlist = ds_list_create();

	buffer_seek(t_buffer,buffer_seek_start,0);
	var t_buffer_ver = buffer_read(t_buffer,buffer_u8);
	if (t_buffer_ver != 52)
	{
		show_message_new("Error: Unexpected version id reading buffer in create_checkpoint_list: "+string(t_buffer_ver)+". Things might get ugly. Contact developer.");
		return t_checkpointlist;
	}
	var t_buffer_maxframes = buffer_read(t_buffer,buffer_u32);

	for (var t_i = 0; t_i < t_buffer_maxframes; t_i++)
	{
		if (t_i % 100 == 0 && t_i != 0)
			ds_list_add(t_checkpointlist, buffer_tell(t_buffer));
	
		var t_numofel = buffer_read(t_buffer,buffer_u32);
		for (var t_u = 0; t_u < t_numofel; t_u++)
		{
			var t_numofdata = buffer_read(t_buffer,buffer_u32)-20;
			buffer_seek(t_buffer,buffer_seek_relative,50+t_numofdata*3.25);
		}
	}

	return t_checkpointlist;


}
