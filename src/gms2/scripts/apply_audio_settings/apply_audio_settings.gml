function apply_audio_settings() {
	FMODGMS_Chan_Set_Volume(play_sndchannel, volume/100);
	FMODGMS_Chan_Set_Mute(play_sndchannel, muted);

	if (playing && tlpos < fmod_get_length(song))
		FMODGMS_Chan_ResumeChannel(play_sndchannel);
	else
		FMODGMS_Chan_PauseChannel(play_sndchannel);

	FMODGMS_Chan_Set_Pitch(play_sndchannel, playbackspeed);

	for (i = 0; i < ds_list_size(effect_list); i++)
	{
	    FMODGMS_Chan_Remove_Effect(play_sndchannel, ds_list_find_value(effect_list,i));
		FMODGMS_Effect_Remove(ds_list_find_value(effect_list,i));
	}
	ds_list_clear(effect_list);

	if (playbackspeed > 1)
	 {
	     repeat (floor(playbackspeed))
	     {
	         var t_effect = FMODGMS_Effect_Create(FMODGMS_EFFECT_PITCHSHIFT);
	         FMODGMS_Effect_Set_Parameter(t_effect, 0, 1/1.5);
	         FMODGMS_Effect_Set_Parameter(t_effect, 1, 4096);
			 FMODGMS_Chan_Add_Effect(play_sndchannel, t_effect, 0);
	         ds_list_add(effect_list,t_effect);
	     }
	 }
	 else if (playbackspeed < 1)
	 {
	     repeat (4-floor(playbackspeed*5))
	     {
	         var t_effect = FMODGMS_Effect_Create(FMODGMS_EFFECT_PITCHSHIFT);
	         FMODGMS_Effect_Set_Parameter(t_effect, 0, 1.5);
	         FMODGMS_Effect_Set_Parameter(t_effect, 1, 4096);
			 FMODGMS_Chan_Add_Effect(play_sndchannel, t_effect, 0);
	         ds_list_add(effect_list,t_effect);
	     }
	 }


}
