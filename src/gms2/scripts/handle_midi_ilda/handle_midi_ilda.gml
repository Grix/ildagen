// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handle_midi_ilda(){

	var t_midi_msg_size = rtmidi_check_message();
	if (t_midi_msg_size <= 0)
		return;
	
	do
	{
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
		}
		t_midi_msg_size = rtmidi_check_message();
	}
	until (t_midi_msg_size <= 0)
}