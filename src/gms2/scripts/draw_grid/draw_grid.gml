draw_clear_alpha(c_black,0);
draw_set_color(c_ltgray);
gpu_set_blendmode(bm_add);

posincrement = view_wport[4]/sgridnum;

for (i=1; i<=sgridnum; i++)
{
    draw_line(0, posincrement*i, view_wport[4], posincrement*i);
}
for (i=1; i<=sgridnum; i++)
{
    draw_line(posincrement*i, 0, posincrement*i, view_wport[4]);
}
    
draw_set_color(c_black);
gpu_set_blendmode(bm_normal);
