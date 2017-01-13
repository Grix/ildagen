if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, the timeline mode is not available in the web version");
    exit;
}
    
ilda_cancel();
frame = 0;
framehr = 0;
if (seqcontrol.song)
    FMODInstanceSetPaused(seqcontrol.songinstance,1);
    
room_goto(rm_seq);
