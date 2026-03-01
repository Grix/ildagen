if (view_current != 0)
    exit;

draw_self();

if (!livecontrol.mastery_dmx_disable)
	draw_sprite_ext(spr_knob,(moving > 0),x+clamp(livecontrol.mastery+$8000,0,$ffff)/$ffff*72,y+16, 1, 1, 0, c_orange, 1);
else
	draw_sprite(spr_knob,(moving > 0),x+clamp(livecontrol.mastery+$8000,0,$ffff)/$ffff*72,y+16);

draw_text(x+80,y+9,"Y offset");

if (livecontrol.mastery_midi_shortcut == -1)
{
	draw_set_font(fnt_small);
	draw_set_color(c_maroon);
	draw_text(x+5, y-5, "Turn a MIDI slider/knob...");
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}
else if (livecontrol.mastery_midi_shortcut >= 0)
{
	draw_set_font(fnt_small);
	draw_set_color(c_green);
	draw_text(x+5, y-5, "MIDI CC: "+string(livecontrol.mastery_midi_shortcut));
	draw_set_color(c_black);
	draw_set_font(fnt_tooltip);
}
