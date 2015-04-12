//reads a hershey font file and makes it the active font

ds_map_destroy(font_map);
font_map = ds_map_create();

while (!FS_file_text_eof(hershey_file))
    {
    frame_list_parse = ds_list_create();

    glyphno = 0;
    if !hershey_error() return 0;
    glyphno += 10000*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += 1000*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += 100*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += 10*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
      
    maxglyphpoints = 0;
    maxglyphpoints += 100*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    maxglyphpoints += 10*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    maxglyphpoints += real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0); 
    ds_list_add(frame_list_parse,el_id); //id
    repeat (40) ds_list_add(frame_list_parse,0); 
    //show_message_async(glyphno)
    blank = 0;
    
    repeat(maxglyphpoints)
        {
        nextcharx = FS_file_text_read_char(hershey_file,1);
        nextchary = FS_file_text_read_char(hershey_file,1);
        if (nextcharx == ' ') and (nextchary == 'R')
            {
            blank = 1;
            continue;
            }
        nextpointx = (ord(nextcharx) - ord('R'))*2000;
        nextpointy = (ord(nextchary) - ord('R'))*2000;
        
        ds_list_add(frame_list_parse,nextpointx);
        ds_list_add(frame_list_parse,nextpointy);
        ds_list_add(frame_list_parse,blank);
        //show_message(nextcharx);
        //show_message(blank)
        blank = 0;
        ds_list_add(frame_list_parse,255);
        ds_list_add(frame_list_parse,255);
        ds_list_add(frame_list_parse,255);
        
        }
    
    ds_map_add(font_map,glyphno,frame_list_parse);
    FS_file_text_readln(hershey_file);
    }
el_id++;

//interpolate
for (i = 0; i < ds_map_size(font_map); i++)
    {
    if (i = 0)
        {
        currid = ds_map_find_first(font_map);
        new_list = ds_map_find_value(font_map,currid);
        }
    else
        {
        currid = ds_map_find_next(font_map,currid);
        new_list = ds_map_find_value(font_map,currid);
        }
        
    checkpoints = ((ds_list_size(new_list)-50)/6);
    
    for (j = 0; j < (checkpoints-1);j++)
        {
        temppos = 50+j*6;
        
        if  (ds_list_find_value(new_list,temppos+8) == 1)
            continue;
            
        length = point_distance( ds_list_find_value(new_list,temppos)
                                ,ds_list_find_value(new_list,temppos+1)
                                ,ds_list_find_value(new_list,temppos+6)
                                ,ds_list_find_value(new_list,temppos+7));
        
        if (length < opt_maxdist*phi) continue;
        
        steps = length / opt_maxdist;
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
            j++;
            checkpoints++;
            stepscount--;
            }
        
        }
    }
    
//show_message(ds_list_size(font_list))
FS_file_text_close(hershey_file);
font_type = 1;
return 1;
