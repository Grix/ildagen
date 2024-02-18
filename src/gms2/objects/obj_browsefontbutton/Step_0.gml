visible = controller.placing == "text";
if (!visible)
    exit;
if (instance_exists(obj_dropdown))
    exit;

mouse_over = false;

if (mouse_x > x) and (mouse_x < x+width) and (mouse_y > y) and (mouse_y < y+height)
{
	mouse_over = true;
    controller.tooltip = "Browse for a custom LaserBoy font file.";
} 