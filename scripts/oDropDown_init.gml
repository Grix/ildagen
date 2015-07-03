///Built in variables, do not change
x_offset = 0;
y_offset = 0;

item_height = font_get_size(font)+item_padding*2;

//calculate offsets to keep box on screen
total_height = item_height*num;


if(x < view_xview)
{
    x_offset = view_xview-x+1;
}
else if(x + total_width > view_xview+view_wport)
{
    x_offset = (view_xview+view_wview)-(x+total_width)+1;
}

if(y < view_yview)
{
    y_offset = view_yview-y+1;
}
else if(y + total_height > view_yview+view_hport)
{
    y_offset = -total_height;
}

x1 = x+x_offset;
x2 = x+total_width+x_offset;
ty1 = y+y_offset;
ty2 = y+total_height+y_offset;

instance_deactivate_region(x1,ty1,total_width,total_height,1,1);
instance_activate_object(controller);
instance_activate_object(obj_cursor);

alarm[0] = 2;
