if (!surface_exists(frame_surf))
    frame_surf = surface_create(512,512);
if (!surface_exists(frame3d_surf))
    frame3d_surf = surface_create(512,512);

surface_set_target(frame_surf);

draw_clear_alpha(c_white,0);

if (viewmode == 0) or (viewmode == 2)
    {
    el_list = ds_list_find_value(frame_list,frame);
    framepoints = 0;
    
    draw_set_alpha(1);
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        new_list = ds_list_find_value(el_list,i);
        
        if (ds_list_size(new_list) < 15)
            {
            ds_list_delete(el_list,i);
            ds_list_sort(el_list,0);
            continue;
            }
        
            xo = ds_list_find_value(new_list,0)/128;
            yo = ds_list_find_value(new_list,1)/128;
            
            //TODO if just one
            
            for (u = 0; u < (((ds_list_size(new_list)-10)/6)-1); u++)
                {
                
                nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
                
                if (nbl == 0)
                    {
                    xp = ds_list_find_value(new_list,10+u*6+0);
                    yp = ds_list_find_value(new_list,10+u*6+1);
                    
                    nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
                    nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
                    nb = ds_list_find_value(new_list,10+(u+1)*6+3);
                    ng = ds_list_find_value(new_list,10+(u+1)*6+4);
                    nr = ds_list_find_value(new_list,10+(u+1)*6+5);
                    
                    framepoints++;
                    draw_set_color(make_colour_rgb(nr,ng,nb));
                    if (xp == nxp) && (yp == nyp)
                        {
                        draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                        }
                    else
                        draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
                    }
                
                
                
                }
        }
    
    if (onion)
    for (j = 1;j <= onion_number;j++)
        {
        if !(frame >= j) 
            break;
        
        el_list = ds_list_find_value(frame_list,frame-j);
    
        draw_set_alpha(onion_alpha*power(onion_dropoff,j));
        
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            new_list = ds_list_find_value(el_list,i);
            
                xo = ds_list_find_value(new_list,0)/128;
                yo = ds_list_find_value(new_list,1)/128;
                
                //TODO if just one
                
                for (u = 0; u < (((ds_list_size(new_list)-10)/6)-1); u++)
                    {
                    nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
                    
                    if (nbl == 0)
                        {
                        xp = ds_list_find_value(new_list,10+u*6+0);
                        yp = ds_list_find_value(new_list,10+u*6+1);
                        
                        nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
                        nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
                        nb = ds_list_find_value(new_list,10+(u+1)*6+3);
                        ng = ds_list_find_value(new_list,10+(u+1)*6+4);
                        nr = ds_list_find_value(new_list,10+(u+1)*6+5);
                        
                        draw_set_color(make_colour_rgb(nr,ng,nb));
                        if (xp == nxp) && (yp == nyp)
                            {
                            draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                            }
                        else
                            draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
                        }
                    
                    }
            }
        }
        
    el_list = ds_list_find_value(frame_list,frame);
    draw_set_alpha(1);
    
    }

surface_reset_target();

if (viewmode != 0)
    {
    surface_set_target(frame3d_surf);
        refresh_3dsurfaces();
    surface_reset_target();
    }
    
    
