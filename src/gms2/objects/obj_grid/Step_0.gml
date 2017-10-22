if (instance_exists(obj_dropdown))
    exit;
if (controller.sgridshow)
{
	image_index = 2;
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and (mouse_y < bbox_bottom)
    {
        image_index = 3;
        controller.tooltip = "Show radial grid.\n\nKeyboard shortcuts:\nSquare grid: S\nRadial grid: R\nAlignment guidelines: A";
    }
}
else if (controller.rgridshow)
{
    image_index = 4;
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and (mouse_y < bbox_bottom)
    {
        image_index = 5;
		controller.tooltip = "Show alignment guidelines.\n\nKeyboard shortcuts:\nSquare grid: S\nRadial grid: R\nAlignment guidelines: A";
    }
} 
else if (controller.guidelineshow)
{
    image_index = 6;
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and (mouse_y < bbox_bottom)
    {
        image_index = 7;
        controller.tooltip = "Turn off grids.\n\nKeyboard shortcuts:\nSquare grid: S\nRadial grid: R\nAlignment guidelines: A";
    }
} 
else
{
    image_index = 0;
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and (mouse_y < bbox_bottom)
    {
        image_index = 1;
        controller.tooltip = "Show square grid.\n\nKeyboard shortcuts:\nSquare grid: S\nRadial grid: R\nAlignment guidelines: A";
    }
} 

