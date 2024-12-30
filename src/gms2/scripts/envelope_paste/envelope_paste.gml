// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function envelope_paste(){
	
	with (seqcontrol)
	{
		add_action_history_ilda("SEQ_env_paste");
		
		if (seqcontrol.envelope_copy_duration <= 0)
			break;
		else if (seqcontrol.envelope_copy_duration == infinity)
			envelope_paste_all();
		else
			moving_object = 12;
	}
	
}