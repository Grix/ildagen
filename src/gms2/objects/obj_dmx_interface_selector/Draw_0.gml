if (highlight)
{
    draw_set_color(c_gray);
    draw_set_alpha(0.2);
    draw_rectangle(x+100,y,x+250,y+22,0);
	draw_set_alpha(1);
	draw_set_color(c_black);
}

if (string_length(chosen_interface) > 0)
	text = chosen_interface;
else
	text = "[Default]";

draw_rectangle(x+100,y,x+250,y+22,1);
draw_text(x+10,y+5,"Net interface:        "+text);

