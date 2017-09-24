/// @description Built in variables, do not change
x_offset = 0;
y_offset = 0;

item_height = font_get_size(font)+item_padding*2;

//calculate offsets to keep box on screen
total_height = item_height*num;


if(x < __view_get( e__VW.XView, 0 ))
{
    x_offset = __view_get( e__VW.XView, 0 )-x+1;
}
else if(x + total_width > __view_get( e__VW.XView, 0 )+__view_get( e__VW.WPort, 0 ))
{
    x_offset = (__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 ))-(x+total_width)+1;
}

if(y < __view_get( e__VW.YView, 0 ))
{
    y_offset = __view_get( e__VW.YView, 0 )-y+1;
}
else if(y + total_height > __view_get( e__VW.YView, 0 )+__view_get( e__VW.HPort, 0 ))
{
    y_offset = -total_height;
}

x1 = x+x_offset;
x2 = x+total_width+x_offset;
ty1 = y+y_offset;
ty2 = y+total_height+y_offset;

alarm[0] = 2;

