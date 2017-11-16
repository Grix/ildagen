with (controller)
{
    playing = 0;
    if (seqcontrol.song != -1)
	    FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
}