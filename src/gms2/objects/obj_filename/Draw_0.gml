if (view_current != 1)
	exit;

draw_set_color(c_black);
draw_set_alpha(1);

if (controller.filepath != "")
{
    draw_text(x,y,filename_name(controller.filepath));
}
