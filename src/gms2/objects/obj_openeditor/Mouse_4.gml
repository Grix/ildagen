if (instance_exists(oDropDown))
    exit;
with (seqcontrol)
{
    if (song != 0) 
		FMODGMS_Chan_PauseChannel(play_sndchannel);
    playing = 0;
    room_goto(rm_ilda);
}

