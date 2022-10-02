function create_text_init() {
	//get and check data
	if (ds_list_empty(font_list))
	{
	    show_message_new("Please import a LaserBoy font file first. You can find these files in the subfolder 'ild\fonts\' in the LaserBoy_Current zip file included in the LaserShowGen installation folder or downloaded from LaserBoy.org.");
	    import_font();
	}
	else
	    ilda_dialog_string("text","Enter text","");



}
