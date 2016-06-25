#define ex_patch_window_close_initialize

if (os_browser == browser_not_a_browser) {
	ex_patch_window_close_initialize_n(window_handle());
}

global._ex_patch_window_close_message = "Are you sure you want to quit? You may lose any unsaved progress!";

return 1;


#define ex_patch_window_close_capture

if (os_browser == browser_not_a_browser) {
	ex_patch_window_close_capture_n(argument[0]);
} else {
	ex_patch_window_close_capture_js(argument[0]);
}

return 1;


#define ex_patch_window_close_event

if (os_browser == browser_not_a_browser) {
	return ex_patch_window_close_event_n();
} else {
	return 0;
}


#define ex_patch_window_close_set_message

if (os_browser == browser_not_a_browser) {
	global._ex_patch_window_close_message = argument[0];
} else {
	ex_patch_window_close_set_message_js(argument[0]);
}

#define ex_patch_window_close_get_message

return global._ex_patch_window_close_message;


