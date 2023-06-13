function update_colors() {
	with (obj_colorselect_1)
	    {
	    activecolor = controller.color1;
	    redy = round(y+23-(color_get_red(activecolor)/255*23));
	    greeny = round(y+23-(color_get_green(activecolor)/255*23));
	    bluey = round(y+23-(color_get_blue(activecolor)/255*23));
	    }
	with (obj_colorselect_2)
	    {
	    activecolor = controller.color2;
	    redy = round(y+23-(color_get_red(activecolor)/255*23));
	    greeny = round(y+23-(color_get_green(activecolor)/255*23));
	    bluey = round(y+23-(color_get_blue(activecolor)/255*23));
	    }
	with (obj_enddotscolorselect)
	    {
	    activecolor = controller.enddotscolor;
	    redy = round(y+23-(color_get_red(activecolor)/255*23));
	    greeny = round(y+23-(color_get_green(activecolor)/255*23));
	    bluey = round(y+23-(color_get_blue(activecolor)/255*23));
	    }



}
