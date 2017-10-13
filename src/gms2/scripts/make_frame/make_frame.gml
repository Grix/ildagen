if (debug_mode)
    log("make_frame");
    
//var timerbm = get_timer();

var t_vectorx, t_vectory, t_true_dwell_falling, t_true_dwell_rising;
var t_blindzonelistsize = ds_list_size(controller.blindzone_list);
var t_contflag = false;

var t_totalrem = 0;
var t_totalpointswanted = floor(controller.opt_scanspeed/controller.projectfps);
var t_litpointswanted = t_totalpointswanted - maxpoints_static - maxpoints_dots - 3;

if (t_litpointswanted == 0) 
    t_litpointswanted = 1;
var t_lengthwanted = abs(lit_length/t_litpointswanted);

xp_prev = mid_x;
yp_prev = mid_y;
xp_prev_prev = mid_x;
yp_prev_prev = mid_y;
bl_prev = 1;
c_prev = 0;
new_dot = 1;

//if too many dots in frame, first attempt to shrink overlapping ones
if (lit_length > 0)
{
    var t_dotstodelete = 0;
    while ((t_lengthwanted > 1000) && (maxpoints_dots != 0) && (smallestdotsize > 3)) //todo create setting for 1000
    {
        t_dotstodelete++;
        t_litpointswanted += num_dots;
        if (t_litpointswanted == 0) 
            t_litpointswanted = 1;
        t_lengthwanted = abs(lit_length/t_litpointswanted);
        smallestdotsize--;
    }
}
else
{
    var t_dotstoadd = floor((t_litpointswanted+maxpoints_dots)/num_dots);
}

if (t_lengthwanted == 0) 
{
    t_lengthwanted = 0.0001; //to avoid dividing by zero
}

//parse elements
var t_numofelems = ds_list_size(order_list);
  

for (i = 0; i < t_numofelems; i++)
{
    list_id = ds_list_find_value(el_list,order_list[| i]);
        
    if (is_undefined(list_id))
        continue;

    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
       
    //writing points in element list
    listsize = ((ds_list_size(list_id)-20)/4);

    if (polarity_list[| i] == 0)
    {
        currentpos = 20;
        currentposadjust = 4;
    }
    else
    {
        currentpos = ds_list_size(list_id)-4;
        currentposadjust = -4;
      
    }
    
    var t_i;
    for (t_i = 1; t_i < listsize; t_i++)
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
        
            if (list_id[| 10] != true)//if not blind zone
            {
                xp = x_lowerbound+(xo+list_id[| currentpos+0])*x_scale;
                yp = y_lowerbound+($ffff-(yo+list_id[| currentpos+1]))*y_scale;
                
                if ((yp >= $ffff) || (yp <= 0) || (xp >= $ffff) || (xp <= 0))
                {
                    //list_id[| currentpos+2 ] = 1;
                    bl_prev = 1;
                    continue;
                }
                
                for (jj = 0; jj < t_blindzonelistsize; jj += 4)
                {
                    if ((xp > controller.blindzone_list[| jj+0]) 
                    &&  (xp < controller.blindzone_list[| jj+1])
                    &&  (yp < $FFFF-controller.blindzone_list[| jj+2]) 
                    &&  (yp > $FFFF-controller.blindzone_list[| jj+3]))
                    {
                        //list_id[| currentpos+2 ] = 1;
                        bl_prev = 1;
                        continue;
                    }
                }
            }
            else
            {   
                //is blind zone, no scaling or blanking
                xp = xo+list_id[| currentpos+0];
                yp = $ffff-(yo+list_id[| currentpos+1]);
            }
                    
            //valid lit point, process it
            
            c = list_id[| currentpos+3 ];
            
            if (bl_prev)
            {
                //BLANKING
                var t_prevpos = currentpos-currentposadjust;
                xpp = x_lowerbound+(xo+list_id[| t_prevpos+0])*x_scale;
                ypp = y_lowerbound+($ffff-(yo+list_id[| t_prevpos+1]))*y_scale;
                
                if ((ypp >= $ffff) || (ypp <= 0) || (xpp >= $ffff) || (xpp <= 0))
                {
                    continue;
                }
                
                for (jj = 0; jj < t_blindzonelistsize; jj += 4)
                {
                    if ((xpp > controller.blindzone_list[| jj+0]) 
                    &&  (xpp < controller.blindzone_list[| jj+1])
                    &&  (ypp < $FFFF-controller.blindzone_list[| jj+2]) 
                    &&  (ypp > $FFFF-controller.blindzone_list[| jj+3]))
                    {
                        continue;
                    }
                }
            
                opt_dist = point_distance(xp_prev,yp_prev,xpp,ypp);
                
                if (opt_dist < 250) //connecting segments
                {
                    angle_next = point_direction(xp,yp, xpp,ypp);
                    angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
                
                    t_true_dwell_falling =  round(controller.opt_maxdwell * 
                                            (1- abs(angle_difference( angle_prev, angle_next ))/180));
                                            
                    //dwell on blanking start
                    repeat (controller.opt_maxdwell_blank)
                    {
                        ds_list_add(list_raw,xp_prev);
                        ds_list_add(list_raw,yp_prev);
                        ds_list_add(list_raw,0);
                        ds_list_add(list_raw,c_prev);
                    }
                    repeat (t_true_dwell_falling - controller.opt_maxdwell_blank*2 )
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
                    angle_blank = point_direction(xpp,ypp, xp_prev,yp_prev);
                    
                    if ((xpp == xp) && (ypp == yp))
                    {
                        t_true_dwell_falling = round(controller.opt_maxdwell*0.2);
                    }
                    else
                    {
                        angle_next = point_direction(xpp,ypp, xp,yp);
                        
                        t_true_dwell_falling =  round(controller.opt_maxdwell * 
                                                (1- abs(angle_difference( angle_blank, angle_next ))/180));
                    }
                    
                    if ((xp_prev_prev == xp_prev) && (yp_prev_prev == yp_prev))
                    {
                        t_true_dwell_rising = round(controller.opt_maxdwell*0.2);
                    }
                    else
                    {
                        angle_prev = point_direction(xp_prev_prev,yp_prev_prev, xp_prev,yp_prev);
                
                        t_true_dwell_rising =  round(controller.opt_maxdwell * 
                                                (1- abs(angle_difference( angle_prev, angle_blank ))/180));
                    }
                
                    //dwell on blanking start
                    repeat (controller.opt_maxdwell_blank)
                    {
                        ds_list_add(list_raw,xp_prev);
                        ds_list_add(list_raw,yp_prev);
                        ds_list_add(list_raw,0);
                        ds_list_add(list_raw,c_prev);
                    }
                    repeat ( max(controller.opt_maxdwell_blank, t_true_dwell_rising - controller.opt_maxdwell_blank) )
                    {
                        ds_list_add(list_raw,xp_prev);
                        ds_list_add(list_raw,yp_prev);
                        ds_list_add(list_raw,1);
                        ds_list_add(list_raw,0);
                    }
                    
                    new_dot = 1;
                    
                    //travel
                    opt_vectorx = (xp_prev-xpp)/opt_dist;
                    opt_vectory = (yp_prev-ypp)/opt_dist;
                    
                    //find number of steps and step size
                    var t_trav_dist = a_ballistic;
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
                    var t_trav_dist_x = -t_trav_dist*(xp_prev-xpp)/opt_dist;
                    var t_trav_dist_y = -t_trav_dist*(yp_prev-ypp)/opt_dist;
                    
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
                    
                    repeat ( max(controller.opt_maxdwell_blank, t_true_dwell_falling - controller.opt_maxdwell_blank) )
                    {
                        ds_list_add(list_raw,xpp);
                        ds_list_add(list_raw,ypp);
                        ds_list_add(list_raw,1);
                        ds_list_add(list_raw,0);
                    }
                    repeat (controller.opt_maxdwell_blank)
                    {
                        ds_list_add(list_raw,xpp);
                        ds_list_add(list_raw,ypp);
                        ds_list_add(list_raw,0);
                        ds_list_add(list_raw,c);
                    }
                    
                }
                bl_prev = 0;
                xp_prev_prev = xp_prev;
                yp_prev_prev = yp_prev;
                xp_prev = xpp;
                yp_prev = ypp;
                c_prev = c;
            }
            
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
                                ds_list_add(list_raw,0);
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
        }//end if !bl
        
        if (!bl_prev && (opt_dist != 0) && lit_length)
        {
            //INTERPOLATE
            if (opt_dist < t_lengthwanted)
            {
                //skip point
                currentpos += currentposadjust;
                if (currentpos < ds_list_size(list_id)-1)
                {
                    t_i++;
                    t_totalrem -= opt_dist;
                    continue;
                } //todo draw to the end if skipped?
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
                stepscount = round(steps+1);
                t_vectorx = (xp-xp_prev)/stepscount;
                t_vectory = (yp-yp_prev)/stepscount;
                
                for (u = 1; u < stepscount; u++)
                {
                    ds_list_add(list_raw,xp_prev+t_vectorx*(u));
                    ds_list_add(list_raw,yp_prev+t_vectory*(u));
                    ds_list_add(list_raw,0);
                    ds_list_add(list_raw,c);
                }
            }
        }
        
        //normal point, writing
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,0);
        ds_list_add(list_raw,c);
        
        bl_prev = 0;
        xp_prev_prev = xp_prev;
        yp_prev_prev = yp_prev;
        xp_prev = xp;
        yp_prev = yp;
        c_prev = c;
    }
        
    bl_prev = 1;
}

//back to middle
xp = mid_x;
yp = mid_y;

//BLANKING
opt_dist = point_distance(xp_prev,yp_prev,xp,yp);

if (opt_dist < 250) //connecting segments
{
    t_true_dwell_falling = controller.opt_maxdwell; //worst case
                            
    //dwell on blanking start
    repeat (controller.opt_maxdwell_blank)
    {
        ds_list_add(list_raw,xp_prev);
        ds_list_add(list_raw,yp_prev);
        ds_list_add(list_raw,0);
        ds_list_add(list_raw,c_prev);
    }
    repeat (t_true_dwell_falling - controller.opt_maxdwell_blank )
    {
        ds_list_add(list_raw,xp_prev);
        ds_list_add(list_raw,yp_prev);
        ds_list_add(list_raw,1);
        ds_list_add(list_raw,0);
    }
}
else //not connecting segments
{
    if ((xp_prev_prev == xp_prev) && (yp_prev_prev == yp_prev))
    {
        t_true_dwell_rising = round(controller.opt_maxdwell*0.2);
    }
    else
    {
        angle_blank = point_direction(xp,yp, xp_prev,yp_prev);
        angle_prev = point_direction(xp_prev_prev,yp_prev_prev, xp_prev,yp_prev);

        t_true_dwell_rising =  round(controller.opt_maxdwell * 
                                (1- abs(angle_difference( angle_prev, angle_blank ))/180));
    }
    
    //dwell on blanking start
    repeat (controller.opt_maxdwell_blank)
    {
        ds_list_add(list_raw,xp_prev);
        ds_list_add(list_raw,yp_prev);
        ds_list_add(list_raw,0);
        ds_list_add(list_raw,c_prev);
    }
    repeat ( max(controller.opt_maxdwell_blank, t_true_dwell_rising - controller.opt_maxdwell_blank) )
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
    var t_trav_dist = a_ballistic;
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
  
ds_list_destroy(order_list);
ds_list_destroy(polarity_list);

//final removal or adding of ending points to match perfectly
if (ds_list_size(list_raw)/4-1 > t_totalpointswanted)
{
    /*if (controller.opt_warning_flag != 1)
    {
        //show_message_new("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame [ "+string(j)+" ] or use the exported file at your own risk");
        controller.opt_warning_flag = 1;
    }*/
}
else while (ds_list_size(list_raw)/4 < t_totalpointswanted)
{
    ds_list_add(list_raw,mid_x);
    ds_list_add(list_raw,mid_y);
    ds_list_add(list_raw,1);
    ds_list_add(list_raw,0);
}
  
//log("make_frame",get_timer() - timerbm);
