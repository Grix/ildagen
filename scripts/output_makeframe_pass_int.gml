var t_dist, t_xp, t_yp, t_xpn, t_ypn, t_c, t_vectorx, t_vectory;
var t_totalrem = 0;
var t_totalpointswanted = floor(controller.opt_scanspeed/controller.projectfps);
maxpointswanted = t_totalpointswanted-maxpoints_static; 
lengthwanted = abs(lit_length/maxpointswanted);

//TODO fix this shit: reducing points when there is also lit segments
/*if (lengthwanted > controller.opt_maxdist)
    {
    if (ds_list_size(list_points) != 0)
        {
        var t_subfromeach = abs(ceil((maxpointswanted/ds_list_size(list_points))/2));
        if (t_subfromeach+2 > controller.dotmultiply)
            {
            if (controller.opt_warning_flag != 1)
                {
                show_message_async("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame ["+string(j)+"] or use the exported file at your own risk");
                controller.opt_warning_flag = 1;
                }
            while (t_subfromeach+2 > controller.dotmultiply)
                {
                t_subfromeach--;
                }
            }
        for (i = ds_list_size(list_points)-1; i >= 0; i--)
            {
            repeat (t_subfromeach)
                {
                repeat (4)
                    ds_list_delete(list_raw,list_points[| i]+4);
                maxpoints_static--;
                }
            }
        maxpointswanted = t_totalpointswanted-maxpoints_static; 
        lengthwanted = abs(lit_length/maxpointswanted);
        }
    }*/
    
if (lengthwanted > controller.opt_maxdist)
    {
    if (controller.opt_warning_flag != 1)
        {
        show_message_async("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame [ "+string(j)+" ] or use the exported file at your own risk");
        controller.opt_warning_flag = 1;
        }
    }

if (lit_length == 0) and ds_list_size(list_points)
    {
    //adjust existing points
    if (maxpointswanted < 0)
        {
        //delete points to attempt to get below the limit
        var t_subfromeach = abs(ceil(maxpointswanted/ds_list_size(list_points)))+1;
        if (t_subfromeach+2 > controller.dotmultiply)
            {
            if (controller.opt_warning_flag != 1)
                {
                show_message_async("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame ["+string(j)+"] or use the exported file at your own risk");
                controller.opt_warning_flag = 1;
                }
            while (t_subfromeach+2 > controller.dotmultiply)
                {
                t_subfromeach--;
                }
            }
            
        for (i = ds_list_size(list_points)-1; i >= 0; i--)
            {
            repeat (t_subfromeach)
                {
                repeat (4)
                    ds_list_delete(list_raw,list_points[| i]+4);
                }
            }
        }
    else 
        {
        var t_addtoeach = floor(maxpointswanted/ds_list_size(list_points));
        for (i = ds_list_size(list_points)-1; i >= 0; i--)
            {
            t_xp = list_raw[| list_points[| i]];
            t_yp = list_raw[| list_points[| i]+1];
            t_c = list_raw[| list_points[| i]+3];
            repeat (t_addtoeach)
                {
                ds_list_insert(list_raw,list_points[| i],t_c);
                ds_list_insert(list_raw,list_points[| i],0);
                ds_list_insert(list_raw,list_points[| i],t_yp);
                ds_list_insert(list_raw,list_points[| i],t_xp);
                }
            }
        }
    }
else
    {
    if (maxpointswanted < 0)
        {
        //delete points to attempt to get below the limit
        //todo check for actual number of points instead of using dotmultiply variable
        if (ds_list_size(list_points) == 0)
            {
            if (controller.opt_warning_flag != 1)
                {
                show_message_async("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame ["+string(j)+"] or use the exported file at your own risk");
                controller.opt_warning_flag = 1;
                }
            }
        else
            {
            var t_subfromeach = abs(ceil(maxpointswanted/ds_list_size(list_points)));
            if (t_subfromeach+2 > controller.dotmultiply)
                {
                if (controller.opt_warning_flag != 1)
                    {
                    show_message_async("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame ["+string(j)+"] or use the exported file at your own risk");
                    controller.opt_warning_flag = 1;
                    }
                }
            else
                {
                while (t_subfromeach+2 < controller.dotmultiply)
                    {
                    t_subfromeach++;
                    }
                }
            }
            
        for (i = ds_list_size(list_points)-1; i >= 0; i--)
            {
            repeat (t_subfromeach)
                {
                repeat (4)
                    ds_list_delete(list_raw,list_points[| i]+4);
                maxpoints_static--;
                }
            }
        maxpointswanted = t_totalpointswanted-maxpoints_static; 
        lengthwanted = abs(lit_length/maxpointswanted);
        }
    
    //adding or reducing points to get uniform vector lengths
    for (i = 0; i < ds_list_size(list_raw)-8; i += 4)
        {
        if (list_raw[| i+2] == 1) or (list_raw[| i+6] == 1) 
            continue;
            
        t_xp = list_raw[| i];
        t_yp = list_raw[| i+1];
        t_xpn = list_raw[| i+4];
        t_ypn = list_raw[| i+5];
        
        t_dist = point_distance(t_xp,t_yp,t_xpn,t_ypn);
        
        if (t_dist == 0) 
            continue;
            
        if (t_dist < lengthwanted)
            {
            //delete point
            if (i > ds_list_size(list_raw)-8)
                continue;
                
            if (list_raw[| i+6] == 1)
                {
                t_totalrem -= t_dist;
                continue;
                }
                
            if (point_distance(t_xpn, t_ypn, list_raw[| i+8], list_raw[| i+9]) == 0)
                {
                t_totalrem -= t_dist;
                continue;
                }
                
            repeat (4)
                ds_list_delete(list_raw,i+4);
            i -= 4;
            }
        else
            {
            //add points
            t_totalrem += lengthwanted - (t_dist mod lengthwanted);
            if (t_totalrem > lengthwanted)
                {
                t_totalrem -= lengthwanted;
                t_dist -= lengthwanted;
                }
            steps = t_dist/lengthwanted;
            stepscount = floor(steps)+1;
            t_vectorx = (t_xpn-t_xp)/steps;
            t_vectory = (t_ypn-t_yp)/steps;
            t_c = list_raw[| i+7];
            for (u = 1; u < stepscount; u++)
                {
                ds_list_insert(list_raw,i+4,t_c);
                ds_list_insert(list_raw,i+4,0);
                ds_list_insert(list_raw,i+4,t_yp+t_vectory*u);
                ds_list_insert(list_raw,i+4,t_xp+t_vectorx*u);
                i += 4;
                }
            }
            
        }
    }
    
//final removal or adding of ending points to match perfectly
if (ds_list_size(list_raw)/4-1 > t_totalpointswanted)
    {
    while ( ds_list_size(list_raw)/4-1 > t_totalpointswanted) and 
            (list_raw[| 0] == $8000) and  
            (list_raw[| 1] == $8000) and 
            (list_raw[| 2] == 1)
        {
        maxpoints_static--;
        repeat (4)
            ds_list_delete(list_raw,0);
        }
    if (controller.opt_warning_flag != 1)
        {
        show_message_async("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame [ "+string(j)+" ] or use the exported file at your own risk");
        controller.opt_warning_flag = 1;
        }
    }
else while (ds_list_size(list_raw)/4 < t_totalpointswanted)
    {
    ds_list_insert(list_raw,0,0);
    ds_list_insert(list_raw,0,1);
    ds_list_insert(list_raw,0,$8000);
    ds_list_insert(list_raw,0,$8000);
    }

