///make_screenshot(buffer)
//returns a surface with a preview of argument0, which is a buffer containing laser frames

temp_surf = surface_create(32,32);
el_buffer = argument0;
buffer_seek(el_buffer,buffer_seek_start,0);
buffer_ver = buffer_read(el_buffer,buffer_u8);
if (buffer_ver != 52)
    {
    show_message_async("Error: Unexpected ID byte in make_screenshot. Things might get ugly. Contact developer.");
    return temp_surf;
    }
buffer_maxframes = buffer_read(el_buffer,buffer_u32);
buffer_maxelements = buffer_read(el_buffer,buffer_u32);

surface_set_target(temp_surf);

draw_clear(c_black);

draw_set_alpha(1);

el_list = ds_list_create(); 

for (i = 0; i < buffer_maxelements;i++)
    {
    numofinds = buffer_read(el_buffer,buffer_u32);
    ind_list = ds_list_create();
    ds_list_add(el_list,ind_list);
    for (u = 0; u < 10; u++)
        {
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
        }
    for (u = 10; u < 20; u++)
        {
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
        }
    for (u = 20; u < numofinds; u += 4)
        {
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_u32));
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
    
    for (u = 0; u < (((ds_list_size(new_list)-20)/4)-1); u++)
        {
        currentpos = 20+u*4;
        nextpos = 20+(u+1)*4;
        
        if (ds_list_find_value(new_list,nextpos+2) == 0)
            {
            xp = ds_list_find_value(new_list,currentpos+0);
            yp = ds_list_find_value(new_list,currentpos+1);
            
            nxp = ds_list_find_value(new_list,nextpos+0);
            nyp = ds_list_find_value(new_list,nextpos+1);
            
            draw_set_color(ds_list_find_value(new_list,nextpos+3));
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
    
    