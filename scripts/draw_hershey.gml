hershey_surf1 = surface_create(512,2048);
hershey_surf2 = surface_create(512,2048);
hershey_surf3 = surface_create(512,2048);

surface_set_target(hershey_surf1);
    draw_background(bck_hershey1,0,0);
surface_reset_target();
surface_set_target(hershey_surf2);
    draw_background(bck_hershey2,0,0);
surface_reset_target();
surface_set_target(hershey_surf3);
    draw_background(bck_hershey3,0,0);
surface_reset_target();

/*background_delete(bck_hershey1);
background_delete(bck_hershey2);
background_delete(bck_hershey3);*/
