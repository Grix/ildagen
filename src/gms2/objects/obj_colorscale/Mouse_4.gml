if (instance_exists(obj_dropdown))
    exit;

if (mouse_x < (x+14))
{
	if ((1 - (mouse_y-bbox_top)/52) > (controller.red_scale+controller.red_scale_lower)/2)
        moving = 1;   
    else
        moving = 4;
}
else if (mouse_x > (x+30))
{
    if ((1 - (mouse_y-bbox_top)/52) > (controller.blue_scale+controller.blue_scale_lower)/2)
        moving = 3;   
    else
        moving = 6;
}
else 
{
    if ((1 - (mouse_y-bbox_top)/52) > (controller.green_scale+controller.green_scale_lower)/2)
        moving = 2;   
    else
        moving = 5;
}

mouse_yprevious = mouse_y;

