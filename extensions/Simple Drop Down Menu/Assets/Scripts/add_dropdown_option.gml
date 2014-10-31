//add_dropdown_option(array_position, main icon, option text, action icon, add optional separator)

//Adds an option to the drop down box

var option_num = argument0;
var icon = argument1;
var text = argument2;
var action_icon = argument3;
var add_separator = argument4;

if(option_num < 0) return noone;

icons[option_num] = icon;
option_text[option_num] = text;
action_icons[option_num] = action_icon;
draw_separator[option_num] = add_separator;