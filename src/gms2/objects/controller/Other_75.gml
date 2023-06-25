// File dropping

if (!ds_exists(async_load, ds_type_map))
	exit;

if (async_load[? "event_type"] == "file_drop")
{
	var t_filename = async_load[? "filename"];
	if (file_exists(t_filename))
	{
		if (room == rm_ilda)
		{
			if (string_lower(filename_ext(t_filename)) == ".igf")
			{
				if (!controller.warning_disable)
				{
					known_filename_of_load = t_filename;
					ilda_dialog_yesno("loadfile_known_filename","Loading this file will replace your current frames, all unsaved work will be lost. Continue? (Cannot be undone)");
				}
				else
					load_frames(t_filename);
			}
			else if (string_lower(filename_ext(t_filename)) == ".ild")
			{
				import_ilda(t_filename);
			}
		}
		else if (room == rm_seq)
		{
			if (string_lower(filename_ext(t_filename)) == ".igf")
			{
				with (seqcontrol)
					load_frames_seq(t_filename);
			}
			else if (string_lower(filename_ext(t_filename)) == ".ild")
			{
				import_ildaseq(t_filename);
			}
			else if (string_lower(filename_ext(t_filename)) == ".igp")
			{
				if (!controller.warning_disable)
				{
					known_filename_of_load = t_filename;
					seq_dialog_yesno("loadproject_known_filename","Loading this file will replace your current project, all unsaved work will be lost. Continue? (Cannot be undone)");
				}
				else
					with (seqcontrol)
						load_project(t_filename);
			}
		}
		else if (room == rm_live)
		{
			if (string_lower(filename_ext(t_filename)) == ".igf")
			{
				with (livecontrol)
					load_frames_live(t_filename);
			}
			else if (string_lower(filename_ext(t_filename)) == ".ild")
			{
				import_ildalive(t_filename);
			}
			else if (string_lower(filename_ext(t_filename)) == ".igl")
			{
				if (!controller.warning_disable)
				{
					known_filename_of_load = t_filename;
					live_dialog_yesno("loadliveproject_known_filename","Loading this file will replace all tiles in your current grid, all unsaved work will be lost. Continue? (Cannot be undone)");
				}
				else
					with (livecontrol)
						load_live_project(t_filename);
			}
		}
	}
}