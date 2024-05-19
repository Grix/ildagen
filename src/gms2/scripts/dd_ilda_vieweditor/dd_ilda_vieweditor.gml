function dd_ilda_vieweditor() 
{
	if (room == rm_ilda)
		exit;
	
	with (seqcontrol)
	{
	    if (song != -1) 
	        FMODGMS_Chan_PauseChannel(play_sndchannel);
	    playing = 0;
	}
	
	room_goto(rm_ilda);


}
