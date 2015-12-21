if (lit_length == 0)
    {
    //todo expand points
    while (ds_list_size(list_raw)/4 < floor(controller.opt_scanspeed/controller.projectfps))
        {
        ds_list_add(list_raw,$8000);
        ds_list_add(list_raw,$8000);
        ds_list_add(list_raw,1);
        ds_list_add(list_raw,0);
        }
    }

var t_dist, t_xp, t_yp, t_xpn, t_ypn, t_c, t_vectorx, t_vectory;
var t_totalrem = 0;
maxpointswanted = floor(controller.opt_scanspeed/controller.projectfps)-maxpoints_static; 
lengthwanted = lit_length/maxpointswanted;

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
        stepscount = floor(steps);
        t_vectorx = (t_xpn-t_xp)/steps;
        t_vectory = (t_ypn-t_yp)/steps;
        t_c = list_raw[| i+7];
        for (u = 0; u < stepscount; u++)
            {
            ds_list_insert(list_raw,i+4,t_c);
            ds_list_insert(list_raw,i+4,0);
            ds_list_insert(list_raw,i+4,t_yp+t_vectory*u);
            ds_list_insert(list_raw,i+4,t_xp+t_vectorx*u);
            i += 4;
            }
        }
        
    }
    
while (ds_list_size(list_raw)/4 < floor(controller.opt_scanspeed/controller.projectfps))
    {
    ds_list_add(list_raw,$8000);
    ds_list_add(list_raw,$8000);
    ds_list_add(list_raw,1);
    ds_list_add(list_raw,0);
    }
