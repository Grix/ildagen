/// @description Insert description here
// You can write your code in this editor

draw_self();

if (controller.laseron_midi_trigger == -1)
{
	draw_set_color($116666);
	draw_text(x, y-16, "Press MIDI key..");
	draw_set_color(c_black);
}
else if (controller.laseron_midi_trigger > 0)
{
	draw_set_color(c_aqua);
	draw_text(x, y-16, string(controller.laseron_midi_trigger >> 8) + midi_get_note_name(controller.laseron_midi_trigger & $FF));
	draw_set_color(c_black);
}












