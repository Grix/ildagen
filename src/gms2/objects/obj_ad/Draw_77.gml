draw_set_alpha(1);
draw_set_colour(c_white);
    draw_rectangle(x,y,x+700,y+420,0);
draw_set_colour(c_dkgray);
    draw_rectangle(x,y+20,x+700,y+420,1);
    draw_rectangle(x,y,x+700,y+20,1);
    //close button
    draw_rectangle(x+670,y,x+700,y+20,1);
    draw_line(x+680,y+5,x+690,y+15);
    draw_line(x+690,y+5,x+680,y+15);
    if (highlight_close)
    {
        draw_set_alpha(0.3);
        draw_rectangle(x+670,y,x+700,y+20,0);
        draw_set_alpha(1);
    }
    
draw_sprite(ad, 0, x+1,y+21);
draw_set_color(c_black);

