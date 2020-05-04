if (instance_exists(obj_dropdown))
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Changes the length (total number of frames) of the animation. Will stretch the animation to fit the new length. \nRight click if you instead want to keep the current animation speed and pad with empty frames.";
}
else 
	image_index = 0; 