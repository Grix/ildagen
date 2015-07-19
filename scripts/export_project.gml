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
    buffer_write(ilda_buffer,buffer_u8,$5);
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
    
    //check which should be drawn
    for (k = 0; k < ds_list_size(layer_list); k++)
        {
        layer = ds_list_find_value(layer_list, k);
        for (m = 0; m < ds_list_size(layer); m++)
            {
            objectlist = ds_list_find_value(layer,m);
            
            infolist =  ds_list_find_value(objectlist,2);
            frametime = round(ds_list_find_value(objectlist,0));
            object_length = ds_list_find_value(infolist,0);
            object_maxframes = ds_list_find_value(infolist,2);
            
            if (correctframe != clamp(correctframe, frametime, frametime+object_length))
                continue;
            
            //yup, draw object
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
                    
            }
        
        }
    
    //write to ilda buffer
    if (!ds_list_size(el_list)) 
        {
        optimize_middle3();
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
        
        listsize = ((ds_list_size(list_id)-50)/6);
        
        var blankprev = 0;
        for (u = 0; u < listsize; u++)
            {
            //getting values from element list
            
            bl = ds_list_find_value(list_id,50+u*6+2);
            
            xp = xo+ds_list_find_value(list_id,50+u*6+0);
            yp = $ffff-(yo+ds_list_find_value(list_id,50+u*6+1));
            if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
                {
                blanktemp = 1;
                continue;
                }
            
            b = ds_list_find_value(list_id,50+u*6+3);
            if (is_undefined(b) and bl) {b = 0}
            g = ds_list_find_value(list_id,50+u*6+4);
            if (is_undefined(g) and bl) {g = 0}
            r = ds_list_find_value(list_id,50+u*6+5);
            if (is_undefined(r) and bl) {r = 0}
            
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
                repeat (3)
                    {
                    //writing point
                    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
                    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                    buffer_write(ilda_buffer,buffer_u8,bl);
                    buffer_write(ilda_buffer,buffer_u8,b);
                    buffer_write(ilda_buffer,buffer_u8,g);
                    buffer_write(ilda_buffer,buffer_u8,r);
                    maxpoints++;
                    }
                blankprev = bl;
                }
            
            if (u = 0)
                blank = $40;
            else if (bl)
                {
                blank = $40;
                if (u == (ds_list_size(list_id)-50)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            else
                {
                blank = $0;
                if (u == (ds_list_size(list_id)-50)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $80;
                }
            if (blanktemp == 1)
                {
                blank = $40;
                blanktemp = 0;
                if (u == (ds_list_size(list_id)-50)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            
            
            if !(((blank) and (blank != $80)) and (u != listsize-1) and (ds_list_find_value(list_id,50+(u+1)*6+2))) or (controller.exp_optimize == 1)
                {
                //writing point
                buffer_write(ilda_buffer,buffer_u8,xpa[1]);
                buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                buffer_write(ilda_buffer,buffer_u8,blank);
                buffer_write(ilda_buffer,buffer_u8,b);
                buffer_write(ilda_buffer,buffer_u8,g);
                buffer_write(ilda_buffer,buffer_u8,r);
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
        
        
    //cleanup
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        ds_list_destroy(ds_list_find_value(el_list,i));
        }
    ds_list_destroy(el_list);  
      
    //update maxpoints
    maxpointspre = maxpoints;
    maxpointsa[0] = maxpoints & 255;
    maxpoints = maxpoints >> 8;
    maxpointsa[1] = maxpoints & 255;
    buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
    buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
    maxpointstot += maxpointspre;
    maxpoints = 0;
    }
    

//null header
buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
buffer_write(ilda_buffer,buffer_u8,$4C);
buffer_write(ilda_buffer,buffer_u8,$44);
buffer_write(ilda_buffer,buffer_u8,$41);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$5);
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

//remove excess size
buffer_resize(ilda_buffer,buffer_tell(ilda_buffer));

//export
if (file_exists("temp/"+filename_name(file_loc)))
    file_delete("temp/"+filename_name(file_loc));
if (FS_file_exists(file_loc))
    FS_file_delete(file_loc);
buffer_save(ilda_buffer,"temp/"+filename_name(file_loc));
FS_file_copy(controller.FStemp+filename_name(file_loc),file_loc);

if (FS_file_exists(file_loc))
    {
    binfile = FS_file_bin_open(file_loc,0);
    binfilesize = FS_file_bin_size(binfile);
    FS_file_bin_close(binfile);
    if (binfilesize == buffer_get_size(ilda_buffer))
        show_message_async("ILDA file saved.");
    else
        {
        show_message_async("Problem saving file: Did not pass integrity test. May be corrupt, you might want to try again.");
        }
    }
else
    show_message_async("Could not save file. May not have access rights, try a different folder.");

buffer_delete(ilda_buffer);
