if (controller.exp_optimize == 1) 
	image_index = 1;
else 
	image_index = 0;

draw_self();

draw_set_halign(fa_center);
draw_text(x+8,y+20,"Enable optimization");
draw_set_halign(fa_left);
