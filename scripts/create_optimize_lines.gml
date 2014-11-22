//creates an element from whatever has been done on the screen

resolutionpre = resolution;
resolution = 1024;
    

framepre = frame;
blankmodepre = blankmode;
blankmode = "dash";

frame = 0;
repeat (maxframes)
    {
    
    gaussoffsetx = 0;
    gaussoffsety = 0;

    blank_freq_r = blank_freq;
    blank_period_r = blank_period;
    blank_dc_r = 0;
    blank_offset_r = degtorad(blank_offset);
    color_freq_r = color_freq;
    color_period_r = color_period;
    color_dc_r = 1;
    color_offset_r = degtorad(color_offset);
    color1_r = c_black;
    color2_r = c_black;
    enddotscolor_r = enddotscolor;
    wave_period_r = wave_period;
    wave_offset_r = degtorad(wave_offset);
    wave_amp_r = wave_amp;
    
    listsize_el = ds_list_size(ds_list_find_value(frame_list,frame));
    list_el = ds_list_find_value(frame_list,frame);
    
    for (m = 0;m < (listsize_el+1); m++)
        {
        new_list = ds_list_create();
        
        if (m != listsize_el)
            list_indel = ds_list_find_value(list_el,m);
        if (m)
            list_indelpre = ds_list_find_value(list_el,m-1);
        
        if (m == 0)
            {
            endx_r = ds_list_find_value(list_indel,0)+ds_list_find_value(list_indel,ds_list_size(list_indel)-6);
            endy_r = ds_list_find_value(list_indel,1)+ds_list_find_value(list_indel,ds_list_size(list_indel)-5);
            startposx_r = $ffff/2;
            startposy_r  = $ffff/2;
            }
        else if (m == (listsize_el) )
            {
            endx_r = $ffff/2;
            endy_r = $ffff/2;
            startposx_r = ds_list_find_value(list_indelpre,0)+ds_list_find_value(list_indelpre,10);
            startposy_r  = ds_list_find_value(list_indelpre,1)+ds_list_find_value(list_indelpre,11);
            }
        else
            {
            endx_r = ds_list_find_value(list_indel,0)+ds_list_find_value(list_indel,ds_list_size(list_indel)-6);
            endy_r = ds_list_find_value(list_indel,1)+ds_list_find_value(list_indel,ds_list_size(list_indel)-5);
            startposx_r = ds_list_find_value(list_indelpre,0)+ds_list_find_value(list_indelpre,10);
            startposy_r  = ds_list_find_value(list_indelpre,1)+ds_list_find_value(list_indelpre,11);
            }
        
        ds_list_add(new_list,startposx_r/128); //origo x
        ds_list_add(new_list,startposy_r/128); //origo y
        ds_list_add(new_list,endx_r/128); //end x
        ds_list_add(new_list,endy_r/128); //end y
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,-2);
        
        if (placing == "line") //create a line
            create_line();
            
        ds_list_insert(list_el,m*2,new_list);
        
        }
    
    frame++;
    }
    
frame = framepre;

resolution = resolutionpre;

