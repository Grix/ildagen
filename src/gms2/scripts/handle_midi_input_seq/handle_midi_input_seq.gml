// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handle_midi_input_seq(){

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
			var t_note = rtmidi_get_message(1) | ((rtmidi_get_message(0) & $0F) << 8);
			
			if (controller.laseron_midi_trigger == -1)
				controller.laseron_midi_trigger = t_note;
			else if (t_note == controller.laseron_midi_trigger)
			{
				with (obj_laseron)
				{
					event_perform(ev_mouse, ev_left_press);
				}
			}
			else
			{
				ds_list_add(t_keys, t_note);
				ds_list_add(midi_keys_pressed, t_note);
			}
		}
		if (t_type == 128 || (t_type == 144 && rtmidi_get_message(2) == 0))
		{
			// MIDI key released
			var t_note = rtmidi_get_message(1) | ((rtmidi_get_message(0) & $0F) << 8);
			if (ds_list_find_index(midi_keys_pressed, t_note) != -1)
				ds_list_delete(midi_keys_pressed, ds_list_find_index(midi_keys_pressed, t_note));
		}
		else if (t_type == 176)
		{
			// CC message
			var t_ccid = rtmidi_get_message(1);
			
			// Sliders/knobs
			var t_value = rtmidi_get_message(2);
			if (t_value > 10 && t_value < 117)
			{
				if (intensity_scale_midi_shortcut == -1)
					intensity_scale_midi_shortcut = t_ccid;
				if (volume_midi_shortcut == -1)
					volume_midi_shortcut = t_ccid;
			}
			
			if (t_ccid == intensity_scale_midi_shortcut)
			{
				 intensity_scale = rtmidi_get_message(2) / 127;
			}
			if (t_ccid == volume_midi_shortcut)
			{
				 volume = rtmidi_get_message(2) / 127 * 100;
				 if (song != -1)
					FMODGMS_Chan_Set_Volume(play_sndchannel,volume/100);
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
	
	// check jump buttons
	for (i = 0; i < ds_list_size(jump_button_list_midi); i += 2)
	{
		if (jump_button_list_midi[| i] == -1)
		{
			jump_button_list_midi[| i] = t_keys[| 0];
		}
		else if (jump_button_list_midi[| i] >= 0)
		{
			if (ds_list_find_index(t_keys,jump_button_list_midi[| i]) != -1)
			{
				tlpos = jump_button_list_midi[| i + 1]/projectfps*1000;
				frame_surf_refresh = 1;
			}
		}
	}
	
	ds_list_free_pool(t_keys);
}