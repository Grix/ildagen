if (!rdy) exit;

///Find Selected
var mx = window_mouse_get_x();
var my = window_mouse_get_y();

if(point_in_rectangle(mx, my, x1,ty1,x2,ty2))
{
    selected =  floor((my-ty1)/item_height);
}
else
{
    selected = noone;
}

