if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

with (seqcontrol)
    {
    seq_dialog_yesno("fromseq","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
    }

