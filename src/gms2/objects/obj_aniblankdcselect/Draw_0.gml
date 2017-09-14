if (view_current != 0)
    exit;
    
draw_self();
draw_sprite(spr_aniknob,(moving > 0),x+controller.aniblank_dc*2*64,y+16);

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+150,y+9,string_hash_to_newline("Ratio: "+string(controller.aniblank_dc)));
draw_set_color(c_white);


