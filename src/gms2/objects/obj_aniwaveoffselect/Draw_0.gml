if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_aniknob,(moving > 0),x+clamp(controller.aniwave_offset,0,360)/360*128,y+16);

draw_set_color(c_teal);
draw_text(x+150,y+9,"Offset: "+string(round(controller.aniwave_offset))+" deg");
draw_set_color(c_black);
