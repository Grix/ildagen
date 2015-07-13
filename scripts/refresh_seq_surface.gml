//refreshes the laser show preview surface in the sequencer mode room
if (!surface_exists(frame_surf))
    frame_surf = surface_create(512,512);
if (!surface_exists(frame3d_surf))
    frame3d_surf = surface_create(512,512);

if (viewmode != 1)
    {
    surface_set_target(frame_surf);
    draw_clear_alpha(c_white,0);
    surface_reset_target();
    }

if (viewmode != 0)
    {
    surface_set_target(frame3d_surf);
    draw_clear(c_black);
    surface_reset_target();
    }

correctframe = round(tlpos/1000*projectfps);
    
//check which should be drawn
for (j = 0; j < ds_list_size(layer_list); j++)
    {
    layer = ds_list_find_value(layer_list, j);
    for (m = 0; m < ds_list_size(layer); m++)
        {
        objectlist = ds_list_find_value(layer,m);
        
        infolist =  ds_list_find_value(objectlist,2);
        frametime = round(ds_list_find_value(objectlist,0));
        object_length = ds_list_find_value(infolist,0);
        object_maxframes = ds_list_find_value(infolist,2);
        
        if (correctframe != clamp(correctframe, frametime, frametime+object_length))
            continue;
        
        //draw object
        el_buffer = ds_list_find_value(objectlist,1);
        fetchedframe = (correctframe-frametime) mod object_maxframes;
        buffer_seek(el_buffer,buffer_seek_start,0);
        buffer_ver = buffer_read(el_buffer,buffer_u8);
        if (buffer_ver != 51)
            {
            show_message_async("Error: Unexpected byte. Things might get ugly. Contact developer.");
            surface_reset_target();
            exit;
            }
        buffer_maxframes = buffer_read(el_buffer,buffer_u32);
        
        el_list = ds_list_create(); 
        
        //skip to correct frame
        for (i = 0; i < fetchedframe;i++)
            {
            numofel = buffer_read(el_buffer,buffer_u32);
            for (u = 0; u < numofel; u++)
                {
                numofdata = buffer_read(el_buffer,buffer_u32)-50;
                buffer_seek(el_buffer,buffer_seek_relative,10*4+40+numofdata*2);
                }
            }
            
        buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
        //make into lists
        for (i = 0; i < buffer_maxelements;i++)
            {
            numofinds = buffer_read(el_buffer,buffer_u32);
            ind_list = ds_list_create();
            ds_list_add(el_list,ind_list);
            for (u = 0; u < 10; u++)
                {
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                }
            for (u = 10; u < 50; u++)
                {
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
                }
            for (u = 50; u < numofinds; u += 6)
                {
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_u8));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_u8));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_u8));
                }
            }
            
        draw_set_alpha(1);
        
        //parse lists and draw
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            new_list = ds_list_find_value(el_list,i);
            
            if (ds_list_size(new_list) < 15)
                {
                ds_list_delete(el_list,i);
                ds_list_sort(el_list,0);
                continue;
                }
            xo = 187+ds_list_find_value(new_list,0)/409;
            yo = ds_list_find_value(new_list,1)/409;    
            listsize = (((ds_list_size(new_list)-50)/6)-1);
            
            //2d
            if (viewmode != 1)
                {
                surface_set_target(frame_surf);
                for (u = 0; u < listsize; u++)
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
                            draw_point(xo+xp/409,yo+yp/409);
                            }
                        else
                            draw_line(xo+ xp/409,yo+ yp/409,xo+ nxp/409,yo+ nyp/409);
                        }
                    }
                surface_reset_target();
                }
            
            //3d
            if (viewmode != 0)
                {
                surface_set_target(frame3d_surf);
                draw_set_blend_mode(bm_add);
                draw_set_alpha(0.7);
                
                for (u = 0; u < listsize; u++)
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
                        
                        pdir = point_direction(256,68,xo+ xp/409,yo+ yp/409);
                        npdir = point_direction(256,68,xo+ nxp/409,yo+ nyp/409);
                        xxp = 256+cos(degtorad(-pdir))*400;
                        yyp = 68+sin(degtorad(-pdir))*400;
                        nxxp = 256+cos(degtorad(-npdir))*400;
                        nyyp = 68+sin(degtorad(-npdir))*400;
                        
                        colorp = make_colour_rgb(nr,ng,nb);
                        colorpfade = make_colour_rgb(nr/9,ng/9,nb/9);
                        
                        if (xp == nxp) && (yp == nyp)
                            {
                            draw_set_alpha(1);
                            draw_line_colour(256,68,xxp,yyp,colorp,colorpfade);
                            draw_set_alpha(0.85);
                            }
                        else
                            draw_triangle_colour(256,68,xxp,yyp,nxxp,nyyp,colorp,colorpfade,colorpfade,0);
                        }
                    }
                draw_set_blend_mode(bm_normal);
                draw_set_alpha(1);
                surface_reset_target();  
                }
            }
        
        //cleanup
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            ds_list_destroy(ds_list_find_value(el_list,i));
            }
        ds_list_destroy(el_list);
        }
    }

  
draw_set_alpha(1);
draw_set_blend_mode(bm_normal);

    
