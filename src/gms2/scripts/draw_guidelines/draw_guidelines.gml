//todo fix
draw_set_color(c_gray);
for (i = 0; i < ds_list_size(el_list);i++)
{
    listtemp = ds_list_find_value(el_list,i);
    draw_line(ds_list_find_value(listtemp,0)/$ffff*view_wport[4],0,ds_list_find_value(listtemp,0)/$ffff*view_wport[4],view_wport[4]);
    draw_line(ds_list_find_value(listtemp,2)/$ffff*view_wport[4],0,ds_list_find_value(listtemp,2)/$ffff*view_wport[4],view_wport[4]);
    draw_line(0,ds_list_find_value(listtemp,1)/$ffff*view_wport[4],view_wport[4],ds_list_find_value(listtemp,1)/$ffff*view_wport[4]);
    draw_line(0,ds_list_find_value(listtemp,3)/$ffff*view_wport[4],view_wport[4],ds_list_find_value(listtemp,3)/$ffff*view_wport[4]);
}
draw_set_color(make_colour_rgb(100,20,20));
for (i = 0; i < ds_list_size(el_list);i++)
{
    listtemp = ds_list_find_value(el_list,i);
    draw_line(view_wport[4]-ds_list_find_value(listtemp,0)/$ffff*view_wport[4],0,view_wport[4]-ds_list_find_value(listtemp,0)/$ffff*view_wport[4],view_wport[4]);
    draw_line(view_wport[4]-ds_list_find_value(listtemp,2)/$ffff*view_wport[4],0,view_wport[4]-ds_list_find_value(listtemp,2)/$ffff*view_wport[4],view_wport[4]);
    draw_line(0,view_wport[4]-ds_list_find_value(listtemp,1)/$ffff*view_wport[4],view_wport[4],view_wport[4]-ds_list_find_value(listtemp,1)/$ffff*view_wport[4]);
    draw_line(0,view_wport[4]-ds_list_find_value(listtemp,3)/$ffff*view_wport[4],view_wport[4],view_wport[4]-ds_list_find_value(listtemp,3)/$ffff*view_wport[4]);
}
draw_set_color(make_colour_rgb(20,100,20));
draw_line(0,view_wport[4]/2,view_wport[4],view_wport[4]/2);
draw_line(view_wport[4]/2,0,view_wport[4]/2,view_wport[4]);
