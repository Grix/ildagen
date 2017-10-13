if (instance_exists(obj_dropdown))
    exit;

if (mouse_x < (x+14))
{
    {
    if (mouse_y < (redy_upper+12))
        ilda_dialog_num("red_scale","Enter value for RED UPPER from 0 to 100",controller.red_scale * 100);
    else
        ilda_dialog_num("red_scale_lower","Enter value for RED LOWER from 0 to 100",controller.red_scale_lower * 100);
    }
}
else if (mouse_x > (x+30))
{
    {
    if (mouse_y < (bluey_upper+12))
        ilda_dialog_num("blue_scale","Enter value for BLUE UPPER from 0 to 100",controller.blue_scale * 100);
    else
        ilda_dialog_num("blue_scale_lower","Enter value for BLUE LOWER from 0 to 100",controller.blue_scale_lower * 100);
    }
}
else 
{
    {
    if (mouse_y < (greeny_upper+12))
        ilda_dialog_num("green_scale","Enter value for GREEN UPPER from 0 to 100",controller.green_scale * 100);
    else
        ilda_dialog_num("green_scale_lower","Enter value for GREEN LOWER from 0 to 100",controller.green_scale_lower * 100);
    }
}

