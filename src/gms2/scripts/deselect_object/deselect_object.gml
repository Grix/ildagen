function deselect_object() {
	with (controller)
	{
		ds_list_clear(semaster_list);
		update_semasterlist_flag = 1;
	}



}
