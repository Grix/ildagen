for (j = global.loading_current; j < global.loading_end;j++)
{   
    el_list = ds_list_find_value(frame_list,j);
    
    framepost = j;
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
    buffer_write(ilda_buffer,buffer_u8,exp_format);
    buffer_write(ilda_buffer,buffer_u8,ord("L")); //name
    buffer_write(ilda_buffer,buffer_u8,ord("S"));
    buffer_write(ilda_buffer,buffer_u8,ord("G"));
    buffer_write(ilda_buffer,buffer_u8,ord("e"));
    buffer_write(ilda_buffer,buffer_u8,ord("n"));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord("G")); //author
    buffer_write(ilda_buffer,buffer_u8,ord("i"));
    buffer_write(ilda_buffer,buffer_u8,ord("t"));
    buffer_write(ilda_buffer,buffer_u8,ord("l"));
    buffer_write(ilda_buffer,buffer_u8,ord("e"));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord("M"));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    maxpointspos = buffer_tell(ilda_buffer);
    buffer_write(ilda_buffer,buffer_u16,0); //maxpoints
    buffer_write(ilda_buffer,buffer_u8,framea[1]); //frame
    buffer_write(ilda_buffer,buffer_u8,framea[0]); //frame
    buffer_write(ilda_buffer,buffer_u8,maxframesa[1]); //maxframes
    buffer_write(ilda_buffer,buffer_u8,maxframesa[0]); 
    buffer_write(ilda_buffer,buffer_u8,0); //scanner
    buffer_write(ilda_buffer,buffer_u8,0); //0
    
    assemble_frame_ilda();
    
    if (get_timer()-global.loadingtimeprev >= 100000)
    {
        j++;
        global.loading_current = j;
        global.loadingtimeprev = get_timer();
        return 0;
    }
}
    

//null header
buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
buffer_write(ilda_buffer,buffer_u8,$4C);
buffer_write(ilda_buffer,buffer_u8,$44);
buffer_write(ilda_buffer,buffer_u8,$41);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,exp_format);
buffer_write(ilda_buffer,buffer_u8,ord("L")); //name
buffer_write(ilda_buffer,buffer_u8,ord("S"));
buffer_write(ilda_buffer,buffer_u8,ord("G"));
buffer_write(ilda_buffer,buffer_u8,ord("e"));
buffer_write(ilda_buffer,buffer_u8,ord("n"));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord("G")); //author
buffer_write(ilda_buffer,buffer_u8,ord("i"));
buffer_write(ilda_buffer,buffer_u8,ord("t"));
buffer_write(ilda_buffer,buffer_u8,ord("l"));
buffer_write(ilda_buffer,buffer_u8,ord("e"));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord("M"));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u16,0); //maxpoints
buffer_write(ilda_buffer,buffer_u16,0); //frame
buffer_write(ilda_buffer,buffer_u16,0); //maxframes
buffer_write(ilda_buffer,buffer_u8,0); //scanner
buffer_write(ilda_buffer,buffer_u8,0); //0

ds_map_destroy(c_map);

//remove excess size
buffersize = buffer_tell(ilda_buffer);

filesaver_clearArray();

error = 0;
for (i = 0;i < buffersize;i++)
{
    if (!filesaver_toArray(i,buffer_peek(ilda_buffer,i,buffer_u8)))
    {
        if (!error) show_message_new("Error filling file with data, may not save correctly!");
        error = 1;
    }
}
    
filesaver_save(file_loc);

var t_time = get_timer();
while ((get_timer() - t_time) > 4095)
    j = 0;
       
show_message_new("ILDA file (format "+string(exp_format)+") exported to "+string(file_loc));

buffer_delete(ilda_buffer);

global.loading_exportildahtml5 = 0;
room_goto(rm_ilda);
