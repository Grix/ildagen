if (room != rm_ilda) exit;
frame = 0;
framehr = 0;
frame_surf_refresh = 1;


ds_list_clear(semaster_list);
update_semasterlist_flag = 1;

if (seqcontrol.song != -1)
    FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);

