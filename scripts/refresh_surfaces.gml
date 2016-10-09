//cycles through every element in frame on screen and draws them on the frame surfaces

framepoints = 0;
frame_complexity = 0;
el_list = ds_list_find_value(frame_list,frame);

if (!surface_exists(frame_surf))
    frame_surf = surface_create(512,512);
if (!surface_exists(frame3d_surf))
    frame3d_surf = surface_create(512,512);

if (viewmode == 0) or (viewmode == 2)
{
    surface_set_target(frame_surf);
    draw_clear_alpha(c_white,0);
    
    draw_set_alpha(1);
    for (i = 0;i < ds_list_size(el_list);i++)
    {
        new_list = ds_list_find_value(el_list,i);
        
        /*if (ds_list_size(new_list) < 15)
        {
            ds_list_delete(el_list,i);
            ds_list_sort(el_list,0);
            continue;
        }*/ //todo what the fuck is this
        
        xo = ds_list_find_value(new_list,0)/128;
        yo = ds_list_find_value(new_list,1)/128;
        listsize = (((ds_list_size(new_list)-20)/4)-1);
        
        for (u = 0; u < listsize; u++)
        {
            nextpos = 20+(u+1)*4;
            nbl = ds_list_find_value(new_list,nextpos+2);
            
            if (nbl == 0)
            {
                xp = ds_list_find_value(new_list,nextpos-4);
                yp = ds_list_find_value(new_list,nextpos-3);
                
                nxp = ds_list_find_value(new_list,nextpos);
                nyp = ds_list_find_value(new_list,nextpos+1);
                
                framepoints++;
                
                draw_set_color(ds_list_find_value(new_list,nextpos+3));
                if (xp == nxp) && (yp == nyp) && !(ds_list_find_value(new_list,nextpos-2))
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
            listsize = (((ds_list_size(new_list)-20)/4)-1);
            
            for (u = 0; u < listsize; u++)
            {
                nextpos = 20+(u+1)*4;
                nbl = ds_list_find_value(new_list,nextpos+2);
                
                if (nbl == 0)
                {
                    xp = ds_list_find_value(new_list,nextpos-4);
                    yp = ds_list_find_value(new_list,nextpos-3);
                    
                    nxp = ds_list_find_value(new_list,nextpos);
                    nyp = ds_list_find_value(new_list,nextpos+1);
                    
                    draw_set_color(ds_list_find_value(new_list,nextpos+3));
                    if (xp == nxp) && (yp == nyp) && !(ds_list_find_value(new_list,nextpos-2))
                        draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                    else
                        draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
                }
                
            }
        }
    }
        
    el_list = ds_list_find_value(frame_list,frame);
    draw_set_alpha(1);
    surface_reset_target();
}

if (viewmode != 0)
{
    surface_set_target(frame3d_surf);
        refresh_3dsurfaces();
    surface_reset_target();
}

if (controller.exp_optimize)
{
    if (prepare_output())
    {
        ds_list_destroy(order_list);
        ds_list_destroy(polarity_list);
        ds_list_destroy(list_raw);
        
        var t_totalpointswanted = floor(opt_scanspeed/projectfps);
        var t_litpointswanted = t_totalpointswanted - maxpoints_static - maxpoints_dots - 3;
        if (t_litpointswanted == 0) 
            t_litpointswanted = 1;
        if (lit_length != 0)
        {
            var t_lengthwanted = abs(lit_length/t_litpointswanted);
            
            if (t_lengthwanted > 1000)//controller.opt_maxdist) TODO create setting
                frame_complexity = 1;
            else if (t_lengthwanted > 1000*0.75)
                frame_complexity = 2;
        }
        else
        {
            if (t_litpointswanted < 0)
                frame_complexity = 2;
        }
        
        framepoints += maxpoints_static;
    }
}

    
