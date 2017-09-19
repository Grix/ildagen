if (song != 0) 
	FMODGMS_Snd_Unload(song);
songfile_loc = get_open_filename_ext("","","","Select audio file");
if !string_length(songfile_loc) 
{
    log("cancel");
    exit;
}
songfile = songfile_loc;
song_buffer = buffer_load(songfile_loc);
songfile_name = filename_name(songfile);
song = FMODGMS_Snd_LoadStream(songfile_name);
/*if (!song and (FMODGetLastError() == 25))
{
    temprandomstring = string(irandom(1000000));
    buffer_save(song_buffer,"temp/tempaudio"+temprandomstring+filename_ext(songfile));
    song = FMODGMS_Snd_LoadStream(controller.FStemp+"tempaudio"+temprandomstring+filename_ext(songfile));
}*/
if (!song)
{
    show_message_new("Failed to load audio: "+FMODGMS_Util_GetErrorMessage());
    exit;
}
songlength = FMODGMS_Snd_Get_Length(song);
if (length < songlength/1000*projectfps)
{
    length = songlength/1000*projectfps;
    endframe = length;
}

ds_list_clear(audio_list);
parseinstance = FMODGMS_Snd_PlaySound(song, parse_sndchannel);
parsingaudio = 1;
deltatime = 0;    
playing = 0;
tlpos = 0;

set_audio_speed();
