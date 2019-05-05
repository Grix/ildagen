if (instance_exists(obj_dropdown))
    exit;
if (!_visible) 
	exit;

if (room == rm_seq)
{
	with (seqcontrol)
	{
	    seq_dialog_yesno("fromseq","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
	}
}
else if (room == rm_live)
{
	with (livecontrol)
	{
	    live_dialog_yesno("fromlive","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
	}
}

