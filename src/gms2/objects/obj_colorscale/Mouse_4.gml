if (instance_exists(oDropDown))
    exit;

if (mouse_x < (x+14))
{
    if (mouse_y < (redy_upper+12))
        moving = 1;   
    else
        moving = 4;
}
else if (mouse_x > (x+30))
{
    if (mouse_y < (bluey_upper+12))
        moving = 3;   
    else
        moving = 6;
}
else 
{
    if (mouse_y < (greeny_upper+12))
        moving = 2;   
    else
        moving = 5;
}

mouse_yprevious = mouse_y;

