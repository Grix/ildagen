if (instance_exists(obj_dropdown) || !_visible)
    exit;

if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version");
    exit;
}

with (controller)
{
    if (seqcontrol.selectedlayer == -1)
    {
        show_message_new("Please select a position on the sequencer timeline first.");
        exit;
    }    
    
	if (room = rm_ilda || room == rm_seq)
	{
	    if (ds_list_size(seqcontrol.somaster_list) == 1)
	    {
	        if (!controller.warning_disable)
				ilda_dialog_yesno("toseqreplace","This will replace the selected timeline object with these frames. Continue? (Cannot be undone)");
			else
				frames_toseq();
		}
	    else
	        frames_toseq();
	}
	else if (room == rm_live)
	{
		if (livecontrol.selectedfile != -1)
		{
			if (ds_list_size(seqcontrol.somaster_list) == 1)
			{
				if (!controller.warning_disable)
					live_dialog_yesno("toseqreplace","This will replace the selected timeline object with these frames. Continue? (Cannot be undone)");
				else
					frames_toseq_live();
			}
			else
			    frames_toseq_live();
		}
	}
}

