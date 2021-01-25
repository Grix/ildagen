if (view_current != 0)
	exit;
	
if (!_visible)
    exit;

if (controller.anireverse == 1) 
	image_index = 1;
else 
	image_index = 0;

draw_self();

draw_text(x-55,y+0,"Reverse");
