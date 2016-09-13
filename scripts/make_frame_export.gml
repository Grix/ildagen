var t_vectorx, t_vectory;

var t_totalrem = 0;
var t_totalpointswanted = floor(controller.opt_scanspeed/controller.projectfps);
var t_litpointswanted = t_totalpointswanted - maxpoints_static - maxpoints_dots - 3;

if (t_litpointswanted == 0) 
    t_litpointswanted = 1;
var t_lengthwanted = abs(lit_length/t_litpointswanted);

xp_prev = $8000;
yp_prev = $8000;
bl_prev = 1;
c_prev = 0;
new_dot = 1;

log("----OUTPUT");
log("litlength "+string(lit_length));
log("smallestdot "+string(smallestdotsize));
log("maxpointstattic "+string(maxpoints_static));
log("litpointswanted "+string(t_litpointswanted));
log("maxdots "+string(maxpoints_dots));
log("numdots "+string(num_dots));

//if too many dots in frame, first attempt to shrink overlapping ones

if (lit_length > 0)
{
    var t_dotstodelete = 0;
    while ((t_lengthwanted > controller.opt_maxdist) && (maxpoints_dots != 0) && (smallestdotsize > 3))
    {
        t_dotstodelete++;
        t_litpointswanted += num_dots;
        if (t_litpointswanted == 0) 
            t_litpointswanted = 1;
        t_lengthwanted = abs(lit_length/t_litpointswanted);
        smallestdotsize--;
    }
    log("dotstodel "+string(t_dotstodelete));
}
else
{
    var t_dotstoadd = floor((t_litpointswanted+maxpoints_dots)/num_dots);
    log("dotstoadd "+string(t_dotstoadd));
}

if (t_lengthwanted == 0) 
{
    t_lengthwanted = 0.0001; //to avoid dividing by zero
}

log("length "+string(t_lengthwanted));


//parse elements
if (controller.exp_optimize)
    var t_numofelems = ds_list_size(order_list);
else 
    var t_numofelems = ds_list_size(el_list);
    
for (i = 0; i < t_numofelems; i++)
{
    if (controller.exp_optimize)
        list_id = ds_list_find_value(el_list,order_list[| i]);
    else 
        list_id = ds_list_find_value(el_list,i); 
        
    if (is_undefined(list_id))
        continue;

    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
       
    //writing points in element list
    listsize = ((ds_list_size(list_id)-20)/4);

    if (polarity_list[| i] == 0)
    {
        currentpos = 16;
        currentposadjust = 4;
    }
    else
    {
        currentpos = ds_list_size(list_id);
        currentposadjust = -4;
    }
    
    var t_i;
    for (t_i = 0; t_i < listsize; t_i++)
    {
        currentpos += currentposadjust;
        
        bl = ds_list_find_value(list_id,currentpos+2);
        
        if (bl)
        {
            bl_prev = 1;
            new_dot = 1;
            continue;
        }
        else 
        {
            xp = xo + list_id[| currentpos ];
            yp = $ffff - (yo + list_id[| currentpos+1 ]);
                    
            //valid lit point, process it
            
            c = list_id[| currentpos+3 ];
            
            if (bl_prev)
            {
                //BLANKING
                if (controller.exp_optimize)
                {
                    opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
                    var t_true_dwell = controller.opt_maxdwell; //todo calculate from angles
                    
                    if (opt_dist < 200) //connecting segments
                    {
                        //dwell on blanking start
                        repeat (controller.opt_maxdwell_blank)
                        {
                            ds_list_add(list_raw,xp_prev);
                            ds_list_add(list_raw,yp_prev);
                            ds_list_add(list_raw,0);
                            ds_list_add(list_raw,c_prev);
                        }
                        repeat (t_true_dwell - controller.opt_maxdwell_blank*2 )
                        {
                            ds_list_add(list_raw,xp_prev);
                            ds_list_add(list_raw,yp);
                            ds_list_add(list_raw,1);
                            ds_list_add(list_raw,0);
                        }
                        repeat (controller.opt_maxdwell_blank)
                        {
                            ds_list_add(list_raw,xp);
                            ds_list_add(list_raw,yp);
                            ds_list_add(list_raw,0);
                            ds_list_add(list_raw,c);
                        }
                    }
                    else //not connecting segments
                    {
                        //dwell on blanking start
                        repeat (controller.opt_maxdwell_blank)
                        {
                            ds_list_add(list_raw,xp_prev);
                            ds_list_add(list_raw,yp_prev);
                            ds_list_add(list_raw,0);
                            ds_list_add(list_raw,c_prev);
                        }
                        repeat ( max(controller.opt_maxdwell_blank, t_true_dwell - controller.opt_maxdwell_blank) )
                        {
                            ds_list_add(list_raw,xp_prev);
                            ds_list_add(list_raw,yp_prev);
                            ds_list_add(list_raw,1);
                            ds_list_add(list_raw,0);
                        }
                        
                        new_dot = 1;
                        
                        //travel
                        opt_vectorx = (xp_prev-xp)/opt_dist;
                        opt_vectory = (yp_prev-yp)/opt_dist;
                        
                        //find number of steps and step size
                        var t_trav_dist = a_ballistic; //todo calculate for angle
                        var t_n = 1;
                        var t_quantumsteps = 0;
                        var t_totaldist = 0;
                        while (1)
                        {
                            t_totaldist += (t_n + t_n-1)*t_trav_dist;
                            t_quantumsteps += (t_n + t_n-1);
                            if (t_totaldist > opt_dist)
                                break;
                            t_n++;
                        }
                        t_trav_dist -= (t_totaldist-opt_dist)/t_quantumsteps;
                        var t_trav_dist_x = -t_trav_dist*(xp_prev-xp)/opt_dist;
                        var t_trav_dist_y = -t_trav_dist*(yp_prev-yp)/opt_dist;
                        
                        //travel first and second half of segment
                        var t_step_dist_x = 0;
                        var t_step_dist_y = 0;
                        var t_xp_now = xp_prev;
                        var t_yp_now = yp_prev;
                        
                        for (k = 0; k < t_n; k++)
                        {
                            t_step_dist_x += t_trav_dist_x;
                            t_step_dist_y += t_trav_dist_y;
                            
                            t_xp_now += t_step_dist_x;
                            t_yp_now += t_step_dist_y;
                            
                            ds_list_add(list_raw,t_xp_now);
                            ds_list_add(list_raw,t_yp_now);
                            ds_list_add(list_raw,1);
                            ds_list_add(list_raw,0);
                        }
                        for (k = 1; k < t_n; k++)
                        {
                            t_step_dist_x -= t_trav_dist_x;
                            t_step_dist_y -= t_trav_dist_y;
                            
                            t_xp_now += t_step_dist_x;
                            t_yp_now += t_step_dist_y;
                            
                            ds_list_add(list_raw,t_xp_now);
                            ds_list_add(list_raw,t_yp_now);
                            ds_list_add(list_raw,1);
                            ds_list_add(list_raw,0);
                        }
                        
                        repeat ( max(controller.opt_maxdwell_blank, t_true_dwell - controller.opt_maxdwell_blank) )
                        {
                            ds_list_add(list_raw,xp);
                            ds_list_add(list_raw,yp);
                            ds_list_add(list_raw,1);
                            ds_list_add(list_raw,0);
                        }
                        repeat (controller.opt_maxdwell_blank)
                        {
                            ds_list_add(list_raw,xp);
                            ds_list_add(list_raw,yp);
                            ds_list_add(list_raw,0);
                            ds_list_add(list_raw,c);
                        }
                        
                    }
                }
                else //unoptimized
                {
                    ds_list_add(list_raw,xp);
                    ds_list_add(list_raw,yp);
                    ds_list_add(list_raw,1);
                    ds_list_add(list_raw,0);
                }
            }
            else if (controller.exp_optimize)
            {
                opt_dist = point_distance(xp,yp,xp_prev,yp_prev);
                if (opt_dist == 0)
                {
                    //dot, adjust intensity if necessary
                    if (lit_length == 0)
                    {
                        if (t_dotstoadd < 0)
                        {
                            currentpos += currentposadjust*abs(0-t_dotstoadd);
                            t_i += abs(0-t_dotstoadd);
                        }
                        else
                        {
                            if (new_dot)
                            { 
                                repeat (t_dotstoadd)
                                {
                                    ds_list_add(list_raw,xp);
                                    ds_list_add(list_raw,yp);
                                    ds_list_add(list_raw,bl);
                                    ds_list_add(list_raw,c);
                                }
                            new_dot = 0;
                            currentpos += currentposadjust*smallestdotsize; //save some time by jumping
                            t_i += smallestdotsize;
                            }
                        }
                    }
                    else
                    {
                        if (new_dot)
                        {
                            new_dot = 0;
                            currentpos += currentposadjust*t_dotstodelete;
                            t_i += t_dotstodelete;
                        }
                    }
                }
                else
                    new_dot = 1;
            }
        }
        
        if (!bl_prev && controller.exp_optimize && (opt_dist != 0) )
        {
            //INTERPOLATE
            if (opt_dist < t_lengthwanted)
            {
                //skip point
            
                /*if (list_raw[| i+6] == 1)
                {
                    t_totalrem -= opt_dist;
                    continue;
                }*/
                    
                /*if (point_distance(xp, yp, list_raw[| i+8], list_raw[| i+9]) == 0)
                {
                    t_totalrem -= opt_dist;
                    continue;
                }*/
                currentpos += currentposadjust;
                t_i++;
                continue;
            }
            else
            {
                //add points
                t_totalrem += t_lengthwanted - (opt_dist % t_lengthwanted);
                if (t_totalrem > t_lengthwanted)
                {
                    t_totalrem -= t_lengthwanted;
                    opt_dist -= t_lengthwanted;
                }
                steps = opt_dist/t_lengthwanted;
                stepscount = ceil(steps);
                t_vectorx = (xp-xp_prev)/steps;
                t_vectory = (yp-yp_prev)/steps;
                
                for (u = 1; u < stepscount; u++)
                {
                    ds_list_add(list_raw,xp_prev+t_vectorx*u);
                    ds_list_add(list_raw,yp_prev+t_vectory*u);
                    ds_list_add(list_raw,0);
                    ds_list_add(list_raw,c);
                }
            }
        }
        
        //normal point, writing
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,bl);
        ds_list_add(list_raw,c);
        
        xp_prev = xp;
        yp_prev = yp;
        c_prev = c;
        bl_prev = 0;
    }
    
        
    if (controller.exp_optimize)
    {
        if (bl_prev == 0)
        {
            xp_prev = xp;
            yp_prev = yp;
        }
    }
    bl_prev = 1;
}

if (controller.exp_optimize)
{
    //back to middle
    xp = $8000;
    yp = $8000;
    
    //BLANKING
    opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
    var t_true_dwell = controller.opt_maxdwell; //todo calculate from angles
    
    if (opt_dist < 200) //connecting segments
    {
        //dwell on blanking start
        repeat (controller.opt_maxdwell_blank)
        {
            ds_list_add(list_raw,xp_prev);
            ds_list_add(list_raw,yp_prev);
            ds_list_add(list_raw,0);
            ds_list_add(list_raw,c_prev);
        }
        repeat (t_true_dwell - controller.opt_maxdwell_blank )
        {
            ds_list_add(list_raw,xp_prev);
            ds_list_add(list_raw,yp_prev);
            ds_list_add(list_raw,1);
            ds_list_add(list_raw,0);
        }
    }
    else //not connecting segments
    {
        //dwell on blanking start
        repeat (controller.opt_maxdwell_blank)
        {
            ds_list_add(list_raw,xp_prev);
            ds_list_add(list_raw,yp_prev);
            ds_list_add(list_raw,0);
            ds_list_add(list_raw,c_prev);
        }
        repeat ( max(controller.opt_maxdwell_blank, t_true_dwell - controller.opt_maxdwell_blank) )
        {
            ds_list_add(list_raw,xp_prev);
            ds_list_add(list_raw,yp_prev);
            ds_list_add(list_raw,1);
            ds_list_add(list_raw,0);
        }
        
        //travel
        opt_vectorx = (xp_prev-xp)/opt_dist;
        opt_vectory = (yp_prev-yp)/opt_dist;
        
        //find number of steps and step size
        var t_trav_dist = a_ballistic; //todo calculate for angle
        var t_n = 1;
        var t_quantumsteps = 0;
        var t_totaldist = 0;
        while (1)
        {
            t_totaldist += (t_n + t_n-1)*t_trav_dist;
            t_quantumsteps += (t_n + t_n-1);
            if (t_totaldist > opt_dist)
                break;
            t_n++;
        }
        t_trav_dist -= (t_totaldist-opt_dist)/t_quantumsteps;
        var t_trav_dist_x = -t_trav_dist*(xp_prev-xp)/opt_dist;
        var t_trav_dist_y = -t_trav_dist*(yp_prev-yp)/opt_dist;
        
        //travel first and second half of segment
        var t_step_dist_x = 0;
        var t_step_dist_y = 0;
        var t_xp_now = xp_prev;
        var t_yp_now = yp_prev;
        
        for (k = 0; k < t_n; k++)
        {
            t_step_dist_x += t_trav_dist_x;
            t_step_dist_y += t_trav_dist_y;
            
            t_xp_now += t_step_dist_x;
            t_yp_now += t_step_dist_y;
            
            ds_list_add(list_raw,t_xp_now);
            ds_list_add(list_raw,t_yp_now);
            ds_list_add(list_raw,1);
            ds_list_add(list_raw,0);
        }
        for (k = 1; k < t_n; k++)
        {
            t_step_dist_x -= t_trav_dist_x;
            t_step_dist_y -= t_trav_dist_y;
            
            t_xp_now += t_step_dist_x;
            t_yp_now += t_step_dist_y;
            
            ds_list_add(list_raw,t_xp_now);
            ds_list_add(list_raw,t_yp_now);
            ds_list_add(list_raw,1);
            ds_list_add(list_raw,0);
        }
    }
}

ds_list_destroy(order_list);
ds_list_destroy(polarity_list);

//final removal or adding of ending points to match perfectly
if (controller.exp_optimize)
{
    if (ds_list_size(list_raw)/4-1 > t_totalpointswanted)
        {
        if (controller.opt_warning_flag != 1)
            {
            //show_message_async("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame [ "+string(j)+" ] or use the exported file at your own risk");
            controller.opt_warning_flag = 1;
            }
        log("Too many points: "+string(ds_list_size(list_raw)/4));
        }
    else while (ds_list_size(list_raw)/4 < t_totalpointswanted)
        {
        ds_list_add(list_raw,$8000);
        ds_list_add(list_raw,$8000);
        ds_list_add(list_raw,1);
        ds_list_add(list_raw,0);
        }
}

export_framelist_to_buffer();
