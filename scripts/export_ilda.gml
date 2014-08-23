//exports every element into an ilda file
placing = "";
placing_status = 0;

ilda_buffer = buffer_create(1,buffer_grow,1);
file_loc = get_save_filename("*.ild","");
if (file_loc == "")
    exit;

maxpoints = 0;
frame = 0;

maxframes = 1;
maxframesa[0] = maxframes & 255;
maxframes = maxframes >> 8;
maxframesa[1] = maxframes & 255;

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
buffer_write(ilda_buffer,buffer_u16,frame); //frame
buffer_write(ilda_buffer,buffer_u8,maxframesa[1]); //maxframes
buffer_write(ilda_buffer,buffer_u8,maxframesa[0]); 
buffer_write(ilda_buffer,buffer_u8,0); //scanner
buffer_write(ilda_buffer,buffer_u8,0); //0

for (i = 0;i < ds_list_size(el_list);i++)
    {
    list_id = ds_list_find_value(el_list,i);
    
    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
    
    //TODO if just one
    for (u = 0; u < ((ds_list_size(list_id)-10)/6)-1; u++)
        {
        maxpoints++;
        
        //getting values from element list
        xp = xo+ds_list_find_value(list_id,10+u*6+0);
        yp = yo+ds_list_find_value(list_id,10+u*6+1);
        bl = ds_list_find_value(list_id,10+u*6+2);
        b = ds_list_find_value(list_id,10+u*6+3);
        g = ds_list_find_value(list_id,10+u*6+4);
        r = ds_list_find_value(list_id,10+u*6+5);
        
        //adjusting values for writing to buffer
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
            if (u == (ds_list_size(list_id)-10)/6-1)
                blank = $C0;
            }
        else
            {
            blank = $0;
            if (u == (ds_list_size(list_id)-10)/6-1)
                blank = $80;
            }
        
        //writing point
        buffer_write(ilda_buffer,buffer_u8,xpa[1]);
        buffer_write(ilda_buffer,buffer_u8,xpa[0]);
        buffer_write(ilda_buffer,buffer_u8,ypa[1]);
        buffer_write(ilda_buffer,buffer_u8,ypa[0]);
        buffer_write(ilda_buffer,buffer_u8,blank);
        buffer_write(ilda_buffer,buffer_u8,b);
        buffer_write(ilda_buffer,buffer_u8,g);
        buffer_write(ilda_buffer,buffer_u8,r);
        
        }
    
    }
    
//update maxpoints
maxpointsa[0] = maxpoints & 255;
maxpoints = maxpoints >> 8;
maxpointsa[1] = maxpoints & 255;
buffer_poke(ilda_buffer,24,buffer_u8,maxpointsa[1]);
buffer_poke(ilda_buffer,25,buffer_u8,maxpointsa[0]);

//null header
buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0000
buffer_write(ilda_buffer,buffer_u8,$4C);
buffer_write(ilda_buffer,buffer_u8,$44);
buffer_write(ilda_buffer,buffer_u8,$41);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
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

//export
buffer_save(ilda_buffer,file_loc);
show_message("ILDA file exported, "+string(maxpoints)+" points in frame");
buffer_delete(ilda_buffer);
