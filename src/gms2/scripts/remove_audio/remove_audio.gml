songinstance = 0;
if (song) 
{
    FMODGMS_Snd_Unload(song);
    buffer_delete(song_buffer);
}
song = 0;
songfile_loc = "";
songfile = songfile_loc;
ds_list_clear(audio_list);
parsingaudio = 0;
