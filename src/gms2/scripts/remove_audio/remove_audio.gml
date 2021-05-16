function remove_audio() {
	if (song != -1) 
	{
		FMODGMS_Chan_StopChannel(play_sndchannel);
	    FMODGMS_Snd_Unload(song);
	    buffer_delete(song_buffer);
	
		for (i = 0; i < ds_list_size(effect_list); i++)
		{
		    FMODGMS_Chan_Remove_Effect(play_sndchannel, ds_list_find_value(effect_list,i));
			FMODGMS_Effect_Remove(ds_list_find_value(effect_list,i));
		}
		ds_list_clear(effect_list);
	}
	song = -1;
	if (buffer_exists(audio_buffer))
		buffer_delete(audio_buffer);
	audio_buffer = -1;
	parsingaudio = 0;
	timeline_surf_length = 0;
	clean_redo_list_seq();



}
