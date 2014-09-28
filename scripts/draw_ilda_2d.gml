//cycles through every element in frame on screen and draws them
draw_set_blend_mode(bm_add);
    
if (viewmode == 1) or (viewmode == 2)
    for (i = 0;i < ds_list_size(surf3d_list);i++)
        {
        if (surface_exists(ds_list_find_value(surf3d_list,i))) 
            draw_surface(ds_list_find_value(surf3d_list,i),0,0);
        }
        
if (viewmode == 2)
    draw_set_blend_mode(bm_normal);
    
if (viewmode == 0) or (viewmode == 2)
    for (i = 0;i < ds_list_size(surf_list);i++)
        {
        if (surface_exists(ds_list_find_value(surf_list,i))) 
            draw_surface(ds_list_find_value(surf_list,i),0,0);
        }


draw_set_blend_mode(bm_normal);