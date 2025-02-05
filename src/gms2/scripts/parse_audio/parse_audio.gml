function parse_audio() {
	FMODGMS_Sys_Update();

	var t_bits = FMODGMS_Snd_Get_BitsPerSample(song_parse);
	var t_channels = FMODGMS_Snd_Get_NumChannels(song_parse);
	var t_multiplier = round(t_bits/8)*t_channels;
	var t_numPoints = 2048;
	var t_length = t_numPoints*t_multiplier;

	if (parsingaudio_pos == 0)
	{
		audio_buffer = buffer_create(fmod_get_length(song_parse)/1000*60*3+9, buffer_fast, 1);
		parsebuffer = buffer_create(t_length, buffer_fixed, 1);
		bufferIn = buffer_create(t_numPoints*4, buffer_fixed, 4);
		bufferOut = buffer_create(t_numPoints, buffer_fixed, 4);
	}

	var t_time = get_timer();
	while (get_timer()-t_time < (1/35)*1000000) //30+ fps target
	{
		var t_pcmpos = parsingaudio_pos*song_samplerate;
		buffer_seek(parsebuffer, buffer_seek_start, 0);
		buffer_seek(bufferIn, buffer_seek_start, 0);
		buffer_seek(bufferOut, buffer_seek_start, 0);
	
		var t_result = FMODGMS_Snd_ReadData(song_parse, t_pcmpos, t_length, buffer_get_address(parsebuffer));

		if (t_result == 0 || (songlength/1000 < parsingaudio_pos))
		{
		    parsingaudio = 0;
		    t_time = 0;
			FMODGMS_Snd_Unload(song_parse);
			song_parse = -1;
			buffer_delete(parsebuffer);
			buffer_delete(bufferIn);
			buffer_delete(bufferOut);
			parsebuffer = -1;
			bufferIn = -1;
			bufferOut = -1;
			exit;
		}
		else if (t_result < 0)
		{
			show_message_new("Failure when analyzing audio: "+FMODGMS_Util_GetErrorMessage());
			parsingaudio = 0;
		    t_time = 0;
			FMODGMS_Snd_Unload(song_parse);
			song_parse = -1;
			buffer_delete(parsebuffer);
			buffer_delete(bufferIn);
			buffer_delete(bufferOut);
			parsebuffer = -1;
			bufferIn = -1;
			bufferOut = -1;
			exit;
		}
	
		for (var t_i = 0; t_i < t_numPoints; t_i++)
			buffer_write(bufferIn, buffer_f32, buffer_peek(parsebuffer, t_i*t_multiplier, buffer_s16));
	
		var t_w = FMODGMS_Util_FFT(buffer_get_address(bufferIn), buffer_get_address(bufferOut), t_numPoints, 1);

		buffer_write(audio_buffer, buffer_u8, min(t_w/6000, 1)*255);
	
		var t_height = audio_fft_bass_high_cutoff-audio_fft_bass_low_cutoff;
		var t_s = 0;
		for (var t_i = audio_fft_bass_low_cutoff; t_i < audio_fft_bass_high_cutoff; t_i++)
			t_s += buffer_peek(bufferOut, t_i*4, buffer_f32);
		buffer_write(audio_buffer, buffer_u8, min(t_s/5*(5/t_height), 1)*255);
		t_s = 0;
		t_height = audio_fft_treble_high_cutoff-audio_fft_treble_low_cutoff;
		for (var t_i = audio_fft_treble_low_cutoff; t_i < audio_fft_treble_high_cutoff; t_i++)
			t_s += buffer_peek(bufferOut, t_i*4, buffer_f32);
		buffer_write(audio_buffer, buffer_u8, min(t_s/35*(35/t_height), 1)*255);
	
		parsingaudio_pos += 1/60;
	}

	timeline_surf_length = 0;


}
