if (highlight)
{
    draw_set_color(c_gray);
    draw_set_alpha(0.2);
    draw_rectangle(x+45,y,x+210,y+22,0);
	draw_set_alpha(1);
	draw_set_color(c_black);
}

if (controller.preview_testframe == 0)
    text = "Test frame";
else if (controller.preview_testframe == 1)
    text = "Frame from Timeline Mode";
else if (controller.preview_testframe == 2)
    text = "Frame from Editor Mode";

draw_rectangle(x+45,y,x+210,y+22,1);
draw_text(x+10,y+5,"Use:      "+text);

