draw_self();
draw_set_colour(c_aqua);
draw_set_alpha(0.15);
draw_rectangle( x+controller.x_scale_start/$FFFF*256+1,
                y+controller.y_scale_start/$FFFF*256+1,
                x+controller.x_scale_end/$FFFF*256-1,
                y+controller.y_scale_end/$FFFF*256-1,     0);
draw_set_alpha(1);
draw_rectangle( x+controller.x_scale_start/$FFFF*256+1,
                y+controller.y_scale_start/$FFFF*256+1,
                x+controller.x_scale_end/$FFFF*256-1,
                y+controller.y_scale_end/$FFFF*256-1,     1);
draw_rectangle( x+controller.x_scale_start/$FFFF*256,
                y+controller.y_scale_start/$FFFF*256,
                x+controller.x_scale_end/$FFFF*256,
                y+controller.y_scale_end/$FFFF*256,     1);


var t_list = controller.blindzone_list;
for (i = ds_list_size(t_list)-4; i >= 0; i-=4)
{    
    draw_set_alpha(1);
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
    draw_set_alpha(1);
    draw_rectangle( x+t_list[| i]/$FFFF*256+1,
                    y+t_list[| i+2]/$FFFF*256+1,
                    x+t_list[| i+1]/$FFFF*256-1,
                    y+t_list[| i+3]/$FFFF*256-1,     1);
    draw_rectangle( x+t_list[| i]/$FFFF*256,
                    y+t_list[| i+2]/$FFFF*256,
                    x+t_list[| i+1]/$FFFF*256,
                    y+t_list[| i+3]/$FFFF*256,     1);

}

draw_set_alpha(1);
draw_set_colour(c_black);
