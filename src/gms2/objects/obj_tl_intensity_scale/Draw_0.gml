if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+floor(clamp(seqcontrol.intensity_scale,0,1)*128),y+16);

draw_text(x+150,y+9,"Intensity: "+string(round(seqcontrol.intensity_scale*100)) + "%");

if (seqcontrol.intensity_scale_midi_shortcut == -1)
{
	draw_set_font(fnt_small);
	draw_set_color(c_maroon);
	draw_text(x+5, y-5, "Turn a MIDI slider/knob...");
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}
else if (seqcontrol.intensity_scale_midi_shortcut > 0)
{
	draw_set_font(fnt_small);
	draw_set_color(c_green);
	draw_text(x+5, y-5, "MIDI CC: "+string(seqcontrol.intensity_scale_midi_shortcut));
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}