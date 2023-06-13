function update_anicolors() {
	with (obj_anicolorselect_1)
	    {
	    activecolor = controller.anicolor1;
	    redy = round(y+23-(color_get_red(activecolor)/255*23));
	    greeny = round(y+23-(color_get_green(activecolor)/255*23));
	    bluey = round(y+23-(color_get_blue(activecolor)/255*23));
	    }
	with (obj_anicolorselect_2)
	    {
	    activecolor = controller.anicolor2;
	    redy = round(y+23-(color_get_red(activecolor)/255*23));
	    greeny = round(y+23-(color_get_green(activecolor)/255*23));
	    bluey = round(y+23-(color_get_blue(activecolor)/255*23));
	    }
	with (obj_anienddotscolorselect)
	    {
	    activecolor = controller.anienddotscolor;
	    redy = round(y+23-(color_get_red(activecolor)/255*23));
	    greeny = round(y+23-(color_get_green(activecolor)/255*23));
	    bluey = round(y+23-(color_get_blue(activecolor)/255*23));
	    }



}
