// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function envelope_copy_all(){
	
	with (seqcontrol)
	{
		add_action_history_ilda("SEQ_env_copy_all");
		
		ds_list_clear(envelope_copy_list_data);
		ds_list_clear(envelope_copy_list_time);
		seqcontrol.envelope_copy_duration = -1;
		
		if (!ds_list_exists(envelopetoedit))
			return;
		
		time_list = ds_list_find_value(envelopetoedit,1);
		data_list = ds_list_find_value(envelopetoedit,2);
		
		seqcontrol.envelope_copy_duration = infinity;
		ds_list_copy(envelope_copy_list_time, time_list);
		ds_list_copy(envelope_copy_list_data, data_list);
	}
}