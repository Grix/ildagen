// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handle_midi_input_live(){


	var t_midi_msg_size = rtmidi_check_message();
	if (t_midi_msg_size <= 0)
		return;
		
	var t_keys = ds_list_create();
	
	do
	{
		/*for (var t_midi_byte = 0; t_midi_byte < t_midi_msg_size; t_midi_byte++)
		{
			var t_byte = rtmidi_get_message(t_midi_byte);
			log(t_byte);
		}*/
		if (rtmidi_get_message(0) == 144 && rtmidi_get_message(2) > 0)
		{
			// MIDI key pressed
			ds_list_add(t_keys, rtmidi_get_message(1));
		}
		
		t_midi_msg_size = rtmidi_check_message();
	}
	until (t_midi_msg_size <= 0)
	
	
	if (ds_list_empty(t_keys))
	{
		ds_list_destroy(t_keys);
		return;
	}
	
	
	for (i = 0; i < ds_list_size(filelist); i++)
	{
		if (ds_list_find_value(filelist[| i], 13) == -1)
		{
			ds_list_set(filelist[| i], 13, t_keys[| 0]);
		}
		else if (ds_list_find_value(filelist[| i], 13) > 0)
		{
			if (ds_list_find_index(t_keys,ds_list_find_value(filelist[| i], 13)) != -1)
			{
				if (ds_list_find_value(filelist[| i], 0))
				{
					// stop
					ds_list_set(filelist[| i], 0, false);
				}
				else
				{
					// play
					if (stop_at_play)
					{
						for (j = 0; j < ds_list_size(filelist); j++)
						{
							ds_list_set(filelist[| j], 0, false);
						}
					}
					
					playing = 1;
					ds_list_set(filelist[| i], 0, true);
						
					if (ds_list_find_value(filelist[| i], 9) == 0) // if restart instead of resume
						ds_list_set(filelist[| i], 2, 0);
					else 
					{
						if (ds_list_find_value(filelist[| i], 2) >= ds_list_find_value(filelist[| i], 4))
							ds_list_set(filelist[| i], 2, 0);
					}
				}
				frame_surf_refresh = 1;
			}
		}
	}
	
	ds_list_destroy(t_keys);
}