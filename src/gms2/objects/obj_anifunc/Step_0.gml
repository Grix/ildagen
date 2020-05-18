if (instance_exists(obj_dropdown))
    exit;
_visible = controller.anienable;
if (!_visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the shape of the animation function (transition over time) to ";
	switch (floor( (mouse_x-x)/29.375))
	{
	    case 0: controller.tooltip += "linear"; break;
	    case 1: controller.tooltip += "triangle wave"; break;
	    case 2: controller.tooltip += "ease out (quadratic)"; break;
	    case 3: controller.tooltip += "ease in (quadratic)"; break;
	    case 4: controller.tooltip += "ease in/out (quadratic)"; break;
		case 5: controller.tooltip += "cosine wave"; break;
	    case 6: controller.tooltip += "sine wave"; break;
	    case 7: controller.tooltip += "bounce (cubic)"; break;  
	}
}

