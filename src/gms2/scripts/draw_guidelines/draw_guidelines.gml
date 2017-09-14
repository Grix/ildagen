draw_set_color(c_gray);
for (i = 0; i < ds_list_size(el_list);i++)
    {
    listtemp = ds_list_find_value(el_list,i);
    draw_line(ds_list_find_value(listtemp,0)/128,0,ds_list_find_value(listtemp,0)/128,512);
    draw_line(ds_list_find_value(listtemp,2)/128,0,ds_list_find_value(listtemp,2)/128,512);
    draw_line(0,ds_list_find_value(listtemp,1)/128,512,ds_list_find_value(listtemp,1)/128);
    draw_line(0,ds_list_find_value(listtemp,3)/128,512,ds_list_find_value(listtemp,3)/128);
    }
draw_set_color(make_colour_rgb(100,20,20));
for (i = 0; i < ds_list_size(el_list);i++)
    {
    listtemp = ds_list_find_value(el_list,i);
    draw_line(512-ds_list_find_value(listtemp,0)/128,0,512-ds_list_find_value(listtemp,0)/128,512);
    draw_line(512-ds_list_find_value(listtemp,2)/128,0,512-ds_list_find_value(listtemp,2)/128,512);
    draw_line(0,512-ds_list_find_value(listtemp,1)/128,512,512-ds_list_find_value(listtemp,1)/128);
    draw_line(0,512-ds_list_find_value(listtemp,3)/128,512,512-ds_list_find_value(listtemp,3)/128);
    }
draw_set_color(make_colour_rgb(20,100,20));
    draw_line(0,512/2,512,512/2);
    draw_line(512/2,0,512/2,512);
