frame = 0;

temp_surf = surface_create(32,32);
el_buffer = argument0;
buffer_ver = buffer_read(el_buffer,buffer_u8);
if (buffer_ver != 0)
    {
    show_message_async("Error: Unexpected byte. Contact developer.");
    return temp_surf;
    }
buffer_maxframes = buffer_read(el_buffer,buffer_s32);
buffer_maxelements = buffer_read(el_buffer,buffer_s32);

surface_set_target(temp_surf);

draw_clear(c_black);

draw_set_alpha(1);

el_list = ds_list_create(); 

for (i = 0; i < buffer_maxelements;i++)
    {
    numofinds = buffer_read(el_buffer,buffer_s32);
    ind_list = ds_list_create();
    ds_list_add(el_list,ind_list);
    for (u = 0; u < numofinds; u++)
        {
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_s32));
        }
    }

for (i = 0;i < ds_list_size(el_list);i++)
    {
    new_list = ds_list_find_value(el_list,i);
    
    if (ds_list_size(new_list) < 15)
        {
        ds_list_delete(el_list,i);
        ds_list_sort(el_list,0);
        continue;
        }
    
    xo = ds_list_find_value(new_list,0)/$ffff*32;
    yo = ds_list_find_value(new_list,1)/$ffff*32;
    
    //TODO if just one
    
    for (u = 0; u < (((ds_list_size(new_list)-50)/6)-1); u++)
        {
        nbl = ds_list_find_value(new_list,50+(u+1)*6+2);
        
        if (nbl == 0)
            {
            xp = ds_list_find_value(new_list,50+u*6+0);
            yp = ds_list_find_value(new_list,50+u*6+1);
            
            nxp = ds_list_find_value(new_list,50+(u+1)*6+0);
            nyp = ds_list_find_value(new_list,50+(u+1)*6+1);
            nb = ds_list_find_value(new_list,50+(u+1)*6+3);
            ng = ds_list_find_value(new_list,50+(u+1)*6+4);
            nr = ds_list_find_value(new_list,50+(u+1)*6+5);
            
            
            draw_set_color(make_colour_rgb(nr,ng,nb));
            if (xp == nxp) && (yp == nyp)
                {
                draw_point(xo+xp/$ffff*32,yo+yp/$ffff*32);
                }
            else
                draw_line(xo+ xp/$ffff*32,yo+ yp/$ffff*32,xo+ nxp/$ffff*32,yo+ nyp/$ffff*32);
            }
        
        }
    }

surface_reset_target();

for (i = 0;i < ds_list_size(el_list);i++)
    {
    ds_list_destroy(ds_list_find_value(el_list,i));
    }
ds_list_destroy(el_list);

return temp_surf;
    
    
