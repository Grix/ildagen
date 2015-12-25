//exports every element into an ilda file
placing_status = 0;

ilda_buffer = buffer_create(1,buffer_grow,1);

log("----")
log(get_timer())
maxpoints = 0;
maxpointstot = 0;

maxframespost = maxframes;
maxframesa[0] = maxframespost & 255;
maxframespost = maxframespost >> 8;
maxframesa[1] = maxframespost & 255;

c_n = 0;
c_map = ds_map_create();

controller.opt_warning_flag = 0;

for (j = 0; j < maxframes;j++)
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
    
    if (!ds_list_size(el_list)) 
        {
        optimize_middle();
        //update maxpoints
        maxpoints = maxpointswanted;
        maxpointsa[0] = maxpoints & 255;
        maxpoints = maxpoints >> 8;
        maxpointsa[1] = maxpoints & 255;
        buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
        buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
        continue;
        }
    
    if (export_makeframe_pass_list() == 0)
        {
        optimize_middle();
        //update maxpoints
        maxpoints = maxpointswanted;
        maxpointsa[0] = maxpoints & 255;
        maxpoints = maxpoints >> 8;
        maxpointsa[1] = maxpoints & 255;
        buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
        buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
        continue;
        }
    
    if (controller.exp_optimize)
        export_makeframe_pass_int();
        
    export_framelist_to_buffer();
        
    //update maxpoints
    maxpointsa[0] = maxpoints & 255;
    maxpoints = maxpoints >> 8;
    maxpointsa[1] = maxpoints & 255;
    buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
    buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
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
buffer_write(ilda_buffer,buffer_u8,exp_format);
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
buffersize = buffer_tell(ilda_buffer);

filesaver_clearArray();

error = 0;
for (i = 0;i < buffersize;i++)
    {
    if (!filesaver_toArray(i,buffer_peek(ilda_buffer,i,buffer_u8)))
        {
        if (!error) show_message_async("Error filling file with data, may not save correctly!");
        error = 1;
        }
    }
    
filesaver_save(file_loc);
    
buffer_delete(ilda_buffer);
