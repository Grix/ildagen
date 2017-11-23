if (view_current != 0)
	exit;

if (seqcontrol.loop == true) 
    image_index = 1;
else 
    image_index = 0;

draw_self();

draw_text(x+22,y+2,"Loop");

