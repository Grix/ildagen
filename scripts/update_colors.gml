with (obj_colorselect_1)
    {
    activecolor = controller.color1;
    redy = y+23-(colour_get_red(activecolor)/255*23);
    greeny = y+23-(colour_get_green(activecolor)/255*23);
    bluey = y+23-(colour_get_blue(activecolor)/255*23);
    }
with (obj_colorselect_2)
    {
    activecolor = controller.color2;
    redy = y+23-(colour_get_red(activecolor)/255*23);
    greeny = y+23-(colour_get_green(activecolor)/255*23);
    bluey = y+23-(colour_get_blue(activecolor)/255*23);
    }
with (obj_enddotscolorselect)
    {
    activecolor = controller.enddotscolor;
    redy = y+23-(colour_get_red(activecolor)/255*23);
    greeny = y+23-(colour_get_green(activecolor)/255*23);
    bluey = y+23-(colour_get_blue(activecolor)/255*23);
    }