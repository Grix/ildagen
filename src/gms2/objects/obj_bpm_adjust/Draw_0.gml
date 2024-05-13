draw_self();

if (controller.use_bpm)
	draw_text(x+55,y+3,"Adjusted BPM: "+string(livecontrol.bpm_adjusted)+"/"+string(controller.bpm));
else
	draw_text(x+55,y+3,"Adjusted speed: "+string(livecontrol.speed_adjusted*100)+" %");

if (livecontrol.speed_adjusted_midi_shortcut == -1)
{
	draw_set_font(fnt_small);
	draw_set_color(c_maroon);
	draw_text(x+5, y-12, "Turn a MIDI slider/knob...");
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}
else if (livecontrol.speed_adjusted_midi_shortcut >= 0)
{
	draw_set_font(fnt_small);
	draw_set_color(c_green);
	draw_text(x+5, y-12, "MIDI CC: "+string(livecontrol.speed_adjusted_midi_shortcut));
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}
