if (controller.preview_while_laser_on == 1) 
	image_index = 1;
else 
	image_index = 0;

draw_self();

draw_set_halign(fa_right);
draw_text(x-8,y+2,"Preview frame while lasing");
draw_set_halign(fa_left);
