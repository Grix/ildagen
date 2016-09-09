var t_dist, t_xp, t_yp, t_xpn, t_ypn, t_c, t_vectorx, t_vectory, t_curpointlist, t_nextpointlist, t_nextnextpointlist;
var t_totalrem = 0;
var t_totalpointswanted = floor(controller.opt_scanspeed/controller.projectfps);
maxpointswanted = t_totalpointswanted-maxpoints_static; 
if (maxpointswanted == 0) 
    maxpointswanted = 1;
lengthwanted = abs(lit_length/maxpointswanted);
if (lengthwanted == 0) 
{
    lengthwanted = 0.001;
}

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
        controller.opt_warning_flag = 1;
    }
}

if ((lit_length == 0) && ds_list_size(list_points))
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
                ds_list_delete(list_raw,list_points[| i]);
                maxpoints_static--;
            }
        }
    }
    else 
    {
        var t_addtoeach = floor(maxpointswanted/ds_list_size(list_points));
        for (i = ds_list_size(list_points)-1; i >= 0; i--)
        {
            t_curpointlist = list_raw[| list_points[| i]];
            repeat (t_addtoeach)
            {
                pointlist = ds_list_create();
                ds_list_add(pointlist, t_curpointlist[| 0]);
                ds_list_add(pointlist, t_curpointlist[| 1]);
                ds_list_add(pointlist, 0);
                ds_list_add(pointlist, t_curpointlist[| 3]);
                ds_list_insert(list_raw, list_points[| i], pointlist);
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
                ds_list_delete(list_raw,list_points[| i]);
                maxpoints_static--;
            }
        }
        maxpointswanted = t_totalpointswanted-maxpoints_static; 
        if (maxpointswanted == 0) 
            maxpointswanted = 1;
        lengthwanted = abs(max(1,lit_length)/maxpointswanted);
    }
    
    //adding or reducing points to get uniform vector lengths
    for (i = 0; i < ds_list_size(list_raw)-3; i++)
    {
        t_curpointlist = list_raw[| i];
        t_nextpointlist = list_raw[| i+1];
        if ((t_curpointlist[| 2] == 1) || (t_nextpointlist[| 2] == 1))
            continue;
            
        t_xp = t_curpointlist[| 0];
        t_yp = t_curpointlist[| 1];
        t_xpn = t_nextpointlist[| 0];
        t_ypn = t_nextpointlist[| 1];
        
        t_dist = point_distance(t_xp,t_yp,t_xpn,t_ypn);
        
        if (t_dist == 0) 
            continue;
            
        if (t_dist < lengthwanted)
        {
            //delete point
            if (t_nextpointlist[| 2] == 1)
            {
                t_totalrem -= t_dist;
                continue;
            }
            
            t_nextnextpointlist = list_raw[| i+2];
                
            if ( (t_xpn == t_nextnextpointlist[| 0]) && (t_ypn == t_nextnextpointlist[| 1]) )
            {
                t_totalrem -= t_dist;
                continue;
            }
                
            ds_list_delete(list_raw,i+1);
            i--;
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
            t_c = t_nextpointlist[| 3];
            for (u = 1; u < stepscount; u++)
            {
                pointlist = ds_list_create();
                ds_list_add(pointlist, t_xp+t_vectorx*u);
                ds_list_add(pointlist, t_yp+t_vectory*u);
                ds_list_add(pointlist, 0);
                ds_list_add(pointlist, t_c);
                ds_list_insert(list_raw,i+1,pointlist);
                i++;
            }
        }
            
    }
}
    
//final removal or adding of ending points to match perfectly
while (ds_list_size(list_raw) > t_totalpointswanted)
{
    t_curpointlist = list_raw[| ds_list_size(list_raw)-1];
    if (t_curpointlist[| 0] != $8000)
        break;
        
    ds_list_delete(list_raw,ds_list_size(list_raw)-1);
    
    if (controller.opt_warning_flag != 1)
    {
        controller.opt_warning_flag = 1;
    }
}
while (ds_list_size(list_raw) < t_totalpointswanted)
{
    pointlist = ds_list_create();
    ds_list_add(pointlist, $8000);
    ds_list_add(pointlist, $8000);
    ds_list_add(pointlist, 1);
    ds_list_add(pointlist, 0);
    ds_list_add(list_raw,pointlist);
}

