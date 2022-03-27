
draw_self();
if (moving)
{
    intensity_upper = y+54-controller.intensity_master_scale*52;
}
draw_sprite(spr_aniknobvert,(moving == 1),sliderx,intensity_upper);

draw_text(x-10,y-24,"Intensity");
