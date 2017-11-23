if (highlight)
{
    draw_set_color(c_gray);
    draw_set_alpha(0.2);
    draw_rectangle(x+45,y,x+220,y+22,0);
	draw_set_alpha(1);
}

draw_rectangle(x+45,y,x+220,y+22,1);
draw_text(x+10,y+5,"Use:      "+text);

