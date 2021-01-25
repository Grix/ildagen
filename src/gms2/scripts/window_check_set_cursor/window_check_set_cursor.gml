// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function window_check_set_cursor(t_cursor){
	var t_currentcursor = window_get_cursor();
	if (t_currentcursor != t_cursor)
	{
		log("set cursor", t_currentcursor, t_cursor);
		window_set_cursor(t_cursor);
	}
}