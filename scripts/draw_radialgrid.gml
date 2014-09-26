draw_set_color(c_dkgray);
draw_set_blend_mode(bm_add);
draw_set_circle_precision(48);

draw_circle(256,256,52,1);
draw_circle(256,256,103,1);
draw_circle(256,256,154,1);
draw_circle(256,256,205,1);
draw_circle(256,256,256,1);
for (i = 0;i < 2*pi; i += degtorad(15))
    draw_line(256+50*cos(i),256+50*sin(i),256+400*cos(i),256+400*sin(i));
for (i = 0;i < 2*pi; i += degtorad(45))
    draw_line(256,256,256+400*cos(i),256+400*sin(i));
    
draw_set_color(c_white);
draw_set_blend_mode(bm_normal);