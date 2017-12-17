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
        
        if (list_id[| 10] != true)//if not blind zone
        {
			var t_x = xo+list_id[| currentpos+0];
			var t_y = $ffff-(yo+list_id[| currentpos+1]);
	        xp = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*(($ffff-t_y)/$ffff)+t_x*(x_scale_top+(x_scale_bottom-x_scale_top)*(($ffff-t_y)/$ffff));
	        yp = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*(t_x/$ffff)+t_y*(y_scale_left+(y_scale_right-y_scale_left)*(t_x/$ffff));
            
            if ((yp >= $ffff) || (yp <= 0) || (xp >= $ffff) || (xp <= 0))
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
        ds_list_add(list_raw,0);
        ds_list_add(list_raw,c);
    }
        
    bl_prev = 1;
}
  
ds_list_destroy(order_list);
ds_list_destroy(polarity_list);

//log("make_frame",get_timer() - timerbm);
