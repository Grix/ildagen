if (highlight)
{
    draw_set_color(c_gray);
    draw_set_alpha(0.2);
    draw_rectangle(x+90,y,x+350,y+22,0);
	draw_set_alpha(1);
	draw_set_color(c_black);
}

if (controller.has_midi)
	text = rtmidi_name_in(controller.midi_input_device);
else
	text = "[No device found]";

draw_rectangle(x+90,y,x+350,y+22,1);
draw_text(x+10,y+5,"MIDI Input:         "+text);

