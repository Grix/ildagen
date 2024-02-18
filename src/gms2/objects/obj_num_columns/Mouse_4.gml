if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    livecontrol.num_grid_columns += 1;
else
    livecontrol.num_grid_columns -= 1;
	
livecontrol.num_grid_columns = clamp(livecontrol.num_grid_columns, 4, 24);
if (surface_exists(livecontrol.browser_surf))
	surface_free(livecontrol.browser_surf);
livecontrol.browser_surf = -1;