read_hershey();

hershey_surf = surface_create(512,4096*2);

surface_set_target(hershey_surf);
draw_clear(c_ltgray);

for (c = 0; c < ds_list_size(hershey_list); c++)
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
            draw_line(xo+ xp/1000,yo+ yp/1000,xo+ nxp/1000,yo+ nyp/1000);
            //show_message(xo+ xp/128)
            //show_message(xo+ nxp/128);
            }
        }
            
    ds_list_destroy(new_list);
    }
    
surface_reset_target();

ds_list_destroy(hershey_list);
