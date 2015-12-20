list_id = ds_list_find_value(el_list,i);
list_raw = ds_list_create();

xo = ds_list_find_value(list_id,0);
yo = ds_list_find_value(list_id,1);
    
//middle
xp_prev = $8000;
yp_prev = $8000;
bl_prev = 1;

for (i = 0;i < ds_list_size(el_list);i++)
    {
    list_id = ds_list_find_value(el_list,i);
    
    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
    
    listsize = ((ds_list_size(list_id)-20)/4);
    
    currentpos = 16;
    
    for (u = 0; u < listsize; u++)
        {
        currentpos += 4;
        //getting values from element list
        
        bl = ds_list_find_value(list_id,currentpos+2);
        xp = xo+ds_list_find_value(list_id,currentpos+0);
        yp = $ffff-(yo+ds_list_find_value(list_id,currentpos+1));
        if (bl != 0)
            {
            if (yp > ($ffff)) or (yp < 0) or (xp > ($ffff)) or (xp < 0)
                {
                bl = 1;
                }
            }
            
        if (bl)
            {
            if (controller.exp_optimize)
                {
                if (bl_prev == 0)
                    {
                    repeat (controller.opt_maxdwell)
                        {
                        //dwell on blanking start
                        ds_list_add(list_raw,xp);
                        ds_list_add(list_raw,yp);
                        ds_list_add(list_raw,1);
                        ds_list_add(list_raw,0);
                        }
                    }
                xp_prev = xp;
                yp_prev = yp;
                bl_prev = bl;
                }
            continue;
            }
        else if (bl_prev)
            {
            if (controller.exp_optimize)
                {
                //interpolate blanking
                opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
                opt_vectorx = (xp_prev-xp)/opt_dist;
                opt_vectory = (yp_prev-yp)/opt_dist;
                trav = -controller.opt_maxdist;
                for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
                    {
                    xp_now = xp_prev+opt_vectorx*trav_dist;
                    yp_now = yp_prev+opt_vectory*trav_dist;
                    
                    ds_list_add(list_raw,xp_now);
                    ds_list_add(list_raw,yp_now);
                    ds_list_add(list_raw,1);
                    ds_list_add(list_raw,0);
                    }
                }
            ds_list_add(list_raw,xp);
            ds_list_add(list_raw,yp);
            ds_list_add(list_raw,1);
            ds_list_add(list_raw,0);
            if (controller.exp_optimize)
                {
                repeat (controller.opt_maxdwell-1)
                    {
                    //dwell on blanking end
                    ds_list_add(list_raw,xp);
                    ds_list_add(list_raw,yp);
                    ds_list_add(list_raw,bl);
                    ds_list_add(list_raw,c);
                    }
                }
            }
        
        if (controller.exp_optimize)
            lit_length += point_distance(xp,yp,xp_prev,yp_prev);
        
        c = ds_list_find_value(list_id,currentpos+3);
        if (is_undefined(c))
            c = 0; //black
            
        xp_prev = xp;
        yp_prev = yp;
        bl_prev = bl;
            
        //writing point
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,bl);
        ds_list_add(list_raw,c);
        }
    }
    
if (controller.exp_optimize)
    {
    //back to middle
    xp = $8000;
    yp = $8000;
    //interpolate blanking
    opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
    opt_vectorx = (xp_prev-xp)/opt_dist;
    opt_vectory = (yp_prev-yp)/opt_dist;
    trav = -controller.opt_maxdist;
    for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
        {
        xp_now = xp_prev+opt_vectorx*trav_dist;
        yp_now = yp_prev+opt_vectory*trav_dist;
        
        ds_list_add(list_raw,xp_now);
        ds_list_add(list_raw,yp_now);
        ds_list_add(list_raw,1);
        ds_list_add(list_raw,0);
        }
    repeat (controller.opt_maxdwell)
        {
        //dwell on blanking start
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,1);
        ds_list_add(list_raw,0);
        }
    }
