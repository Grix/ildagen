if (song != 0) 
{
    FMODGMS_Snd_Unload(song);
    buffer_delete(song_buffer);
}
song = 0;
songfile = "";
ds_list_clear(audio_list);
parsingaudio = 0;
