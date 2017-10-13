if (!rdy) exit;

///Find Selected
var mx = device_mouse_x(0);
var my = device_mouse_y(0);

if(point_in_rectangle(mx, my, x1,ty1,x2,ty2))
{
    selected =  floor((my-ty1)/item_height);
}
else
{
    selected = noone;
}

