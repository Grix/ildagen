with (livecontrol)
{
	for (i = 1; i <= 9; i++)
	{
		var t_found = false;
		for (j = 0; j < ds_list_size(filelist); j++)
		{
			if (ds_list_find_value(filelist[| j], 3) == ord(string(i)))
			{
				t_found = true;
				break;
			}
		}
		if (!t_found)
			return ord(string(i));
	}
			
	return 0;
}