if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+clamp(livecontrol.masterhue,0,255)/255*72,y+16);

draw_text(x+80,y+9,"Hue");

if (livecontrol.masterhue_midi_shortcut == -1)
{
	draw_set_font(fnt_small);
	draw_set_color(c_maroon);
	draw_text(x+5, y-5, "Turn a MIDI slider/knob...");
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}
else if (livecontrol.masterhue_midi_shortcut >= 0)
{
	draw_set_font(fnt_small);
	draw_set_color(c_green);
	draw_text(x+5, y-5, "MIDI CC: "+string(livecontrol.masterhue_midi_shortcut));
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}
