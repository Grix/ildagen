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
    var env_dataset = 0;
    layer = ds_list_find_value(layer_list, j);
    
    for (m = 1; m < ds_list_size(layer); m++)
        {
        objectlist = ds_list_find_value(layer,m);
        
        infolist =  ds_list_find_value(objectlist,2);
        frametime = round(ds_list_find_value(objectlist,0));
        object_length = ds_list_find_value(infolist,0);
        object_maxframes = ds_list_find_value(infolist,2);
        
        if (correctframe != clamp(correctframe, frametime, frametime+object_length))
            continue;
        
        //envelope transforms
        if (!env_dataset)
            {
            env_dataset = 1;
            
            var env_xtrans = 0;
            var env_ytrans = 0;
            var env_size = 0;
            var env_rotabs = 0;
            var env_a = 0;
            var env_hue = 0;
            var env_r = 0;
            var env_g = 0;
            var env_b = 0;
            
            envelope_list = ds_list_find_value(layer,0);
            for (u = 0; u < ds_list_size(envelope_list); u++)
                {
                envelope = ds_list_find_value(envelope_list,u);
                time_list = ds_list_find_value(envelope,1);
                
                if (ds_list_empty(time_list))
                    continue;
                    
                data_list = ds_list_find_value(envelope,2); 
                
                //binary search algo, set t_index to the current cursor pos
                var imin = 0;
                var imax = ds_list_size(time_list)-1;
                var imid;
                while (imin <= imax)
                    {
                    imid = floor(mean(imin,imax));
                    if (ds_list_find_value(time_list,imid) <= correctframe)
                        {
                        var valnext = ds_list_find_value(time_list,imid+1);
                        if (is_undefined(valnext)) or (valnext >= correctframe)
                            break;
                        else
                            imin = imid+1;
                        }
                    else
                        imax = imid-1;
                    }
                var t_index = imid;
                
                //interpolate
                var raw_data_value;
                if (t_index == ds_list_size(data_list)-1) or ( (t_index == 0) and (ds_list_find_value(time_list,t_index) >= correctframe) )
                    raw_data_value = ds_list_find_value(data_list,t_index);
                else
                    raw_data_value = lerp(  ds_list_find_value(data_list,t_index),
                                            ds_list_find_value(data_list,t_index+1),
                                            1-(ds_list_find_value(time_list,t_index+1)-correctframe)/
                                            (ds_list_find_value(time_list,t_index+1)-ds_list_find_value(time_list,t_index)));
                    
                //get value    
                type = ds_list_find_value(envelope,0);
                if (type == "x")
                    {
                    var env_xtrans = 1;
                    var env_xtrans_val = (raw_data_value-32)*1024;
                    }
                else if (type == "y")
                    {
                    var env_ytrans = 1;
                    var env_ytrans_val = (raw_data_value-32)*1024;
                    }
                else if (type == "size")
                    {
                    var env_size = 1;
                    var env_size_val = raw_data_value/32;
                    }
                else if (type == "rotabs")
                    {
                    var env_rotabs = 1;
                    var env_rotabs_val = (raw_data_value-32)/64*pi*2;
                    }
                else if (type == "a")
                    {
                    var env_a = 1;
                    var env_a_val = raw_data_value/64;
                    }
                else if (type == "hue")
                    {
                    var env_rotabs = 1;
                    var env_rotabs_val = (raw_data_value-32)/64*255;
                    }
                else if (type == "r")
                    {
                    var env_r = 1;
                    var env_r_val = raw_data_value/64;
                    }
                else if (type == "g")
                    {
                    var env_g = 1;
                    var env_g_val = raw_data_value/64;
                    }
                else if (type == "b")
                    {
                    var env_b = 1;
                    var env_b_val = raw_data_value/64;
                    }
                }
            }
        
        //draw object
        el_buffer = ds_list_find_value(objectlist,1);
        fetchedframe = (correctframe-frametime) mod object_maxframes;
        buffer_seek(el_buffer,buffer_seek_start,0);
        buffer_ver = buffer_read(el_buffer,buffer_u8);
        if (buffer_ver != 52)
            {
            show_message_async("Error: Unexpected version id reading buffer in refresh_seq_surface: "+string(buffer_ver)+". Things might get ugly. Contact developer.");
            surface_reset_target();
            exit;
            }
        buffer_maxframes = buffer_read(el_buffer,buffer_u32);
        
        //skip to correct frame
        for (i = 0; i < fetchedframe;i++)
            {
            numofel = buffer_read(el_buffer,buffer_u32);
            for (u = 0; u < numofel; u++)
                {
                numofdata = buffer_read(el_buffer,buffer_u32)-20;
                buffer_seek(el_buffer,buffer_seek_relative,50+numofdata*3.25);
                }
            }
            
        buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
        draw_set_alpha(1);
        
        //actual elements
        for (i = 0; i < buffer_maxelements;i++)
            {
            numofinds = buffer_read(el_buffer,buffer_u32);
            var repeatnum = (numofinds-20)/4-1;
            var buffer_start_pos = buffer_tell(el_buffer);
            
            //2d
            if (viewmode != 1)
                {
                xo = 187+buffer_read(el_buffer,buffer_f32)/480;
                yo = buffer_read(el_buffer,buffer_f32)/480;  
                buffer_seek(el_buffer,buffer_seek_relative,42);
                
                xp = buffer_read(el_buffer,buffer_f32);
                yp = buffer_read(el_buffer,buffer_f32);
                bl = buffer_read(el_buffer,buffer_bool);
                cl = buffer_read(el_buffer,buffer_u32);
                
                //apply envelope transforms
                if (env_xtrans)
                    {
                    xo += env_xtrans_val/480;
                    log(xo)
                    }
                if (env_ytrans)
                    {
                    yo += env_xtrans_val/480;
                    }
                
                surface_set_target(frame_surf);
                repeat (repeatnum)
                    {
                    //log(buffer_tell(el_buffer))
                    xpp = xp;
                    ypp = yp;
                    blp = bl;
                    
                    xp = buffer_read(el_buffer,buffer_f32);
                    yp = buffer_read(el_buffer,buffer_f32);
                    bl = buffer_read(el_buffer,buffer_bool);
                    c = buffer_read(el_buffer,buffer_u32);
                    if (!bl)
                        {
                        draw_set_color(c);
                        if ((xp == xpp) and (yp == ypp) and !blp)
                            {
                            draw_point(xo+xp/480,yo+yp/480);
                            }
                        else
                            draw_line(xo+ xpp/480,yo+ ypp/480,xo+ xp/480,yo+ yp/480);
                        }
                    }
                surface_reset_target();
                }
                
            //3d
            if (viewmode != 0)
                {
                buffer_seek(el_buffer,buffer_seek_start,buffer_start_pos);
                
                xo = 187+buffer_read(el_buffer,buffer_f32)/480;
                yo = buffer_read(el_buffer,buffer_f32)/480;  
                buffer_seek(el_buffer,buffer_seek_relative,42);
                
                xp = buffer_read(el_buffer,buffer_f32);
                yp = buffer_read(el_buffer,buffer_f32);
                bl = buffer_read(el_buffer,buffer_bool);
                cl = buffer_read(el_buffer,buffer_u32);
                
                draw_set_blend_mode(bm_add);
                draw_set_alpha(0.8);
                surface_set_target(frame3d_surf);
                
                repeat (repeatnum)
                    {
                    //log(buffer_tell(el_buffer))
                    xpp = xp;
                    ypp = yp;
                    blp = bl;
                    
                    xp = buffer_read(el_buffer,buffer_f32);
                    yp = buffer_read(el_buffer,buffer_f32);
                    bl = buffer_read(el_buffer,buffer_bool);
                    c = buffer_read(el_buffer,buffer_u32);
                    
                    if (!bl)
                        {
                        pdir = point_direction(256,68,xo+ xp/480,yo+ yp/480);
                        xxp = 256+cos(degtorad(-pdir))*512;
                        yyp = 68+sin(degtorad(-pdir))*512;
                        
                        if (xpp == xp) and (ypp == yp) and !(blp)
                            {
                            draw_set_alpha(0.9);
                            draw_line_colour(256,68,xxp,yyp,c,c_black);
                            draw_set_alpha(0.8);
                            }
                        else
                            {
                            pdir_p = point_direction(256,68,xo+ xpp/480,yo+ ypp/480);
                            xxp_p = 256+cos(degtorad(-pdir_p))*512;
                            yyp_p = 68+sin(degtorad(-pdir_p))*512;
                            draw_triangle_colour(256,68,xxp_p,yyp_p,xxp,yyp,c,c_black,c_black,0);
                            }
                        }
                    }
                draw_set_blend_mode(bm_normal);
                draw_set_alpha(1);
                surface_reset_target();  
                }
            }
        }
    }

  
draw_set_alpha(1);
draw_set_blend_mode(bm_normal);

    
