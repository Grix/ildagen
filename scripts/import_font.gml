with(controller)
    {
    filename = get_open_filename_ext("ILDA files|*.ild","",program_directory,"Select ILDA font file")
    if (filename != "")
        {
        ild_filename = FS_file_bin_open(filename,0);
        file_size = FS_file_bin_size(ild_filename);
        FS_file_bin_close(ild_filename);
        tempname = FS_unique_fname(working_directory,".ild");
        FS_file_copy(filename,tempname);
        //if (fastload)
         //   {
        ild_file = buffer_create(file_size,buffer_fast,1);
        buffer_load_ext(ild_file,tempname,0);
        }
    else
        {
        return 0;
        }
        
        
    i = 0;
    if !is_wrong($49)
        return 0;i++;
    if !is_wrong($4C)
        return 0;i++; 
    if !is_wrong($44) 
        return 0;i++;
    if !is_wrong($41) 
        return 0;i++;
    if !is_wrong($0)
        return 0;i++;
    if !is_wrong($0)
        return 0;i++;
    if !is_wrong($0)
        return 0;i=0;
    
    
    filename = "";
    
    i = 0;
    format = 0;
        
    ild_list = ds_list_create();
    
    read_ilda_header_first();
    read_ilda_frame();
    
    read_ilda_work();
    
    if (ds_list_size(ild_list) < 94)
        show_message_async("Not enough frames in ilda file. Are you sure this is a font file?"); 
    else   
        ds_list_copy(font_list,ild_list);
        
    //interpolate
    for (i = 0; i < ds_list_size(font_list); i++)
        {
        new_list = ds_list_find_value(font_list,i);
        checkpoints = ((ds_list_size(new_list)-50)/6);
        
        for (j = 0; j < (checkpoints-1);j++)
            {
            temppos = 50+j*6;
            
            if  (ds_list_find_value(new_list,temppos+8) == 1)
                continue;
                
            if  (ds_list_find_value(new_list,temppos+9) == 0) &&
                (ds_list_find_value(new_list,temppos+10) == 0) &&
                (ds_list_find_value(new_list,temppos+11) == 0)
                    {
                    //show_debug_message("black")
                    ds_list_replace(new_list,temppos+2,1);
                    continue;
                    }
                
            length = point_distance( ds_list_find_value(new_list,temppos)
                                    ,ds_list_find_value(new_list,temppos+1)
                                    ,ds_list_find_value(new_list,temppos+6)
                                    ,ds_list_find_value(new_list,temppos+7));
            
            if (length < 2000*phi) continue;
            
            steps = length / 2000;
            stepscount = round(steps-1);
            tempx0 = ds_list_find_value(new_list,temppos);
            tempy0 = ds_list_find_value(new_list,temppos+1);
            tempvectx = (ds_list_find_value(new_list,temppos+6)-tempx0)/steps;
            tempvecty = (ds_list_find_value(new_list,temppos+7)-tempy0)/steps;
            tempblank = ds_list_find_value(new_list,temppos+8);
            tempc1 = ds_list_find_value(new_list,temppos+9);
            tempc2 = ds_list_find_value(new_list,temppos+10);
            tempc3 = ds_list_find_value(new_list,temppos+11);
            //if (i == 0)
            //show_debug_message("length: "+string(length))     
                   
            repeat(floor(stepscount))
                {
                newx = tempx0+tempvectx*(stepscount);
                newy = tempy0+tempvecty*(stepscount);
                ds_list_insert(new_list,temppos+6,tempc3);
                ds_list_insert(new_list,temppos+6,tempc2);
                ds_list_insert(new_list,temppos+6,tempc1);
                ds_list_insert(new_list,temppos+6,tempblank);
                ds_list_insert(new_list,temppos+6,newy);
                ds_list_insert(new_list,temppos+6,newx);
                //show_debug_message(newx);
                j++;
                checkpoints++;
                stepscount--;
                }
            
            }
        }
        
    buffer_delete(ild_file);
    ds_list_destroy(ild_list);
        
    el_id++;
    }
return 1;
