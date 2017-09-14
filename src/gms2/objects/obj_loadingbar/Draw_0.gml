draw_set_colour(c_dkgray);
draw_text(20,20,string_hash_to_newline("Working, please wait..."));
draw_rectangle(20,50,20+lerp(0,200,(global.loading_current-global.loading_start)/max(global.loading_end-global.loading_start,0.001)),70,0);
draw_rectangle(20,50,220,70,1);

