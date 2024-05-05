if (view_current != 0)
	exit;

draw_self();
draw_set_color(c_black);
draw_text(x+60,y+3,"Frequency: "+string(controller.color_freq));



