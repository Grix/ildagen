if (instance_exists(obj_dropdown))
    exit;
if (!_visible) 
	exit;

if (room == rm_seq)
{
	with (seqcontrol)
	{
		if (!controller.warning_disable)
			seq_dialog_yesno("fromseq","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
		else
			with (seqcontrol)
				frames_fromseq();
	}
}
else if (room == rm_live)
{
	with (livecontrol)
	{
		if (!controller.warning_disable)
			live_dialog_yesno("fromlive","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
		else
			with (livecontrol)
				frames_fromlive();
	}
}

