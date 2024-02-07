if (highlight)
{
    draw_set_color(c_gray);
    draw_set_alpha(0.2);
    draw_rectangle(x+90,y,x+300,y+22,0);
	draw_set_alpha(1);
	draw_set_color(c_black);
}

text = controller.selected_font_name;

draw_rectangle(x+90,y,x+300,y+22,1);
draw_text(x+10,y+5,"Font:       "+text);

