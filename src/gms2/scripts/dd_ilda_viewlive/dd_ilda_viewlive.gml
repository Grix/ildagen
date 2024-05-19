function dd_ilda_viewlive() 
{
	if (room == rm_live)
		exit;
	
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, the grid view is not available in the web version");
	    exit;
	}
    
	ilda_cancel();
    
	room_goto(rm_live);

}
