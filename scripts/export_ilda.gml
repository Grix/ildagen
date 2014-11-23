//exports every element into an ilda file
placing_status = 0;

ilda_buffer = buffer_create(1,buffer_grow,1);
file_loc = get_save_filename("*.ild","out.ild");
if (file_loc == "")
    exit;
    
    
maxpoints = 0;
frame = 0;

maxpointstot = 0;

maxframespost = maxframes;
maxframesa[0] = maxframespost & 255;
maxframespost = maxframespost >> 8;
maxframesa[1] = maxframespost & 255;

for (j = 0; j < maxframes;j++)
    {
    el_list = ds_list_find_value(frame_list,j);
    ds_list_sort(el_list,0);
    
    buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
    buffer_write(ilda_buffer,buffer_u8,$4C);
    buffer_write(ilda_buffer,buffer_u8,$44);
    buffer_write(ilda_buffer,buffer_u8,$41);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$5);
    buffer_write(ilda_buffer,buffer_u8,ord('i')); //name
    buffer_write(ilda_buffer,buffer_u8,ord('l'));
    buffer_write(ilda_buffer,buffer_u8,ord('d'));
    buffer_write(ilda_buffer,buffer_u8,ord('a'));
    buffer_write(ilda_buffer,buffer_u8,ord('G'));
    buffer_write(ilda_buffer,buffer_u8,ord('e'));
    buffer_write(ilda_buffer,buffer_u8,ord('n'));
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
    buffer_write(ilda_buffer,buffer_u16,j); //frame
    buffer_write(ilda_buffer,buffer_u8,maxframesa[1]); //maxframes
    buffer_write(ilda_buffer,buffer_u8,maxframesa[0]); 
    buffer_write(ilda_buffer,buffer_u8,0); //scanner
    buffer_write(ilda_buffer,buffer_u8,0); //0
    
    //optimize first
    if (exp_optimize == 1)
        {
        xo = ds_list_find_value(ds_list_find_value(el_list,0),0);
        yo = ds_list_find_value(ds_list_find_value(el_list,0),1);
        xpe = xo+ds_list_find_value(ds_list_find_value(el_list,0),10+0*6+0);
        ype = $ffff-(yo+ds_list_find_value(ds_list_find_value(el_list,0),10+0*6+1));
        
        opt_dist = point_distance($ffff/2,$ffff/2,xpe,ype);
        opt_vectorx = ($ffff/2-xpe)/opt_dist;
        opt_vectory = ($ffff/2-ype)/opt_dist;
        
        /*for (m = 0;m > 3;m++)
            {
            //writing point
            buffer_write(ilda_buffer,buffer_u8,);
            buffer_write(ilda_buffer,buffer_u8,xpa[0]);
            buffer_write(ilda_buffer,buffer_u8,ypa[1]);
            buffer_write(ilda_buffer,buffer_u8,ypa[0]);
            buffer_write(ilda_buffer,buffer_u8,$40);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            maxpoints++;
            }*/
        
        trav = -4096;    
        for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
            {
            xp = $ffff/2+opt_vectorx*trav_dist;
            yp = $ffff/2+opt_vectory*trav_dist;
            
            if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
                {
                continue;
                }
            
            xp -= $8000;
            yp -= $8000;
            xpa[0] = xp & 255;
            xp = xp >> 8;
            xpa[1] = xp & 255;
            ypa[0] = yp & 255;
            yp = yp >> 8;
            ypa[1] = yp & 255;
        
            
            
            //writing point
            buffer_write(ilda_buffer,buffer_u8,xpa[1]);
            buffer_write(ilda_buffer,buffer_u8,xpa[0]);
            buffer_write(ilda_buffer,buffer_u8,ypa[1]);
            buffer_write(ilda_buffer,buffer_u8,ypa[0]);
            buffer_write(ilda_buffer,buffer_u8,$40);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            maxpoints++;
            }
        }
    
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        list_id = ds_list_find_value(el_list,i);
        
        xo = ds_list_find_value(list_id,0);
        yo = ds_list_find_value(list_id,1);
        
        blanktemp = 0;
        
        //TODO if just one
        
        listsize = ((ds_list_size(list_id)-10)/6);
        
        
        for (u = 0; u < listsize; u++)
            {
            //getting values from element list
            xp = xo+ds_list_find_value(list_id,10+u*6+0);
            yp = $ffff-(yo+ds_list_find_value(list_id,10+u*6+1));
            if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
                {
                blanktemp = 1;
                continue;
                }
        
            
            bl = ds_list_find_value(list_id,10+u*6+2);
            b = ds_list_find_value(list_id,10+u*6+3);
            if (is_undefined(b) and bl) {b = 0}
            g = ds_list_find_value(list_id,10+u*6+4);
            if (is_undefined(g) and bl) {g = 0}
            r = ds_list_find_value(list_id,10+u*6+5);
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
            
            if (u = 0)
                blank = $40;
            else if (bl)
                {
                blank = $40;
                if (u == (ds_list_size(list_id)-10)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            else
                {
                blank = $0;
                if (u == (ds_list_size(list_id)-10)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $80;
                }
            if (blanktemp == 1)
                {
                blank = $40;
                blanktemp = 0;
                if (u == (ds_list_size(list_id)-10)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            
            
            if !(((blank) and (blank != $80)) and (u != listsize-1) and (ds_list_find_value(list_id,10+(u+1)*6+2))) or (exp_optimize == 1)
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
        if (exp_optimize == 1) and (i != ds_list_size(el_list)-1)
            {
            xpeprev = xpe;
            ypeprev = ype;
            
            list_id = ds_list_find_value(el_list,i+1);
            xo = ds_list_find_value(list_id,0);
            yo = ds_list_find_value(list_id,1);
            xpe = xo+ds_list_find_value(list_id,10+0*6+0);
            ype = $ffff-(yo+ds_list_find_value(list_id,10+0*6+1));
            
            
            opt_dist = point_distance(xpeprev,ypeprev,xpe,ype);
            opt_vectorx = (xpe-xpeprev)/opt_dist;
            opt_vectory = (ype-ypeprev)/opt_dist;
            
            /*for (m = 0;m > 3;m++)
                {
                //writing point
                buffer_write(ilda_buffer,buffer_u8,);
                buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                buffer_write(ilda_buffer,buffer_u8,$40);
                buffer_write(ilda_buffer,buffer_u8,0);
                buffer_write(ilda_buffer,buffer_u8,0);
                buffer_write(ilda_buffer,buffer_u8,0);
                maxpoints++;
                }*/
            
            trav = -4096;    
            for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
                {
                xp = xpe+opt_vectorx*trav_dist;
                yp = ype+opt_vectory*trav_dist;
                
                if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
                {
                continue;
                }
                
                xp -= $8000;
                yp -= $8000;
                xpa[0] = xp & 255;
                xp = xp >> 8;
                xpa[1] = xp & 255;
                ypa[0] = yp & 255;
                yp = yp >> 8;
                ypa[1] = yp & 255;
                
                //writing point
                buffer_write(ilda_buffer,buffer_u8,xpa[1]);
                buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                buffer_write(ilda_buffer,buffer_u8,$40);
                buffer_write(ilda_buffer,buffer_u8,0);
                buffer_write(ilda_buffer,buffer_u8,0);
                buffer_write(ilda_buffer,buffer_u8,0);
                maxpoints++;
                }
            }
        }
        
    //optimize last
    if (exp_optimize == 1)
        {
        xpeprev = xpe;
        ypeprev = ype;
        
        opt_dist = point_distance($ffff/2,$ffff/2,xpe,ype);
        opt_vectorx = (xpeprev-$ffff/2)/opt_dist;
        opt_vectory = (ypeprev-$ffff/2)/opt_dist;
        
        /*for (m = 0;m > 3;m++)
            {
            //writing point
            buffer_write(ilda_buffer,buffer_u8,);
            buffer_write(ilda_buffer,buffer_u8,xpa[0]);
            buffer_write(ilda_buffer,buffer_u8,ypa[1]);
            buffer_write(ilda_buffer,buffer_u8,ypa[0]);
            buffer_write(ilda_buffer,buffer_u8,$40);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            maxpoints++;
            }*/
        
        trav = -4096;    
        for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
            {
            xp = xpeprev+opt_vectorx*trav_dist;
            yp = ypeprev+opt_vectory*trav_dist;
            
            if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
                {
                continue;
                }
            
            xp -= $8000;
            yp -= $8000;
            xpa[0] = xp & 255;
            xp = xp >> 8;
            xpa[1] = xp & 255;
            ypa[0] = yp & 255;
            yp = yp >> 8;
            ypa[1] = yp & 255;
            
            //writing point
            buffer_write(ilda_buffer,buffer_u8,xpa[1]);
            buffer_write(ilda_buffer,buffer_u8,xpa[0]);
            buffer_write(ilda_buffer,buffer_u8,ypa[1]);
            buffer_write(ilda_buffer,buffer_u8,ypa[0]);
            buffer_write(ilda_buffer,buffer_u8,$40);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            buffer_write(ilda_buffer,buffer_u8,0);
            maxpoints++;
            }
        }
        
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
buffer_write(ilda_buffer,buffer_u8,ord('i')); //name
buffer_write(ilda_buffer,buffer_u8,ord('l'));
buffer_write(ilda_buffer,buffer_u8,ord('d'));
buffer_write(ilda_buffer,buffer_u8,ord('a'));
buffer_write(ilda_buffer,buffer_u8,ord('G'));
buffer_write(ilda_buffer,buffer_u8,ord('e'));
buffer_write(ilda_buffer,buffer_u8,ord('n'));
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
buffer_save(ilda_buffer,file_loc);
show_message("ILDA file exported, "+string(maxpointstot)+" points total");
buffer_delete(ilda_buffer);

frame = 0;
