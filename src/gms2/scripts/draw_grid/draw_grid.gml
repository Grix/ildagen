draw_clear_alpha(c_black,0);
draw_set_color(c_ltgray);
gpu_set_blendmode(bm_add);

posincrement = view_wport[4]/sgridnum;

for (i=1; i<=sgridnum; i++)
{
    draw_line_width(0, posincrement*i, view_wport[4], posincrement*i, dpi_multiplier);
}
for (i=1; i<=sgridnum; i++)
{
    draw_line_width(posincrement*i, 0, posincrement*i, view_wport[4], dpi_multiplier);
}
    
draw_set_color(c_black);
gpu_set_blendmode(bm_normal);
