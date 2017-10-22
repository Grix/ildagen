if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+floor(clamp(controller.color_dc,0,1)*2*64),y+16);

draw_text(x+150,y+9,"Ratio: "+string(controller.color_dc));


