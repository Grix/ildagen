/// @description Built in variables, do not change
x_offset = 0;
y_offset = 0;

item_height = font_get_size(font)+item_padding*2;

//calculate offsets to keep box on screen
total_height = item_height*num;


if(x < 0)
{
    x_offset = 0-x+1;
}
else if(x + total_width > camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0]))
{
    x_offset = camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0])-(x+total_width)+1;
}

if(y < 0)
{
    y_offset = 0-y+1;
}
else if(y + total_height > camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0]))
{
    y_offset = camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])-total_height;
}

x1 = x+x_offset;
x2 = x+total_width+x_offset;
ty1 = y+y_offset;
ty2 = y+total_height+y_offset;

alarm[0] = 2;

