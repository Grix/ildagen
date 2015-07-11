if (os_browser != browser_not_a_browser)
    {
    show_message_async("Sorry, this feature is not available in the web version yet");
    exit;
    }

with (seqcontrol)
    load_frames_seq(get_open_filename_ext("LasershowGen frames|*.igf","","","Select LasershowGen frames file"));