

hershey_surf1 = surface_create(512,2048);
hershey_surf2 = surface_create(512,2048);
hershey_surf3 = surface_create(512,2048);

surf1_bck = background_add("hershey_surf1.png",0,1);
surf2_bck = background_add("hershey_surf2.png",0,1);
surf3_bck = background_add("hershey_surf3.png",0,1);

surface_set_target(hershey_surf1);
    draw_background(surf1_bck,0,0);
surface_reset_target();
surface_set_target(hershey_surf2);
    draw_background(surf2_bck,0,0);
surface_reset_target();
surface_set_target(hershey_surf3);
    draw_background(surf3_bck,0,0);
surface_reset_target();

background_delete(surf1_bck);
background_delete(surf2_bck);
background_delete(surf3_bck);

/*
surface_set_target(hershey_surf1);
draw_clear(c_ltgray);

for (c = 0; c < 952; c++)
    {
    new_list = ds_list_find_value(hershey_list,c);
        
    xo = (c mod 14)*30+15;
    yo = ceil((c+1)/14)*30-15;
    listsize = (((ds_list_size(new_list)-50)/6)-1);
    
    for (u = 0; u < listsize; u++)
        {
        
        nbl = ds_list_find_value(new_list,50+(u+1)*6+2);
        framepoints++;
        
        if (nbl == 0)
            {
            xp = ds_list_find_value(new_list,50+u*6+0);
            yp = ds_list_find_value(new_list,50+u*6+1);
            
            nxp = ds_list_find_value(new_list,50+(u+1)*6+0);
            nyp = ds_list_find_value(new_list,50+(u+1)*6+1);
            
            
            draw_set_color(c_black);
            draw_line(xo+ xp,yo+ yp,xo+ nxp,yo+ nyp);
            }
        }
    if (c < 938)
        ds_list_destroy(new_list);
    }
surface_reset_target();

surface_set_target(hershey_surf2);
draw_clear(c_ltgray);

for (c = 938; c < 1904; c++)
    {
    //letter_list = ds_list_find_value(hershey_list,c);
    //new_list = ds_list_create();
    
    /*
    checkpoints = (ds_list_size(letter_list)-50)/6;
    blanknew = 1;
    
    for (n = 0;n < checkpoints; n++)
        {
        makedot = 0;
        
        blank = 0;
            
        if (ds_list_find_value(letter_list,50+6*n+2))
            blank = 1;
            
        ds_list_add(new_list,(ds_list_find_value(letter_list,50+6*n)-$ffff/2));
        //show_message((ds_list_find_value(letter_list,50+6*n)-$ffff/2))
        ds_list_add(new_list,(ds_list_find_value(letter_list,50+6*n+1)-$ffff/2));
        ds_list_add(new_list,blank);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        
        }*/
        /*
    new_list = ds_list_find_value(hershey_list,c);
        
    xo = (c mod 14)*30+15;
    yo = ceil((c+1)/14)*30-15-2048;
    listsize = (((ds_list_size(new_list)-50)/6)-1);
    
    for (u = 0; u < listsize; u++)
        {
        
        nbl = ds_list_find_value(new_list,50+(u+1)*6+2);
        framepoints++;
        
        if (nbl == 0)
            {
            xp = ds_list_find_value(new_list,50+u*6+0);
            yp = ds_list_find_value(new_list,50+u*6+1);
            
            nxp = ds_list_find_value(new_list,50+(u+1)*6+0);
            nyp = ds_list_find_value(new_list,50+(u+1)*6+1);
            
            
            draw_set_color(c_black);
            draw_line(xo+ xp,yo+ yp,xo+ nxp,yo+ nyp);
            }
        }
            
    if (c < 1890)
        ds_list_destroy(new_list);
    }
surface_reset_target();


surface_set_target(hershey_surf3);
draw_clear(c_ltgray);

for (c = 1890; c < ds_list_size(hershey_list); c++)
    {
    //letter_list = ds_list_find_value(hershey_list,c);
    //new_list = ds_list_create();
    
    /*
    checkpoints = (ds_list_size(letter_list)-50)/6;
    blanknew = 1;
    
    for (n = 0;n < checkpoints; n++)
        {
        makedot = 0;
        
        blank = 0;
            
        if (ds_list_find_value(letter_list,50+6*n+2))
            blank = 1;
            
        ds_list_add(new_list,(ds_list_find_value(letter_list,50+6*n)-$ffff/2));
        //show_message((ds_list_find_value(letter_list,50+6*n)-$ffff/2))
        ds_list_add(new_list,(ds_list_find_value(letter_list,50+6*n+1)-$ffff/2));
        ds_list_add(new_list,blank);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        
        }*/
        /*
    new_list = ds_list_find_value(hershey_list,c);
        
    xo = (c mod 14)*30+15;
    yo = ceil((c+1)/14)*30-15-4096;
    listsize = (((ds_list_size(new_list)-50)/6)-1);
    
    for (u = 0; u < listsize; u++)
        {
        
        nbl = ds_list_find_value(new_list,50+(u+1)*6+2);
        framepoints++;
        
        if (nbl == 0)
            {
            xp = ds_list_find_value(new_list,50+u*6+0);
            yp = ds_list_find_value(new_list,50+u*6+1);
            
            nxp = ds_list_find_value(new_list,50+(u+1)*6+0);
            nyp = ds_list_find_value(new_list,50+(u+1)*6+1);
            
            
            draw_set_color(c_black);
            draw_line(xo+ xp,yo+ yp,xo+ nxp,yo+ nyp);
            }
        }
            
    ds_list_destroy(new_list);
    }
surface_reset_target();

surface_save(hershey_surf1,get_save_filename("",""));
surface_save(hershey_surf2,get_save_filename("",""));
surface_save(hershey_surf3,get_save_filename("",""));

ds_list_destroy(hershey_list);*/
