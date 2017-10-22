if (view_current != 0)
	exit;

if (controller.anienable == 1) 
	image_index = 1;
else 
	image_index = 0;

draw_self();

draw_set_halign(fa_center);
draw_text(x+8,y+20,"Enabled");
draw_set_halign(fa_left);
