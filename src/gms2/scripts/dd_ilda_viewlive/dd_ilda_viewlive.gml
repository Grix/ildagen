function dd_ilda_viewlive() {
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, the live mode is not available in the web version");
	    exit;
	}
    
	ilda_cancel();
	frame = 0;
	framehr = 0;
	if (seqcontrol.song != -1)
	    FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
    
	room_goto(rm_live);



}
