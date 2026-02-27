// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handle_dmx_input_live(){

	if (controller.enable_artnet || controller.enable_sacn)
	{
		if (!livecontrol.masteralpha_dmx_disable)
			livecontrol.masteralpha = deadband_highlow(dacwrapper_dmx_getvalue(0)) / 255;
		if (!livecontrol.masterred_dmx_disable)
			livecontrol.masterred = deadband_highlow(dacwrapper_dmx_getvalue(26)) / 255;
		if (!livecontrol.mastergreen_dmx_disable)
			livecontrol.mastergreen = deadband_highlow(dacwrapper_dmx_getvalue(27)) / 255;
		if (!livecontrol.masterblue_dmx_disable)
			livecontrol.masterblue = deadband_highlow(dacwrapper_dmx_getvalue(28)) / 255;
		if (!livecontrol.masterhue_dmx_disable)
			livecontrol.masterhue = deadband_highlow(dacwrapper_dmx_getvalue(29));
		if (!livecontrol.masterx_dmx_disable)
			livecontrol.masterx = (deadband_middle(dacwrapper_dmx_getvalue(30))-127) / 127 * $8000;
		if (!livecontrol.mastery_dmx_disable)
			livecontrol.mastery = (deadband_middle(dacwrapper_dmx_getvalue(31))-127) / 127 * $8000;
		if (!livecontrol.masterabsrot_dmx_disable)
			livecontrol.masterabsrot = deadband_middle(dacwrapper_dmx_getvalue(32)) / 255 * (pi*2);
		
		if (!livecontrol.speed_adjusted_dmx_disable)
		{
			var t_speedmodifier = deadband_middle(lowismiddle(dacwrapper_dmx_getvalue(33))) / 127;
				t_speedmodifier *= t_speedmodifier;
			if (controller.use_bpm)
			{
				livecontrol.bpm_adjusted = max(controller.bpm * t_speedmodifier, 5);
			}
			else
			{
				livecontrol.speed_adjusted = max(t_speedmodifier, 0.05);
			}
		}
		
		var t_dmx_file_trigger_values = array_create(8, 0);
		var t_dmx_file_trigger_values_handled = array_create(8, 0);
		var t_dmx_file_intensity_values = array_create(8, 0);
		var t_dmx_file_speed_values = array_create(8, 0);
		
		for (i = 0; i < 8; i++)
		{
			t_dmx_file_trigger_values[i] = dacwrapper_dmx_getvalue(2 + i*3 + 0);
			t_dmx_file_intensity_values[i] = deadband_highlow(dacwrapper_dmx_getvalue(2 + i*3 + 1));
			t_dmx_file_speed_values[i] = max(((deadband_middle(lowismiddle(dacwrapper_dmx_getvalue(2 + i*3 + 2))) / 127) * 2), 0.05);
		}
		
		for (i = 0; i < ds_list_size(filelist); i++)
		{
			var t_play = false;
			var t_stop = false;
			var t_objectlist = filelist[| i];
			var t_dmx_index = t_objectlist[| 14];
			if (t_dmx_index > 0)
			{
				var t_channel_match = -1;
				for (j = 0; j < 8; j++)
				{
					if (t_dmx_file_trigger_values[j] == t_dmx_index)
					{
						t_channel_match = j;
						if (previous_dmx_file_trigger_values[j] != t_dmx_index)
						{
							t_play = true;
							t_dmx_file_trigger_values_handled[j] = true;
							//log("PLAY file " + string(t_dmx_index));
						}
						break;
					}
					else if (previous_dmx_file_trigger_values[j] == t_dmx_index)
					{
						t_stop = true;
						t_dmx_file_trigger_values_handled[j] = true;
						//log("STOP file " + string(t_dmx_index));
					}
				}
				if (!t_stop && !t_play)
					continue;
				
				if (t_stop)
				{
					ds_list_set(filelist[| i], 0, false);
				}
				else if (t_play)
				{
					if (stop_at_play)
					{
						for (j = 0; j < ds_list_size(filelist); j++)
						{
							ds_list_set(filelist[| j], 0, false);
						}
					}
					
					if (!ds_list_find_value(filelist[| i], 0) && ds_list_find_value(filelist[| i], 9) == 0) // if restart instead of resume
						ds_list_set(filelist[| i], 2, 0);
					else 
					{
						if (ds_list_find_value(filelist[| i], 2) >= ds_list_find_value(filelist[| i], 4))
							ds_list_set(filelist[| i], 2, 0);
					}
					
					playing = 1;
					ds_list_set(filelist[| i], 0, true);
					//filelist[| i][| 10] = 2; // Mark as triggered in push to play
				}
				frame_surf_refresh = 1;
				
				
				
				// Todo apply per-file speed and intensity
				
			}
		}
		
		//log("DMX triggers: ", t_dmx_file_trigger_values[0], t_dmx_file_trigger_values[1], t_dmx_file_trigger_values[2], t_dmx_file_trigger_values[3]);
		for (j = 0; j < 8; j++)
		{
			if (t_dmx_file_trigger_values_handled[j] || t_dmx_file_trigger_values[j] < 16)
				previous_dmx_file_trigger_values[j] = t_dmx_file_trigger_values[j];
		}
		
	}

}


/*DMX channels
(deadbands last around 4 units unlike what is described below)
- 0: master intensity / blackout, 0 - 15 and 248-256 are deadbands
- 1: reserved, keep at 0 for forward compatibility
- 2: file 1: 0 - 15 is blackout, 16 = cell id 16 playing etc
- 3: file 1 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 4: file 1 intensity / blackout,0 - 15 and 248-256 are deadbands
- 5: file 2: 0 - 15 is blackout, 16 = cell id 16 playing etc
- 6: file 2 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 7: file 2 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 8: file 3: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 9: file 3 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 10: file 3 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 11: file 4: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 12: file 4 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 13: file 4 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 14: file 5: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 15: file 5 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 16: file 5 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 17: file 6: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 18: file 6 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 19: file 6 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 20: file 7: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 21: file 7 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 22: file 7 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 23: file 8: 0 - 15 is blackout, 16 = cell id 1 playing etc
- 24: file 8 speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
- 25: file 8 intensity / blackout, 0 - 15 and 248-256 are deadbands
- 26: Master Red color intensity , 0 - 8 and 248-256 are deadbands
- 27: Master Green color intensity , 0 - 8 and 248-256 are deadbands
- 28: Master Blue color intensity , 0 - 8 and 248-256 are deadbands
- 29: Master Hue color shift, 0 - 8 and 248-256 are deadbands
- 30: Master X offset ,  124-132 is deadband
- 31: Master Y offset ,  124-132 is deadband
- 32: Master Rotation ,  124-132 is deadband
- 33: Master Speed, 0 - 15 is 100%, 16-31 = pause, 32 = 25%, 124-132 = 100%, 255 = 400%
*/

function lowismiddle(value)
{
	if (value < 16)
		value = 127;
	else
		value = (value-15)/(255-15)*255;
	return value;
}

function deadband_highlow(value)
{
	if (value <= 3)
		value = 0;
	else if (value >= 252)
		value = 255;
	else
		value = (value-3)/252*255;
	return value;
}

function deadband_middle(value)
{
	if (value <= 123)
		value = value/123*127;
	else if (value >= 131)
		value = 127 + (value-131)/123*127;
	else
		value = 127;
	return value;
}