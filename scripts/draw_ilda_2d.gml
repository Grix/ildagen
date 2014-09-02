//cycles through every element in frame on screen and draws them
draw_set_blend_mode(bm_add);

for (i = 0;i < ds_list_size(el_list);i++)
    {
    draw_surface(ds_list_find_value(surf_list,i),0,0);
    }
/*    list_id = ds_list_find_value(el_list,i);
    
    xo = ds_list_find_value(list_id,0)/128;
    yo = ds_list_find_value(list_id,1)/128;
    
    //TODO if just one
    
    for (u = 0; u < (((ds_list_size(list_id)-10)/6)-1); u++)
        {
        xp = ds_list_find_value(list_id,10+u*6+0);
        yp = ds_list_find_value(list_id,10+u*6+1);
        bl = ds_list_find_value(list_id,10+u*6+2);
        b = ds_list_find_value(list_id,10+u*6+3);
        g = ds_list_find_value(list_id,10+u*6+4);
        r = ds_list_find_value(list_id,10+u*6+5);
        
        nxp = ds_list_find_value(list_id,10+(u+1)*6+0);
        nyp = ds_list_find_value(list_id,10+(u+1)*6+1);
        nbl = ds_list_find_value(list_id,10+(u+1)*6+2);
        nb = ds_list_find_value(list_id,10+(u+1)*6+3);
        ng = ds_list_find_value(list_id,10+(u+1)*6+4);
        nr = ds_list_find_value(list_id,10+(u+1)*6+5);
        
        if (nbl == 0)
            {
            draw_set_color(make_colour_rgb(nr,ng,nb));
            if (xp == nxp) && (yp == nyp)
                {
                draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                }
            else
                draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
            }
        
        }
    
    }
    
*/draw_set_blend_mode(bm_normal);