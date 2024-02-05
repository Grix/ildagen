// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_select_midi_input(){
	controller.midi_input_device = argument[0];
	rtmidi_set_inport(argument[0]);
	controller.has_midi = true;
}