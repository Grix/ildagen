if (song != 0) 
	FMODGMS_Snd_Unload(song);
songfile = get_open_filename_ext("","","","Select audio file");
if !string_length(songfile) 
{
    log("cancel");
    exit;
}
song_buffer = buffer_load(songfile);
var t_exInfo = buffer_create(34*8, buffer_fixed, 8);
buffer_fill(t_exInfo, 0, buffer_u64, 0, buffer_get_size(t_exInfo));
buffer_poke(t_exInfo, 0, buffer_u32, buffer_get_size(song_buffer));
song = FMODGMS_Snd_LoadSound_Ext(buffer_get_address(song_buffer),	FMODGMS_MODE_DEFAULT | 
																	FMODGMS_MODE_OPENMEMORY_POINT | 
																	FMODGMS_MODE_ACCURATETIME |
																	FMODGMS_MODE_CREATECOMPRESSEDSAMPLE, 
																	buffer_get_address(t_exInfo));
buffer_delete(t_exInfo);
if (song == -1)
{
    show_message_new("Failed to load audio: "+FMODGMS_Util_GetErrorMessage());
    exit;
}
songfile_name = FMODGMS_Snd_Get_TagStringFromName(song, "TITLE");
if (songfile_name == "Tag not found.")
	songfile_name = filename_name(songfile);
/*if (!song and (FMODGetLastError() == 25))
{
    temprandomstring = string(irandom(1000000));
    buffer_save(song_buffer,"temp/tempaudio"+temprandomstring+filename_ext(songfile));
    song = FMODGMS_Snd_LoadStream(controller.FStemp+"tempaudio"+temprandomstring+filename_ext(songfile));
}*/

ds_list_clear(audio_list);
FMODGMS_Snd_PlaySound(song, parse_sndchannel);
FMODGMS_Chan_ResumeChannel(parse_sndchannel);
FMODGMS_Chan_Set_Position(parse_sndchannel, 0);
song_samplerate = FMODGMS_Chan_Get_Frequency(parse_sndchannel);
songlength = FMODGMS_Util_SamplesToSeconds(FMODGMS_Snd_Get_Length(song), song_samplerate);
if (length < songlength*projectfps)
{
    length = ceil(songlength*projectfps);
    endframe = length;
}
parsingaudio = 1;
deltatime = 0;    
playing = 0;
tlpos = 0;

apply_audio_settings();
