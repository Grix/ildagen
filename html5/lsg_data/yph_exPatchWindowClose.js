
var ex_patch_window_close_message = "Are you sure you want to quit? You may lose any unsaved progress!";

function ex_patch_window_close_capture_js(wcapture) {

	if (wcapture) {
		window.onbeforeunload = function () {
			return ex_patch_window_close_message;
		}
	} else {
		window.onbeforeunload = function () {}	
	}
	
	return 1;
}

function ex_patch_window_close_set_message_js(mmsg)
{
	ex_patch_window_close_message = mmsg;
	return 1;
}
	
