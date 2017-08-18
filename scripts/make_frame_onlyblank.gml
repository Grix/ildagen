if (debug_mode)
    log("make_frame_ob");
    
//var timerbm = get_timer();

var t_vectorx, t_vectory, t_true_dwell_falling, t_true_dwell_rising;
var t_blindzonelistsize = ds_list_size(controller.blindzone_list);
var t_contflag = false;

xp_prev = mid_x;
yp_prev = mid_y;
xp_prev_prev = mid_x;
yp_prev_prev = mid_y;
bl_prev = 1;
c_prev = 0;
new_dot = 1;

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
            xp = x_lowerbound+(xo+list_id[| currentpos+0])*x_scale;
            yp = y_lowerbound+($ffff-(yo+list_id[| currentpos+1]))*y_scale;
            c = list_id[| currentpos+3 ];
            ds_list_add(list_raw,xp);
            ds_list_add(list_raw,yp);
            ds_list_add(list_raw,bl);
            ds_list_add(list_raw,c);
            continue;
        }
        else 
        {
        
            if (list_id[| 10] != true)//if not blind zone
            {
                xp = x_lowerbound+(xo+list_id[| currentpos+0])*x_scale;
                yp = y_lowerbound+($ffff-(yo+list_id[| currentpos+1]))*y_scale;
                
                if ((yp >= $fffe) || (yp <= 1) || (xp >= $fffe) || (xp <= 1))
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
            }//end if !bl_prev
            
        }//end if !bl
        
        //normal point, writing
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,bl);
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

  
//log("make_frame",get_timer() - timerbm);
