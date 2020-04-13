/// @description Built in variables, do not change
x_offset = 0;
y_offset = 0;

item_height = font_get_size(font)+item_padding*2;

//calculate offsets to keep box on screen
total_height = round(item_height*num);

for (var t_i = 0; t_i < ds_list_size(desc_list); t_i++)
{
	if (string_width(desc_list[| t_i])*controller.dpi_multiplier+item_padding+20 > total_width)
	{
		total_width = string_width(desc_list[| t_i])*controller.dpi_multiplier+item_padding+20;
	}
}


if(x < 0)
{
    x_offset = round(0-x+1);
}
else if(x + total_width > window_get_width())
{
    x_offset = round(window_get_width()-(x+total_width)+1);
}

if(y < 0)
{
    y_offset = round(0-y+1);
}
else if(y + total_height > window_get_height())
{
    y_offset = round(window_get_height()-(y+total_height)+1);
}

x1 = x+x_offset;
x2 = x+total_width+x_offset;
ty1 = y+y_offset;
ty2 = y+total_height+y_offset;

alarm[0] = 2;

