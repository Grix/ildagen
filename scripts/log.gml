///log(str)
show_debug_message(argument0);
var t_file = file_text_open_append(controller.FStemp+"logs.txt");
file_text_writeln(t_file);
file_text_write_string(t_file, string(argument0));
file_text_close(t_file);
