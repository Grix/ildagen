//cycles through every element in frame on screen and draws them
draw_set_blend_mode(bm_add);

for (i = 0;i < ds_list_size(el_list);i++)
    {
    if (surface_exists(ds_list_find_value(surf_list,i))) 
        draw_surface(ds_list_find_value(surf_list,i),0,0);
    }

draw_set_blend_mode(bm_normal);