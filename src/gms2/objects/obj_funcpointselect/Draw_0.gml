if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+floor(clamp(controller.shapefunc_cp,0,511)/511*128),y+16);

draw_text(x+150,y+9,"Points: "+string(round(controller.shapefunc_cp)));

