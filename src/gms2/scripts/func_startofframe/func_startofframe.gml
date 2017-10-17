if (string_pos("audio_", shapefunc_string_x) != -1)
	func_doaudio = 1;
else 
	func_doaudio = 0;
	
var t_w = 0;
	
if (func_doaudio)
{
	if (seqcontrol.song != -1)
	{
		//todo move to start of process
		var t_exInfo = buffer_create(34*8, buffer_fixed, 8);
		buffer_fill(t_exInfo, 0, buffer_u64, 0, buffer_get_size(t_exInfo));
		buffer_poke(t_exInfo, 0, buffer_u32, buffer_get_size(seqcontrol.song_buffer));
		song_parse = FMODGMS_Snd_LoadSound_Ext(buffer_get_address(seqcontrol.song_buffer),	
															FMODGMS_MODE_DEFAULT | 
															FMODGMS_MODE_ACCURATETIME |
															FMODGMS_MODE_OPENMEMORY_POINT | 
															FMODGMS_MODE_CREATESTREAM |
															FMODGMS_MODE_OPENONLY, 
															buffer_get_address(t_exInfo));
		buffer_delete(t_exInfo);
		
		var t_bits = FMODGMS_Snd_Get_BitsPerSample(song_parse);
		var t_channels = FMODGMS_Snd_Get_NumChannels(song_parse);
		var t_multiplier = round(t_bits/8)*t_channels;
		var t_numPoints = 2048;
		var t_length = t_numPoints*t_multiplier;
		
		audio_buffer = buffer_create(t_numPoints*2, buffer_fast, 1);
		parsebuffer = buffer_create(t_length, buffer_fixed, 1);
		bufferIn = buffer_create(t_numPoints*4, buffer_fixed, 4);
		bufferOut = buffer_create(t_numPoints, buffer_fixed, 4);
		
		var t_pcmpos = round(seqcontrol.selectedx+frame)/projectfps*seqcontrol.song_samplerate;
		//while (t_pcmpos % t_channels)
		//	t_pcmpos--;
		buffer_seek(parsebuffer, buffer_seek_start, 0);
		buffer_seek(bufferIn, buffer_seek_start, 0);
		buffer_seek(bufferOut, buffer_seek_start, 0);
	
		var t_result = FMODGMS_Snd_ReadData(song_parse, t_pcmpos, t_length, buffer_get_address(parsebuffer));


		if (t_result < 0)
		{
			log("Failure when analyzing audio: "+FMODGMS_Util_GetErrorMessage())
			//show_message_new("Failure when analyzing audio: "+FMODGMS_Util_GetErrorMessage());
			FMODGMS_Snd_Unload(song_parse);
			song_parse = -1;
			buffer_delete(parsebuffer);
			buffer_delete(bufferIn);
			buffer_delete(bufferOut);
			parsebuffer = -1;
			bufferIn = -1;
			bufferOut = -1;
			func_doaudio = 0;
		}
		else
		{
			for (var t_i = 0; t_i < t_numPoints; t_i++)
				buffer_write(bufferIn, buffer_f32, buffer_peek(parsebuffer, t_i*t_multiplier, buffer_s16));
	
			t_w = FMODGMS_Util_FFT(buffer_get_address(bufferIn), buffer_get_address(bufferOut), t_numPoints, 1);
		}
		
	}	
	else
		func_doaudio = 0;
}

if (placing == "func")
{
	ML_VM_SetVarReal(parser_shape,"startx",startposx_r*128);
	ML_VM_SetVarReal(parser_shape,"starty",startposy_r*128);
	ML_VM_SetVarReal(parser_shape,"endx",endx_r*128);
	ML_VM_SetVarReal(parser_shape,"endy",endy_r*128);
	ML_VM_SetVarReal(parser_shape,"frame",t);
	ML_VM_SetVarReal(parser_shape,"audio_loudness", t_w/6000);
}

if (colormode == "func") or (blankmode == "func")
{
    ML_VM_SetVarReal(parser_cb,"startx",startposx_r*128);
    ML_VM_SetVarReal(parser_cb,"starty",startposy_r*128);
    ML_VM_SetVarReal(parser_cb,"endx",endx_r*128);
    ML_VM_SetVarReal(parser_cb,"endy",endy_r*128);
    ML_VM_SetVarReal(parser_cb,"frame",t);
    ML_VM_SetVarReal(parser_cb,"anchorx",anchorx);
    ML_VM_SetVarReal(parser_cb,"anchory",anchory);
    ML_VM_SetVarReal(parser_cb,"pri_red",colour_get_red(color1_r));
    ML_VM_SetVarReal(parser_cb,"pri_green",colour_get_green(color1_r));
    ML_VM_SetVarReal(parser_cb,"pri_blue",colour_get_blue(color1_r));
    ML_VM_SetVarReal(parser_cb,"sec_red",colour_get_red(color2_r));
    ML_VM_SetVarReal(parser_cb,"sec_green",colour_get_green(color2_r));
    ML_VM_SetVarReal(parser_cb,"sec_blue",colour_get_blue(color2_r));
	ML_VM_SetVarReal(parser_shape,"audio_loudness", t_w/6000);
}