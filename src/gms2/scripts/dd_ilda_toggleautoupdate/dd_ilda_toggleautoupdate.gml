function dd_ilda_toggleautoupdate() {
	if (os_browser != browser_not_a_browser) exit;

	controller.ini_filename = "settings.ini";

	ini_open(controller.ini_filename);
	controller.updatecheckenabled = !ini_read_real("main","updatecheck",0);
	ini_write_real("main","updatecheck",controller.updatecheckenabled);
	ini_close();



}
