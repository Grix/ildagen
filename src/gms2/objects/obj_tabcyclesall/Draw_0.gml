if (controller.tab_cycles_all == 0) 
	image_index = 1;
else 
	image_index = 0;

draw_self();

draw_set_halign(fa_right);
draw_text(x-8,y+2,"Tab key remembers last mode");
draw_set_halign(fa_left);
