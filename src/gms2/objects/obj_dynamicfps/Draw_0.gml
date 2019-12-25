if (controller.enable_dynamic_fps == 1) 
	image_index = 1;
else 
	image_index = 0;

draw_self();

draw_text(x+22,y+2,"Enable dynamic FPS");
