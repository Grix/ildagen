if (view_current == camera || camera == -1)
{
	if (instance_exists(obj_ad))
		exit;
	
	draw_set_color(controller.c_ltltgray);
	draw_rectangle(x,y,x+width+20,y+height+65, 0);
	draw_set_color(c_black);
	draw_rectangle(x,y,x+width+20,y+height+65, 1);
	draw_text_ext(x+10,y+10, message, 20, 400);
	if (mouse_x == clamp(mouse_x, button_x1, button_x2) && mouse_y == clamp(mouse_y, button_y1, button_y2))
	{
		draw_set_color(c_ltgray);
		draw_rectangle(button_x1,button_y1,button_x2,button_y2, 0);
		draw_set_color(c_black);
	}
	draw_rectangle(button_x1,button_y1,button_x2,button_y2, 1);
	draw_text(button_x1+10, button_y1+7, "Don't show again");
	
	if (mouse_x == clamp(mouse_x, button_ok_x1, button_ok_x2) && mouse_y == clamp(mouse_y, button_ok_y1, button_ok_y2))
	{
		draw_set_color(c_ltgray);
		draw_rectangle(button_ok_x1,button_ok_y1,button_ok_x2,button_ok_y2, 0);
		draw_set_color(c_black);
	}
	draw_rectangle(button_ok_x1,button_ok_y1,button_ok_x2,button_ok_y2, 1);
	draw_text(button_ok_x1+50, button_ok_y1+7, "OK");
}