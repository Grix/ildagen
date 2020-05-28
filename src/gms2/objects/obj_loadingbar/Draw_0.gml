draw_set_colour(c_dkgray);
draw_text(20,20,"Working, please wait...");
var t_first = (global.loading_current-global.loading_start);
var t_last = max(global.loading_end-global.loading_start,0.001);
var t_lerpratio = real(t_first)/real(t_last);
var t_length = lerp(0,200,t_lerpratio);
draw_rectangle(20,50,20+t_length,70,0);
draw_rectangle(20,50,220,70,1);

