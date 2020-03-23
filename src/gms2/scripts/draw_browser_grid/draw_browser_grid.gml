draw_set_alpha(1);
draw_set_color(c_black);
draw_surface(browser_surf, camera_get_view_x(view_camera[1]), camera_get_view_y(view_camera[1]));

var t_x = camera_get_view_width(view_camera[1])-1;
var t_y = camera_get_view_y(view_camera[1])-1;
draw_line(t_x, t_y, t_x, t_y+camera_get_view_height(view_camera[1]));