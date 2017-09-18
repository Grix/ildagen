
if (!verify_serial(true))
    exit;

if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, the timeline mode is not available in the web version yet");
    exit;
}

with (controller)
{
    if (seqcontrol.selectedlayer == -1)
    {
        show_message_new("Please select a position on the sequencer timeline first.");
        exit;
    }    
    
    if (ds_list_size(seqcontrol.somaster_list) == 1)
    {
        ilda_dialog_yesno("toseqreplace","This will replace the selected timeline object with these frames. Continue? (Cannot be undone)");
    }
    else
        frames_toseq();
}

