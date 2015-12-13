with(controller)
    {
    filename = get_open_filename_ext("ILDA font file|*.ild|All files|*","",program_directory,"Select ILDA font file")
    if (filename != "") and (!is_undefined(filename)) and (is_string(filename))
        {
        ild_file = buffer_load(filename);
        file_size = buffer_get_size(ild_file);
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
    
    ds_list_copy(font_list,ild_list);
    
    buffer_delete(ild_file);
    ds_list_destroy(ild_list);
        
    //interpolate
    for (i = 0; i < ds_list_size(font_list); i++)
        {
        new_list = ds_list_find_value(font_list,i);
        checkpoints = ((ds_list_size(new_list)-20)/4);
        
        for (j = 0; j < (checkpoints-1);j++)
            {
            temppos = 20+j*4;
            
            //if  (ds_list_find_value(new_list,temppos+8) == 1)
            //    continue;
                
            if  (ds_list_find_value(new_list,temppos+7) == 0) &&
                (ds_list_find_value(new_list,temppos+8) == 0) &&
                (ds_list_find_value(new_list,temppos+9) == 0)
                    {
                    ds_list_replace(new_list,temppos+2,1);
                    continue;
                    }
                
            length = point_distance( ds_list_find_value(new_list,temppos)
                                    ,ds_list_find_value(new_list,temppos+1)
                                    ,ds_list_find_value(new_list,temppos+4)
                                    ,ds_list_find_value(new_list,temppos+5));
            
            if (length < 800*phi) continue;
            
            steps = length / 800;
            stepscount = round(steps-1);
            tempx0 = ds_list_find_value(new_list,temppos);
            tempy0 = ds_list_find_value(new_list,temppos+1);
            tempvectx = (ds_list_find_value(new_list,temppos+4)-tempx0)/steps;
            tempvecty = (ds_list_find_value(new_list,temppos+5)-tempy0)/steps;
            tempblank = ds_list_find_value(new_list,temppos+6);
            tempc = ds_list_find_value(new_list,temppos+7);
                   
            repeat(floor(stepscount))
                {
                newx = tempx0+tempvectx*(stepscount);
                newy = tempy0+tempvecty*(stepscount);
                ds_list_insert(new_list,temppos+4,tempc);
                ds_list_insert(new_list,temppos+4,tempblank);
                ds_list_insert(new_list,temppos+4,newy);
                ds_list_insert(new_list,temppos+4,newx);
                j++;
                checkpoints++;
                stepscount--;
                }
            
            }
        }
        
    el_id++;
    font_type = 0;
    }
return 1;
