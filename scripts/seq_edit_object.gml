//send object to frames editor
with (seqcontrol)
    {
    getint = show_question_async("This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
    dialog = "fromseq";
    }
