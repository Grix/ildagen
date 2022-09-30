function dac_rename_dd() {
	if (ds_list_find_value(controller.dac_list[| settingscontrol.dactoselect], 3) == -1)
	{
	    show_message_new("This DAC model does not support renaming");
	    return 0;   
	}

	ilda_dialog_string("dacname_dd","Enter new name (Max 30 characters): ", "Helios");




}
