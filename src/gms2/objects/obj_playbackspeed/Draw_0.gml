if (view_current != 0) && (room == rm_seq)
	exit;

if (view_current != 1) && (room == rm_ilda)
	exit;

draw_set_color(c_black);

draw_self();

draw_text(x+50,y+3,stringToDraw);
