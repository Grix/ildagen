draw_clear_alpha(c_black,0);
draw_set_circle_precision(64);
draw_set_color(c_ltgray);
gpu_set_blendmode(bm_add);

draw_circle(512,512,100,1);
draw_circle(512,512,200,1);
draw_circle(512,512,300,1);
draw_circle(512,512,400,1);
for (i = 0;i < 2*pi; i += degtorad(15))
    draw_line(512+100*cos(i),512+100*sin(i),512+800*cos(i),512+800*sin(i));
for (i = 0;i < 2*pi; i += degtorad(45))
    draw_line(512,512,512+800*cos(i),512+800*sin(i));
    
draw_set_color(c_black);
gpu_set_blendmode(bm_normal);
draw_set_circle_precision(24);
