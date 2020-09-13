function draw_radialgrid() {
	draw_clear_alpha(c_black,0);
	draw_set_circle_precision(64);
	draw_set_color(c_ltgray);
	gpu_set_blendmode(bm_add);

	var t_wport_half = view_wport[4]/2;

	draw_circle(t_wport_half,t_wport_half,view_wport[4]/12,1);
	draw_circle(t_wport_half,t_wport_half,view_wport[4]/6,1);
	draw_circle(t_wport_half,t_wport_half,view_wport[4]/3,1);
	draw_circle(t_wport_half,t_wport_half,view_wport[4]/1.5,1);
	for (i = 0;i < 2*pi; i += degtorad(15))
	    draw_line_width(t_wport_half+view_wport[4]/12*cos(i),t_wport_half+view_wport[4]/12*sin(i),t_wport_half+view_wport[4]/1.5*cos(i),t_wport_half+view_wport[4]/1.5*sin(i), dpi_multiplier);
	for (i = 0;i < 2*pi; i += degtorad(45))
	    draw_line_width(t_wport_half,t_wport_half,t_wport_half+view_wport[4]/1.5*cos(i),t_wport_half+view_wport[4]/1.5*sin(i), dpi_multiplier);
    
	draw_set_color(c_black);
	gpu_set_blendmode(bm_normal);
	draw_set_circle_precision(24);



}
