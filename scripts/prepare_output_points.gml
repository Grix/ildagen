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

//walk through list to get lit length and static point count
var t_i;
for (t_i = 0; t_i < listsize; t_i++)
{
    currentpos += currentposadjust;
    //getting values from element list
    
    bl = ds_list_find_value(list_id,currentpos+2);
    
    if (bl)
    {
        bl_prev = 1;
        continue;
    }
    //check if outside bounds
    xp = xo + list_id[| currentpos ];
    yp = $ffff - (yo + list_id[| currentpos+1 ]);
    
    if ((yp >= $fffe) || (yp <= 1) || (xp >= $fffe) || (xp <= 1)) //todo add safety zone check
    {
        list_id[| currentpos+2 ] = 1;
        bl_prev = 1;
        continue;
    }
    
    //valid point, process it
    
    //c = ds_list_find_value(list_id,currentpos+3);
    
    if (controller.exp_optimize)
    {
        opt_dist = point_distance(xp,yp,xp_prev,yp_prev);
        
        if (bl_prev)
        {
            //todo maybe add reference to current position so we don't 
            //have to parse through all blanked points when writing
        
            //BLANKING
            var t_true_dwell = controller.opt_maxdwell; //todo calculate from angles
            
            if (opt_dist < 200) //connecting segments
            {
                maxpoints_static += ( (controller.opt_maxdwell_blank)*2
                                       + abs(t_true_dwell - controller.opt_maxdwell_blank*2) );
            }
            else
            {
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
                     
                maxpoints_static += (   2*(controller.opt_maxdwell_blank) 
                                        +  2*max(controller.opt_maxdwell_blank, t_true_dwell - controller.opt_maxdwell_blank)
                                        +  (t_n + t_n) );
            }
        }
        else
            lit_length+= opt_dist;
        
        if (opt_dist == 0)
        {
            maxpoints_dots++;
            currentdotsize++;
            new_dot = 1;
        }
        else
        {
            if ((new_dot) && (currentdotsize > 1))
            {
                num_dots++;
                maxpoints_dots++;
                if (currentdotsize < smallestdotsize)
                    smallestdotsize = currentdotsize;
                currentdotsize = 0;
            }
            new_dot = 0;
        }
    }
    
        
    xp_prev = xp;
    yp_prev = yp;
    //c_prev = c;
    bl_prev = 0;
}

if ((new_dot) && (currentdotsize > 1))
{
    num_dots++;
    maxpoints_dots++;
    if (currentdotsize < smallestdotsize)
        smallestdotsize = currentdotsize;
    currentdotsize = 0;
}




