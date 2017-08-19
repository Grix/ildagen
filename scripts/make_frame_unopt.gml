if (debug_mode)
    log("make_frame_unopt");
    
//var timerbm = get_timer();

var t_blindzonelistsize = ds_list_size(controller.blindzone_list);

bl_prev = 1;
c_prev = 0;

//parse elements
var t_numofelems = ds_list_size(el_list);
  

for (i = 0; i < t_numofelems; i++)
{
    list_id = ds_list_find_value(el_list,i); 
        
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
        
        if (list_id[| 10] != true)//if not blind zone
        {
            xp = x_lowerbound+(xo+list_id[| currentpos+0])*x_scale;
            yp = y_lowerbound+($ffff-(yo+list_id[| currentpos+1]))*y_scale;
            
            if ((yp >= $fffe) || (yp <= 1) || (xp >= $fffe) || (xp <= 1))
            {
                bl = 1;
            }
            else for (jj = 0; jj < t_blindzonelistsize; jj += 4)
            {
                if ((xp > controller.blindzone_list[| jj+0]) 
                &&  (xp < controller.blindzone_list[| jj+1])
                &&  (yp < $FFFF-controller.blindzone_list[| jj+2]) 
                &&  (yp > $FFFF-controller.blindzone_list[| jj+3]))
                {
                    bl = 1;
                }
            }
        }
        else
        {   
            //is blind zone, no scaling or blanking
            xp = xo+list_id[| currentpos+0];
            yp = $ffff-(yo+list_id[| currentpos+1]);
        }
        
        if (bl || bl_prev)
        {
            //BLANKING
            ds_list_add(list_raw,xp);
            ds_list_add(list_raw,yp);
            ds_list_add(list_raw,1);
            ds_list_add(list_raw,0);
            bl_prev = 0;
            continue;
        }
        
        c = list_id[| currentpos+3 ];
        
        //normal point, writing
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,bl);
        ds_list_add(list_raw,c);
    }
        
    bl_prev = 1;
}
  
ds_list_destroy(order_list);
ds_list_destroy(polarity_list);

//log("make_frame",get_timer() - timerbm);
