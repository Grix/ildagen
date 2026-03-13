// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bpm_tap_trigger(){

	with (livecontrol)
	{
		if (!controller.use_bpm)
			return;
		
		var t_time = get_timer();
		if (bpm_tap_number == 0)
			bpm_start_tap_time = t_time;
		bpm_tap_number++;
		bpm_previous_tap_time = t_time;
		
		if (bpm_tap_number >= 2 && bpm_start_tap_time < bpm_previous_tap_time)
		{
			bpm_adjusted = clamp((bpm_tap_number-1)*1000000/(bpm_previous_tap_time - bpm_start_tap_time) * 60, 1, 1000);
			if (bpm_adjusted_round)
				bpm_adjusted = round(bpm_adjusted);
		}
		
		if (bpm_tap_number > 8)
		{
			bpm_tap_number = 5;
			bpm_start_tap_time = bpm_start_tap_time + (bpm_previous_tap_time - bpm_start_tap_time)/2;
		}
	}

}