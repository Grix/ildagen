draw_set_alpha(1);
draw_set_colour(c_white);
    draw_rectangle(x,y-10*controller.dpi_multiplier,x+700*controller.dpi_multiplier,y+420*controller.dpi_multiplier,0);
draw_set_colour(c_dkgray);
    draw_rectangle(x,y+20*controller.dpi_multiplier,x+700*controller.dpi_multiplier,y+420*controller.dpi_multiplier,1);
    draw_rectangle(x,y-10*controller.dpi_multiplier,x+700*controller.dpi_multiplier,y+20*controller.dpi_multiplier,1);
    //close button
    draw_rectangle(x+660*controller.dpi_multiplier,y-10*controller.dpi_multiplier,x+700*controller.dpi_multiplier,y+20*controller.dpi_multiplier,1);
    draw_line_width(x+672*controller.dpi_multiplier,y-2*controller.dpi_multiplier,x+687*controller.dpi_multiplier,y+13*controller.dpi_multiplier,2*controller.dpi_multiplier);
    draw_line_width(x+687*controller.dpi_multiplier,y-2*controller.dpi_multiplier,x+672*controller.dpi_multiplier,y+13*controller.dpi_multiplier,2*controller.dpi_multiplier);
    if (highlight_close)
    {
        draw_set_alpha(0.3);
        draw_rectangle(x+660*controller.dpi_multiplier,y-10*controller.dpi_multiplier,x+700*controller.dpi_multiplier,y+20*controller.dpi_multiplier,0);
        draw_set_alpha(1);
    }
    
draw_sprite_ext(ad, 0, x+1*controller.dpi_multiplier,y+21*controller.dpi_multiplier, controller.dpi_multiplier, controller.dpi_multiplier, 0, c_white, 1);
draw_set_color(c_black);

