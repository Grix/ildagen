// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_ilda_loadseq(){

	if (os_browser != browser_not_a_browser)
    {
        show_message_new("Sorry, the timeline is not available in the web version yet");
        exit;
    }
    ilda_cancel();
    frame = 0;
    framehr = 0;
    if (seqcontrol.song != -1)
        FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
		
	seqcontrol.loadprojectflag = true;
}