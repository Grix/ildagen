/// @description log(str)
/// @function log
/// @param str

//var t_file = file_text_open_append(controller.FStemp+"logs.txt");
//file_text_writeln(t_file);
//file_text_write_string(t_file, string(argument0));
//file_text_close(t_file);

gml_pragma("forceinline");

var output_string = "";

for (var i = 0; i < argument_count; i++) {
    output_string += string(argument[i]) + "  ";
}

show_debug_message(output_string);
