if (instance_exists(oDropDown))
    exit;
with (seqcontrol)
{
    if (song) 
		FMODGMS_Chan_PauseChannel(songinstance);
    playing = 0;
    room_goto(rm_ilda);
}

