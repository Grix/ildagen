if (song != -1) 
{
    FMODGMS_Snd_Unload(song);
    buffer_delete(song_buffer);
}
song = -1;
ds_list_clear(audio_list);
parsingaudio = 0;
