//refreshes the laser show preview surface in the sequencer mode room
if (controller.laseron)
    {
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_text(100,100,"Laser output active: "+string(controller.dac_string));
    draw_set_halign(fa_left);
    exit;
    }

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
            
            ready_envelope_applying(ds_list_find_value(layer,0));
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
            draw_enable_alphablend(0);
            if (viewmode != 1)
                {
                xo = 187+buffer_read(el_buffer,buffer_f32)/480;
                yo = buffer_read(el_buffer,buffer_f32)/480;  
                buffer_seek(el_buffer,buffer_seek_relative,42);
                
                apply_envelope_frame(480);
                    
                xp = buffer_read(el_buffer,buffer_f32);
                yp = buffer_read(el_buffer,buffer_f32);
                bl = buffer_read(el_buffer,buffer_bool);
                c = buffer_read(el_buffer,buffer_u32);
                
                apply_envelope_point();
                
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
                    
                    apply_envelope_point();
                    
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
            draw_enable_alphablend(1);
                
            //3d
            if (viewmode != 0)
                {
                buffer_seek(el_buffer,buffer_seek_start,buffer_start_pos);
                
                xo = 187+buffer_read(el_buffer,buffer_f32)/480;
                yo = buffer_read(el_buffer,buffer_f32)/480;  
                buffer_seek(el_buffer,buffer_seek_relative,42);
                
                apply_envelope_frame(480);
                
                xp = buffer_read(el_buffer,buffer_f32);
                yp = buffer_read(el_buffer,buffer_f32);
                bl = buffer_read(el_buffer,buffer_bool);
                c = buffer_read(el_buffer,buffer_u32);
                
                apply_envelope_point();
                
                draw_set_blend_mode(bm_add);
                draw_set_alpha(0.7);
                surface_set_target(frame3d_surf);
                
                repeat (repeatnum)
                    {
                    xpp = xp;
                    ypp = yp;
                    blp = bl;
                    
                    xp = buffer_read(el_buffer,buffer_f32);
                    yp = buffer_read(el_buffer,buffer_f32);
                    bl = buffer_read(el_buffer,buffer_bool);
                    c = buffer_read(el_buffer,buffer_u32);
                    
                    apply_envelope_point();
                    
                    if (!bl)
                        {
                        pdir = point_direction(256,68,xo+ xp/480,yo+ yp/480);
                        xxp = 256+cos(degtorad(-pdir))*512;
                        yyp = 68+sin(degtorad(-pdir))*512;
                        
                        if (xpp == xp) and (ypp == yp) and !(blp)
                            {
                            draw_set_alpha(0.9);
                            draw_line_colour(256,68,xxp,yyp,c,c_black);
                            draw_set_alpha(0.7);
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

    
