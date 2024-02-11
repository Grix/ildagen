function create_text_init() {
	//get and check data
	if (ds_list_empty(font_list))
	{
	    show_message_new("Please choose a font first. Use the dropdown menu to the right, or the browse button to import a custom LaserBoy font file.");
	    //import_font();
	}
	else
	    ilda_dialog_string("text","Enter text","");

}
