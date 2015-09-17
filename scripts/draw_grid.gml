draw_set_color(c_dkgray);
draw_set_blend_mode(bm_add);

for (i=1;i<=512/32;i++)
    {
    draw_line(0,32*i,512,32*i);
    }
for (i=1;i<=512/32;i++)
    {
    draw_line(32*i,0,32*i,512);
    }
    
draw_set_color(c_white);
draw_set_blend_mode(bm_normal);
