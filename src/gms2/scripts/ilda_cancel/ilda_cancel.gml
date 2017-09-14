with (controller)
{
    playing = 0;
    if (seqcontrol.song)
    {
        FMODInstanceSetPaused(seqcontrol.songinstance,1);
    }
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
}
