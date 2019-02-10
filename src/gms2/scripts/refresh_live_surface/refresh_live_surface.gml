if (!surface_exists(frame_surf))
    frame_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_hport[4]))));
if (!surface_exists(frame3d_surf))
    frame3d_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_hport[4]))));
	
	
if (viewmode != 1)
{
    surface_set_target(frame_surf);
    draw_clear_alpha(c_white,0);
    surface_reset_target();
}

if (viewmode != 0)
{
    surface_set_target(frame3d_surf);
    draw_clear(c_black);
    surface_reset_target();
}

correctframe = round(tlpos/1000*controller.projectfps);

var t_scaley = 1/$FFFF*view_hport[4];
var t_scalex = 1/$FFFF*view_wport[4];
var t_centerx = view_wport[4]/2;
var t_centery = view_hport[4]/2;
var t_scalediag = sqrt(view_hport[4]*view_hport[4]+view_wport[4]*view_wport[4])/2;


// insert draw

draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
draw_set_color(c_black);