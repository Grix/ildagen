draw_clear_alpha(c_black,0);
draw_set_color(c_dkgray);
draw_set_blend_mode(bm_add);

posincrement = 512/sgridnum;

for (i=1;i<=sgridnum;i++)
    {
    draw_line(0,posincrement*i,512,posincrement*i);
    }
for (i=1;i<=sgridnum;i++)
    {
    draw_line(posincrement*i,0,posincrement*i,512);
    }
    
draw_set_color(c_white);
draw_set_blend_mode(bm_normal);
