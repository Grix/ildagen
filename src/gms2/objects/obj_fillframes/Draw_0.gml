if (view_current != 0)
	exit;

if (controller.fillframes == 1) 
	image_index = 0;
else 
	image_index = 1;

if (controller.anienable == 1) or (controller.maxframes == 1)
    draw_set_alpha(0.6);

draw_self();

draw_set_halign(fa_center);
draw_text(x+8,y+20,"Current\nframe only");
draw_set_halign(fa_left);

if (controller.anienable == 1) or (controller.maxframes == 1)
	draw_set_alpha(1);

