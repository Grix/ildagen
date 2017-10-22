if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_aniknob,(moving > 0),x+controller.anicolor_dc*2*64,y+16);

draw_text(x+150,y+9,"Ratio: "+string(controller.anicolor_dc));
