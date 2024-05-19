function dd_ilda_viewtimeline() 
{
	if (room == rm_seq)
		exit;
	
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, the timeline mode is not available in the web version");
	    exit;
	}
    
	ilda_cancel();
    
	room_goto(rm_seq);


}
