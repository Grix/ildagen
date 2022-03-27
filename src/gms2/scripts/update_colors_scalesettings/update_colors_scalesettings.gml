function update_colors_scalesettings() {
	with (obj_colorscale)
	{
	    redy_upper = round(y+52-controller.red_scale*52);
	    greeny_upper = round(y+52-controller.green_scale*52);
	    bluey_upper = round(y+52-controller.blue_scale*52);
    
	    redy_lower = round(y+52-controller.red_scale_lower*52);
	    greeny_lower = round(y+52-controller.green_scale_lower*52);
	    bluey_lower = round(y+52-controller.blue_scale_lower*52);
	}

	with (obj_masterintensityscale)
	{
		intensity_upper = y+54-controller.intensity_master_scale*52;
	}

}
