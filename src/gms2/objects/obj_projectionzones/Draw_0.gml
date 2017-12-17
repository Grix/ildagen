draw_self();
draw_set_colour(c_aqua);
draw_set_alpha(0.15);
draw_primitive_begin(pr_trianglestrip);
draw_vertex(x+controller.scale_left_top/$FFFF*256+1, y+controller.scale_top_left/$FFFF*256+1);
draw_vertex(x+controller.scale_right_top/$FFFF*256-1, y+controller.scale_top_right/$FFFF*256+1);
draw_vertex(x+controller.scale_left_bottom/$FFFF*256+1, y+controller.scale_bottom_left/$FFFF*256-1);
draw_vertex(x+controller.scale_right_bottom/$FFFF*256-1, y+controller.scale_bottom_right/$FFFF*256-1);
draw_primitive_end();
draw_set_alpha(1);
draw_primitive_begin(pr_linestrip);
draw_vertex(x+controller.scale_left_top/$FFFF*256+1, y+controller.scale_top_left/$FFFF*256+1);
draw_vertex(x+controller.scale_right_top/$FFFF*256-1, y+controller.scale_top_right/$FFFF*256+1);
draw_vertex(x+controller.scale_right_bottom/$FFFF*256-1, y+controller.scale_bottom_right/$FFFF*256-1);
draw_vertex(x+controller.scale_left_bottom/$FFFF*256+1, y+controller.scale_bottom_left/$FFFF*256-1);
draw_vertex(x+controller.scale_left_top/$FFFF*256+1, y+controller.scale_top_left/$FFFF*256+1);
draw_primitive_end();
draw_primitive_begin(pr_linestrip);
draw_vertex(x+controller.scale_left_top/$FFFF*256, y+controller.scale_top_left/$FFFF*256);
draw_vertex(x+controller.scale_right_top/$FFFF*256, y+controller.scale_top_right/$FFFF*256);
draw_vertex(x+controller.scale_right_bottom/$FFFF*256, y+controller.scale_bottom_right/$FFFF*256);
draw_vertex(x+controller.scale_left_bottom/$FFFF*256, y+controller.scale_bottom_left/$FFFF*256);
draw_vertex(x+controller.scale_left_top/$FFFF*256, y+controller.scale_top_left/$FFFF*256);
draw_primitive_end();
if (mode == 1)
{
	draw_circle(x+controller.scale_left_top/$FFFF*256+1, y+controller.scale_top_left/$FFFF*256+1, 3, 0);
	draw_circle(x+controller.scale_right_top/$FFFF*256-1, y+controller.scale_top_right/$FFFF*256+1, 3, 0);
	draw_circle(x+controller.scale_right_bottom/$FFFF*256-1, y+controller.scale_bottom_right/$FFFF*256-1, 3, 0);
	draw_circle(x+controller.scale_left_bottom/$FFFF*256+1, y+controller.scale_bottom_left/$FFFF*256-1, 3, 0);
}


var t_list = controller.blindzone_list;
for (i = ds_list_size(t_list)-4; i >= 0; i-=4)
{    
    draw_set_colour(c_black);
    draw_rectangle( x+t_list[| i]/$FFFF*256+1,
                    y+t_list[| i+2]/$FFFF*256+1,
                    x+t_list[| i+1]/$FFFF*256-1,
                    y+t_list[| i+3]/$FFFF*256-1,     0);
    draw_set_colour(c_red);
    /*draw_set_alpha(0.2);
    draw_rectangle( x+t_list[| i]/$FFFF*256+1,
                    y+t_list[| i+2]/$FFFF*256+1,
                    x+t_list[| i+1]/$FFFF*256-1,
                    y+t_list[| i+3]/$FFFF*256-1,     0);*/
    draw_rectangle( x+t_list[| i]/$FFFF*256+1,
                    y+t_list[| i+2]/$FFFF*256+1,
                    x+t_list[| i+1]/$FFFF*256-1,
                    y+t_list[| i+3]/$FFFF*256-1,     1);
    draw_rectangle( x+t_list[| i]/$FFFF*256,
                    y+t_list[| i+2]/$FFFF*256,
                    x+t_list[| i+1]/$FFFF*256,
                    y+t_list[| i+3]/$FFFF*256,     1);

}

draw_set_colour(c_black);
