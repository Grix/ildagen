// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handle_midi_input_live(){

	var t_midi_msg_size = rtmidi_check_message();
	if (t_midi_msg_size <= 0)
		return;
		
	var t_keys = ds_list_create_pool();
	
	do
	{
		/*for (var t_midi_byte = 0; t_midi_byte < t_midi_msg_size; t_midi_byte++)
		{
			var t_byte = rtmidi_get_message(t_midi_byte);
			log(t_byte);
		}*/
		var t_type = (rtmidi_get_message(0) & $F0);
		if (t_type == 144 && rtmidi_get_message(2) > 0)
		{
			// MIDI key pressed
			ds_list_add(t_keys, rtmidi_get_message(1));
		}
		else if (t_type == 176)
		{
			// CC message
			var t_ccid = rtmidi_get_message(1);
			
			// Sliders/knobs
			var t_value = rtmidi_get_message(2);
			if (t_value > 10 && t_value < 117)
			{
				if (masteralpha_midi_shortcut == -1)
					masteralpha_midi_shortcut = t_ccid;
				else if (masterred_midi_shortcut == -1)
					masterred_midi_shortcut = t_ccid;
				else if (mastergreen_midi_shortcut == -1)
					mastergreen_midi_shortcut = t_ccid;
				else if (masterblue_midi_shortcut == -1)
					masterblue_midi_shortcut = t_ccid;
				else if (masterhue_midi_shortcut == -1)
					masterhue_midi_shortcut = t_ccid;
				else if (masterx_midi_shortcut == -1)
					masterx_midi_shortcut = t_ccid;
				else if (mastery_midi_shortcut == -1)
					mastery_midi_shortcut = t_ccid;
				else if (masterabsrot_midi_shortcut == -1)
					masterabsrot_midi_shortcut = t_ccid;
			}
			
			if (t_ccid == masteralpha_midi_shortcut)
			{
				masteralpha = rtmidi_get_message(2) / 127;
			}
			if (t_ccid == masterred_midi_shortcut)
			{
				masterred = rtmidi_get_message(2) / 127;
			}
			if (t_ccid == mastergreen_midi_shortcut)
			{
				mastergreen = rtmidi_get_message(2) / 127;
			}
			if (t_ccid == masterblue_midi_shortcut)
			{
				masterblue = rtmidi_get_message(2) / 127;
			}
			if (t_ccid == masterhue_midi_shortcut)
			{
				masterhue = rtmidi_get_message(2) / 127 * 255;
			}
			if (t_ccid == masterx_midi_shortcut)
			{
				masterx = ((rtmidi_get_message(2) / 127) - 0.5) * $8000 * 2;
			}
			if (t_ccid == mastery_midi_shortcut)
			{
				mastery = ((rtmidi_get_message(2) / 127) - 0.5) * $8000 * 2;
			}
			if (t_ccid == masterabsrot_midi_shortcut)
			{
				masterabsrot = (rtmidi_get_message(2) / 127) * 2 * pi;
			}
			
		}
		
		t_midi_msg_size = rtmidi_check_message();
	}
	until (t_midi_msg_size <= 0)
	
	// Key triggers
	if (ds_list_empty(t_keys))
	{
		ds_list_free_pool(t_keys);
		return;
	}
	
	
	for (i = 0; i < ds_list_size(filelist); i++)
	{
		if (ds_list_find_value(filelist[| i], 13) == -1)
		{
			ds_list_set(filelist[| i], 13, t_keys[| 0]);
		}
		else if (ds_list_find_value(filelist[| i], 13) >= 0)
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
	
	ds_list_free_pool(t_keys);
}