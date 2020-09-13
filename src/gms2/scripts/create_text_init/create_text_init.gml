function create_text_init() {
	//get and check data
	if (ds_list_empty(font_list))
	{
	    show_message_new("Please import a LaserBoy font file first");
	    import_font();
	}
	else
	    ilda_dialog_string("text","Enter text","");



}
