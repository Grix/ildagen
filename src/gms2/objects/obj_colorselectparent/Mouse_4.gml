if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

if (mouse_y < bbox_bottom-36)
{
    if (mouse_x < (x+14))
        moving = 1;
    else if (mouse_x > (x+30))
        moving = 3;
    else moving = 2;
}
else
    moving = 4;

mouse_yprevious = mouse_y;

