FMODGMS_Sys_Update();

var t_bits = FMODGMS_Snd_Get_BitsPerSample(song_parse);
var t_channels = FMODGMS_Snd_Get_NumChannels(song_parse);

var t_multiplier = round(t_bits/8)*t_channels;
var t_numPoints = 2048;
var t_length = t_numPoints*t_multiplier;
var t_parsebuffer = buffer_create(t_length, buffer_fixed, 1); //todo allocate beforehand
var t_bufferIn = buffer_create(t_numPoints*4, buffer_fixed, 4);
var t_bufferOut = buffer_create(t_numPoints, buffer_fixed, 4);

var t_time = get_timer();
while (get_timer()-t_time < (1/35)*1000000) //30+ fps target
{
	var t_pcmpos = parsingaudio_pos*song_samplerate;
	buffer_seek(t_parsebuffer, buffer_seek_start, 0);
	buffer_seek(t_bufferIn, buffer_seek_start, 0);
	buffer_seek(t_bufferOut, buffer_seek_start, 0);
	
	var t_result = FMODGMS_Snd_ReadData(song_parse, t_pcmpos, t_length, buffer_get_address(t_parsebuffer));

	if (t_result == 0)
	{
	    parsingaudio = 0;
	    t_time = 0;
		FMODGMS_Snd_Unload(song_parse);
		song_parse = -1;
	}
	else if (t_result < 0)
	{
		show_message_new("Failure when analyzing audio: "+FMODGMS_Util_GetErrorMessage());
		parsingaudio = 0;
	    t_time = 0;
		FMODGMS_Snd_Unload(song_parse);
		song_parse = -1;
	}
	
	for (var t_i = 0; t_i < t_numPoints; t_i++)
		buffer_write(t_bufferIn, buffer_f32, buffer_peek(t_parsebuffer, t_i*t_multiplier, buffer_s16)); //todo variable type
	
	var t_w = FMODGMS_Util_FFT(buffer_get_address(t_bufferIn), buffer_get_address(t_bufferOut), t_numPoints, 1);

	ds_list_add(audio_list,min(t_w/6000, 1));//(1+clamp(t_w*1.5,0,3.4)));
	
	var t_s = 0;
	for (var t_i = 0; t_i < 5; t_i++)
		t_s += buffer_peek(t_bufferOut, t_i*4, buffer_f32);
	ds_list_add(audio_list,min(t_s/5, 1));//ln(1+clamp(t_s*8,0,3.4)));
	t_s = 0;
	for (var t_i = 40; t_i < 150; t_i++)
		t_s += buffer_peek(t_bufferOut, t_i*4, buffer_f32);
	ds_list_add(audio_list,min(t_s/35, 1));//ln(1+clamp(t_s*8,0,3.4)));
	
	parsingaudio_pos += 1/30;
}

buffer_delete(t_parsebuffer);
buffer_delete(t_bufferIn);
buffer_delete(t_bufferOut);
timeline_surf_length = 0;