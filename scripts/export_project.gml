//exports project into an ilda file
ilda_cancel();

file_loc = get_save_filename_ext("*.ild","example.ild","","Select ILDA file location");
if (file_loc == "")
    exit;
ilda_buffer = buffer_create(1,buffer_grow,1);

maxpointstot = 0;    
maxpoints = 0;

//stupid GM can't choose endian type
maxframespost = endframe-startframe;
maxframesa[0] = maxframespost & 255;
maxframespost = maxframespost >> 8;
maxframesa[1] = maxframespost & 255;

c_n = 0;
c_map = ds_map_create();
var env_dataset = 0;

for (j = startframe; j < endframe;j++)
    {
    correctframe = j;
    framepost = j-startframe;
    framea[0] = framepost & 255;
    framepost = framepost >> 8;
    framea[1] = framepost & 255;   
    
    buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
    buffer_write(ilda_buffer,buffer_u8,$4C);
    buffer_write(ilda_buffer,buffer_u8,$44);
    buffer_write(ilda_buffer,buffer_u8,$41);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,controller.exp_format);
    buffer_write(ilda_buffer,buffer_u8,ord('L')); //name
    buffer_write(ilda_buffer,buffer_u8,ord('S'));
    buffer_write(ilda_buffer,buffer_u8,ord('G'));
    buffer_write(ilda_buffer,buffer_u8,ord('e'));
    buffer_write(ilda_buffer,buffer_u8,ord('n'));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord('G')); //author
    buffer_write(ilda_buffer,buffer_u8,ord('i'));
    buffer_write(ilda_buffer,buffer_u8,ord('t'));
    buffer_write(ilda_buffer,buffer_u8,ord('l'));
    buffer_write(ilda_buffer,buffer_u8,ord('e'));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord('M'));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    maxpointspos = buffer_tell(ilda_buffer);
    buffer_write(ilda_buffer,buffer_u16,0); //maxpoints
    buffer_write(ilda_buffer,buffer_u8,framea[1]); //frame
    buffer_write(ilda_buffer,buffer_u8,framea[0]); //frame
    buffer_write(ilda_buffer,buffer_u8,maxframesa[1]); //maxframes
    buffer_write(ilda_buffer,buffer_u8,maxframesa[0]); 
    buffer_write(ilda_buffer,buffer_u8,0); //scanner
    buffer_write(ilda_buffer,buffer_u8,0); //0
        
    el_list = ds_list_create(); 
    var env_dataset = 0;
    
    //check which should be drawn
    for (k = 0; k < ds_list_size(layer_list); k++)
        {
        env_dataset = 0;
        
        layer = ds_list_find_value(layer_list, k);
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
            
            //yup, draw object
            el_buffer = ds_list_find_value(objectlist,1);
            fetchedframe = (correctframe-frametime) mod object_maxframes;
            buffer_seek(el_buffer,buffer_seek_start,0);
            buffer_ver = buffer_read(el_buffer,buffer_u8);
            if (buffer_ver != 52)
                {
                show_message_async("Error: Unexpected idbyte in buffer for export_project. Things might get ugly. Contact developer.");
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
                //envelope transforms
                if (env_xtrans)
                    {
                    ds_list_replace(ind_list,0,ds_list_find_value(ind_list,0) + env_xtrans_val);
                    }
                if (env_ytrans)
                    {
                    ds_list_replace(ind_list,1,ds_list_find_value(ind_list,1) + env_ytrans_val);
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
                    //apply envelope transforms to point data
                    if (env_hue)
                        {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_hsv(  (colour_get_hue(c)+env_hue_val) mod 255,
                                                                                            colour_get_saturation(c),
                                                                                            colour_get_value(c)));
                        }
                    if (env_a)
                        {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,merge_colour(c,c_black,env_a_val));
                        }
                    if (env_r)
                        {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  colour_get_red(c)*env_r_val,
                                                                                            colour_get_green(c),
                                                                                            colour_get_blue(c)));
                        }
                    if (env_g)
                        {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  colour_get_red(c),
                                                                                            colour_get_green(c)*env_g_val,
                                                                                            colour_get_blue(c)));
                        }
                    if (env_b)
                        {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  colour_get_red(c),
                                                                                            colour_get_green(c),
                                                                                            colour_get_blue(c)*env_b_val));
                        }
                    }
                }
                    
            }
        
        }
    
    if (!ds_list_size(el_list)) 
        {
        optimize_middle();
        //update maxpoints
        maxpointspre = maxpoints;
        maxpointsa[0] = maxpoints & 255;
        maxpoints = maxpoints >> 8;
        maxpointsa[1] = maxpoints & 255;
        buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
        buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
        maxpointstot += maxpointspre;
        maxpoints = 0;
        continue;
        }
    
    //optimize first
    if (controller.exp_optimize == 1)
        {
        optimize_first();
        }
    
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        list_id = ds_list_find_value(el_list,i);
        
        xo = ds_list_find_value(list_id,0);
        yo = ds_list_find_value(list_id,1);
        
        blanktemp = 0;
        
        //TODO if just one
        
        listsize = ((ds_list_size(list_id)-20)/4);
        
        blankprev = 0;
        for (u = 0; u < listsize; u++)
            {
            currentpos = 20+u*4;
            //getting values from element list
            
            bl = ds_list_find_value(list_id,currentpos+2);
            
            xp = xo+ds_list_find_value(list_id,currentpos+0);
            yp = $ffff-(yo+ds_list_find_value(list_id,currentpos+1));
            if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
                {
                blanktemp = 1;
                continue;
                }
            
            c = ds_list_find_value(list_id,currentpos+3);
            if (is_undefined(c)) and (bl)
                c = c_black;
                
            //find closest palette color
            if (controller.exp_format == 0)
                {
                var t_c_mapvalue = c_map[? c];
                if (!is_undefined(t_c_mapvalue))
                    c = t_c_mapvalue;
                else
                    {
                    diff_best = 200;
                    var t_diff;
                    var t_pal_c;
                    for (n = 0; n < round(ds_list_size(controller.pal_list)/3); n++)
                        {
                        t_pal_c = make_colour_rgb(controller.pal_list[| n*3], controller.pal_list[| n*3+1], controller.pal_list[| n*3+2]);
                        t_diff = colors_compare_cie94(c, t_pal_c);
                        if (t_diff < 3)
                            {
                            c_n = n;
                            break;
                            }
                        else if (t_diff < diff_best)
                            {
                            c_n = n;
                            diff_best = t_diff;
                            }
                        }
                    c_map[? c] = c_n;
                    c = c_n;
                    }
                }
            
            //adjusting values for writing to buffer
            xpe = xp;
            ype = yp;
            
            xp -= $8000;
            yp -= $8000;
            xpa[0] = xp & 255;
            xp = xp >> 8;
            xpa[1] = xp & 255;
            ypa[0] = yp & 255;
            yp = yp >> 8;
            ypa[1] = yp & 255;
            
            if (controller.exp_optimize == 1) and (bl != blankprev)
                {
                repeat (controller.opt_maxdwell)
                    {
                    //writing point
                    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
                    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                    if (controller.exp_format == 5)
                        {
                        buffer_write(ilda_buffer,buffer_u8,bl);
                        buffer_write(ilda_buffer,buffer_u8,colour_get_blue(c));
                        buffer_write(ilda_buffer,buffer_u8,colour_get_green(c));
                        buffer_write(ilda_buffer,buffer_u8,colour_get_red(c));
                        }
                    else
                        {
                        buffer_write(ilda_buffer,buffer_u16,0);
                        buffer_write(ilda_buffer,buffer_u8,bl);
                        buffer_write(ilda_buffer,buffer_u8,c);
                        }
                    maxpoints++;
                    }
                blankprev = bl;
                }
            
            if (u = 0)
                blank = $40;
            else if (bl)
                {
                blank = $40;
                if (u == (ds_list_size(list_id)-20)/4-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            else
                {
                blank = $0;
                if (u == (ds_list_size(list_id)-20)/4-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $80;
                }
            if (blanktemp == 1)
                {
                blank = $40;
                blanktemp = 0;
                if (u == (ds_list_size(list_id)-20)/4-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            
            
            if !(((blank) and (blank != $80)) and (u != listsize-1) and (ds_list_find_value(list_id,20+(u+1)*4+2))) or (exp_optimize == 1)
                {
                //writing point
                buffer_write(ilda_buffer,buffer_u8,xpa[1]);
                buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                if (controller.exp_format == 5)
                    {
                    buffer_write(ilda_buffer,buffer_u8,blank);
                    buffer_write(ilda_buffer,buffer_u8,colour_get_blue(c));
                    buffer_write(ilda_buffer,buffer_u8,colour_get_green(c));
                    buffer_write(ilda_buffer,buffer_u8,colour_get_red(c));
                    }
                else
                    {
                    buffer_write(ilda_buffer,buffer_u16,0);
                    buffer_write(ilda_buffer,buffer_u8,blank);
                    buffer_write(ilda_buffer,buffer_u8,c);
                    }
                maxpoints++;
                }
            
            }
            
        //optimize between elements
        if (controller.exp_optimize == 1) and (i != ds_list_size(el_list)-1)
            {
            optimize_between();
            }
        }
        
    //optimize last
    if (controller.exp_optimize == 1)
        {
        optimize_last();
        }
        
    //update maxpoints
    maxpointspre = maxpoints;
    maxpointsa[0] = maxpointspre & 255;
    maxpointspre = maxpointspre >> 8;
    maxpointsa[1] = maxpointspre & 255;
    buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
    buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
    maxpointstot += maxpointspre;
    maxpoints = 0;
       
    //cleanup
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        ds_list_destroy(ds_list_find_value(el_list,i));
        }
    ds_list_destroy(el_list);  
    }
    

//null header
buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
buffer_write(ilda_buffer,buffer_u8,$4C);
buffer_write(ilda_buffer,buffer_u8,$44);
buffer_write(ilda_buffer,buffer_u8,$41);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,controller.exp_format);
buffer_write(ilda_buffer,buffer_u8,ord('L')); //name
buffer_write(ilda_buffer,buffer_u8,ord('S'));
buffer_write(ilda_buffer,buffer_u8,ord('G'));
buffer_write(ilda_buffer,buffer_u8,ord('e'));
buffer_write(ilda_buffer,buffer_u8,ord('n'));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord('G')); //author
buffer_write(ilda_buffer,buffer_u8,ord('i'));
buffer_write(ilda_buffer,buffer_u8,ord('t'));
buffer_write(ilda_buffer,buffer_u8,ord('l'));
buffer_write(ilda_buffer,buffer_u8,ord('e'));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord('M'));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u16,0); //maxpoints
buffer_write(ilda_buffer,buffer_u16,0); //frame
buffer_write(ilda_buffer,buffer_u16,0); //maxframes
buffer_write(ilda_buffer,buffer_u8,0); //scanner
buffer_write(ilda_buffer,buffer_u8,0); //0

ds_map_destroy(c_map);

//remove excess size
buffer_resize(ilda_buffer,buffer_tell(ilda_buffer));

//export
buffer_save(ilda_buffer,file_loc);
show_message_async("ILDA file (format "+string(controller.exp_format)+") exported to "+string(file_loc));

buffer_delete(ilda_buffer);
