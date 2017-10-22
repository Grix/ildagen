if (instance_exists(obj_dropdown))
    exit;
_visible = (controller.maxframes > 1);
if (!_visible)
	exit;

if (controller.onion)
{
    image_index = 2;
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
        controller.tooltip = "Turn off onion skinning (Superimposing previous frames on top)\nRight-click for settings.";
    }
}
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
	image_index = 1;
    controller.tooltip = "Turn on onion skinning (Superimposing previous frames on top)\nRight-click for settings.";
} 
else image_index = 0;

