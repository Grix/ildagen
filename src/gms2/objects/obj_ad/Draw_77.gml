draw_set_alpha(1);
draw_set_colour(c_white);
    draw_rectangle(x,y-10,x+700,y+420,0);
draw_set_colour(c_dkgray);
    draw_rectangle(x,y+20,x+700,y+420,1);
    draw_rectangle(x,y-10,x+700,y+20,1);
    //close button
    draw_rectangle(x+660,y-10,x+700,y+20,1);
    draw_line_width(x+672,y-2,x+687,y+13,2);
    draw_line_width(x+687,y-2,x+672,y+13,2);
    if (highlight_close)
    {
        draw_set_alpha(0.3);
        draw_rectangle(x+660,y-10,x+700,y+20,0);
        draw_set_alpha(1);
    }
    
draw_sprite(ad, 0, x+1,y+21);
draw_set_color(c_black);

